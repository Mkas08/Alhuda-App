from datetime import datetime, date, timedelta
from typing import Optional
from uuid import UUID
from zoneinfo import ZoneInfo
from sqlalchemy import select, func, and_, desc
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.progress import UserStats, VerseReadHistory
from app.models.user import User

class StreakService:
    @staticmethod
    async def get_user_stats(db: AsyncSession, user_id: UUID) -> UserStats:
        """Fetch or create user stats."""
        query = select(UserStats).where(UserStats.user_id == user_id)
        result = await db.execute(query)
        stats = result.scalar_one_or_none()
        
        if not stats:
            stats = UserStats(user_id=user_id)
            db.add(stats)
            await db.commit()
            await db.refresh(stats)
            
        return stats

    @staticmethod
    async def update_streak(db: AsyncSession, user_id: UUID, stats: UserStats):
        """
        Calculate streak based on session history using user's local timezone.
        """
        # Fetch user to get timezone
        user_query = select(User).where(User.user_id == user_id)
        user_result = await db.execute(user_query)
        user = user_result.scalar_one_or_none()
        
        timezone_str = user.timezone if user and user.timezone else "UTC"
        try:
            tz = ZoneInfo(timezone_str)
        except Exception:
            tz = ZoneInfo("UTC")

        # Current date in user's timezone
        now_local = datetime.now(tz)
        today_local = now_local.date()
        yesterday_local = today_local - timedelta(days=1)
        
        # Determine the last reading date in user's local time
        # We need to fetch recent reading history and convert to local time
        # Since we can't easily do timezone conversion in SQL for all DBs without specific functions,
        # we'll fetch the last few history items and check in python.
        
        # Get last reading
        last_read_query = (
            select(VerseReadHistory.read_at)
            .where(VerseReadHistory.user_id == user_id)
            .order_by(desc(VerseReadHistory.read_at))
            .limit(1)
        )
        last_read_result = await db.execute(last_read_query)
        last_read_utc = last_read_result.scalar_one_or_none()
        
        if not last_read_utc:
            # No history, but we just read a verse (this method is called after reading)
            # So streak is 1
            stats.current_streak = 1
            stats.longest_streak = 1
            return

        # Convert last read to local
        last_read_local = last_read_utc.replace(tzinfo=ZoneInfo("UTC")).astimezone(tz).date()
        
        # If we read today (which we likely did since we are calling this),
        # check if we also read yesterday.
        
        if last_read_local == today_local:
            # We need to check if we read yesterday to maintain streak
            # Or if stats says we have a streak, we check if it was updated yesterday?
            # Actually, `stats.current_streak` stores the values.
            # If we haven't read today yet (before this call), streak might be for yesterday.
            # But this is called AFTER adding a verse history.
            
            # Let's check if there is ANY reading for yesterday
            # We can query for range in UTC that covers yesterday in Local
            
            # Start of yesterday in Local -> UTC
            start_yesterday_local = datetime.combine(yesterday_local, datetime.min.time()).replace(tzinfo=tz)
            end_yesterday_local = datetime.combine(yesterday_local, datetime.max.time()).replace(tzinfo=tz)
            
            start_yesterday_utc = start_yesterday_local.astimezone(ZoneInfo("UTC"))
            end_yesterday_utc = end_yesterday_local.astimezone(ZoneInfo("UTC"))
            
            yesterday_query = (
                select(func.count())
                .select_from(VerseReadHistory)
                .where(and_(
                    VerseReadHistory.user_id == user_id,
                    VerseReadHistory.read_at >= start_yesterday_utc.replace(tzinfo=None),
                    VerseReadHistory.read_at <= end_yesterday_utc.replace(tzinfo=None)
                ))
            )
            yesterday_count = await db.scalar(yesterday_query)
            
            # Check if this is the FIRST reading of today
            # If we already read today, streak is already updated.
            # We need to know if we read today *before this specific verse*.
             
            # Start of today Local -> UTC
            start_today_local = datetime.combine(today_local, datetime.min.time()).replace(tzinfo=tz)
            start_today_utc = start_today_local.astimezone(ZoneInfo("UTC"))
            
            today_count_query = (
                select(func.count())
                .select_from(VerseReadHistory)
                .where(and_(
                    VerseReadHistory.user_id == user_id,
                    VerseReadHistory.read_at >= start_today_utc.replace(tzinfo=None)
                ))
            )
            today_count = await db.scalar(today_count_query)
            
            if today_count == 1: # This is the first verse read today
                if yesterday_count and yesterday_count > 0:
                    stats.current_streak += 1
                else:
                    stats.current_streak = 1 # Broken streak or new
            
            # Update longest
            if stats.current_streak > stats.longest_streak:
                stats.longest_streak = stats.current_streak
