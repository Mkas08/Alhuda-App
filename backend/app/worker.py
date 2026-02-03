import asyncio
from uuid import UUID
from celery import shared_task
from app.core.celery_app import celery_app
from app.database import AsyncSessionLocal
from app.services.streak_service import StreakService
from app.services.session_service import SessionService
# Note: SessionService logic for calculate_stats needs to be extracted or we need to be careful about circular imports.
# Actually, SessionService.end_session triggers this. This task should do the heavy lifting.
# But SessionService.end_session ALREADY did the basic save.
# Maybe we just want to update streaks and hasanat?
# The current SessionService.end_session does:
# 1. Update session status/time/verses (fast)
# 2. Calculate hasanat (medium)
# 3. Check goals (medium)
# 4. Update Stats/Streak (medium)
# Ideally 2,3,4 happen here.

# Ideally, we should not import SessionService if it imports worker.
# We will use a dedicated function or Service method that doesn't trigger the task.

async def process_session_stats(session_id: UUID, user_id: UUID):
    async with AsyncSessionLocal() as db:
        # Re-fetch session
        session = await SessionService.get_session(db, session_id)
        if not session:
            return

        # 1. Calculate Hasanat (if not already done or to refine it)
        # 2. Check Goals
        # 3. Update User Stats & Streak (if not done incrementally)
        
        # In our refactored SessionService.end_session, we kept the synchronous logic short?
        # Actually in the code I wrote for SessionService.end_session, I commented out the heavy parts
        # and said "Calculate stats (Ideally this goes to Celery)".
        
        # So we need to implement that logic here.
        
        # Calculate Hasanat
        from app.models.quran import QuranVerse
        from app.models.progress import VerseReadHistory
        from sqlalchemy import select, func

        q_hasanat = (
             select(func.sum(QuranVerse.letter_count * 10))
             .join(VerseReadHistory, VerseReadHistory.verse_id == QuranVerse.verse_id)
             .where(VerseReadHistory.session_id == session_id)
        )
        total_hasanat = await db.scalar(q_hasanat) or 0
        session.hasanat_earned = total_hasanat
        
        # Check Goals
        from app.services.goal_service import GoalService
        active_goal = await GoalService.get_active_goal(db, user_id)
        if active_goal:
            if active_goal.goal_type == 'verse' and session.verses_read >= active_goal.goal_value:
                session.goal_achieved = True
            elif active_goal.goal_type == 'time' and session.total_duration_seconds >= (active_goal.goal_value * 60):
                session.goal_achieved = True
        
        # Update User Stats
        stats = await StreakService.get_user_stats(db, user_id)
        # Note: totals might have been updated incrementally in update_progress?
        # If so, we just need to ensure consistency or update streak if session was long enough?
        # StreakService.update_streak is called incrementally.
        
        await db.commit()

@celery_app.task
def calculate_session_stats_task(session_id_str: str, user_id_str: str):
    """
    Background task to calculate session stats, hasanat, and check goals.
    Wraps async logic.
    """
    session_id = UUID(session_id_str)
    user_id = UUID(user_id_str)
    
    # Run async function in sync worker
    loop = asyncio.get_event_loop()
    if loop.is_running():
        # Should not happen in standard celery worker, but if using gevent/eventlet it might
        # For standard prefork/threads:
        asyncio.run(process_session_stats(session_id, user_id))
    else:
        loop.run_until_complete(process_session_stats(session_id, user_id))
