from datetime import datetime
from typing import Optional, List
from uuid import UUID
from sqlalchemy import select, desc
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.progress import ReadingSession, VerseReadHistory, UserStats
from app.models.quran import QuranVerse
from app.schemas.progress import ProgressUpdate
from app.services.streak_service import StreakService
from app.services.goal_service import GoalService

class SessionService:
    @staticmethod
    async def get_session(db: AsyncSession, session_id: UUID) -> Optional[ReadingSession]:
        """Fetch a specific session."""
        query = select(ReadingSession).where(ReadingSession.session_id == session_id)
        result = await db.execute(query)
        return result.scalar_one_or_none()

    @staticmethod
    async def get_user_sessions(db: AsyncSession, user_id: UUID, skip: int = 0, limit: int = 100) -> List[ReadingSession]:
        """Get a list of all reading sessions for the current user."""
        query = (
            select(ReadingSession)
            .where(ReadingSession.user_id == user_id)
            .order_by(desc(ReadingSession.start_time))
            .offset(skip)
            .limit(limit)
        )
        result = await db.execute(query)
        return list(result.scalars().all())

    @staticmethod
    async def start_session(db: AsyncSession, user_id: UUID, session_type: str = "spontaneous") -> ReadingSession:
        """Start a new reading session."""
        session = ReadingSession(
            user_id=user_id,
            start_time=datetime.utcnow(),
            session_type=session_type,
            status="active"
        )
        db.add(session)
        await db.commit()
        await db.refresh(session)
        return session

    @staticmethod
    async def pause_session(db: AsyncSession, session_id: UUID, user_id: UUID) -> Optional[ReadingSession]:
        """Pause a session."""
        session = await SessionService.get_session(db, session_id)
        if not session or session.user_id != user_id:
            return None
        
        session.status = "paused"
        await db.commit()
        await db.refresh(session)
        return session

    @staticmethod
    async def resume_session(db: AsyncSession, session_id: UUID, user_id: UUID) -> Optional[ReadingSession]:
        """Resume a session."""
        session = await SessionService.get_session(db, session_id)
        if not session or session.user_id != user_id:
            return None
        
        session.status = "active"
        await db.commit()
        await db.refresh(session)
        return session

    # Refactored to trigger background task in Future
    @staticmethod
    async def end_session(db: AsyncSession, session_id: UUID, user_id: UUID, verses_read: int) -> Optional[ReadingSession]:
        """End a session. Heavy calculation should be offloaded to Celery."""
        session = await SessionService.get_session(db, session_id)
        if not session or session.user_id != user_id:
            return None
            
        session.end_time = datetime.utcnow()
        session.status = "completed"
        session.verses_read = verses_read 
        
        # Basic duration calc (Synchronous for now, will offload deep stats to Celery)
        start = session.start_time.replace(tzinfo=None)
        end = session.end_time.replace(tzinfo=None)
        session.total_duration_seconds = int((end - start).total_seconds())
        
        # Calculate stats (Ideally this goes to Celery)
        # For now, keeping it here to ensure functionality, but we will add the valid Celery trigger
        # after setting up the worker.
        from app.worker import calculate_session_stats_task
        
        # We need to commit first so the worker can read the session status
        await db.commit()
        await db.refresh(session)
        
        # Trigger Celery Task
        calculate_session_stats_task.delay(str(session_id), str(user_id))

        return session

    @staticmethod
    async def update_progress(db: AsyncSession, user_id: UUID, progress_in: ProgressUpdate) -> UserStats:
        """Record a verse read and update stats/streak."""
        # 1. Fetch verse metadata for hasanat
        verse_query = select(QuranVerse).where(QuranVerse.verse_id == progress_in.verse_id)
        verse_result = await db.execute(verse_query)
        verse = verse_result.scalar_one_or_none()
        
        if not verse:
            # Fallback if verse not found (e.g. not populated), assume 0 hasanat or handle error
            # For strictness:
            # raise ValueError("Verse not found") 
            # For robustness if DB incomplete:
            letter_count = 0
        else:
            letter_count = verse.letter_count

        # 2. Record history
        history = VerseReadHistory(
            user_id=user_id,
            verse_id=progress_in.verse_id,
            session_id=progress_in.session_id if progress_in.session_id else None
        )
        db.add(history)

        # 3. Update Session verse count if session exists
        if progress_in.session_id:
            session = await SessionService.get_session(db, progress_in.session_id)
            if session:
                session.verses_read += 1
                session.hasanat_earned += (letter_count * 10)

        # 4. Update UserStats
        stats = await StreakService.get_user_stats(db, user_id)
        stats.total_verses_read += 1
        hasanat_earned = letter_count * 10
        stats.total_hasanat += hasanat_earned
        
        # 5. Streak logic (now timezone aware)
        await StreakService.update_streak(db, user_id, stats)
        
        await db.commit()
        await db.refresh(stats)
        return stats
