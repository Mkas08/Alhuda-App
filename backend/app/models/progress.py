from uuid import UUID, uuid4
from sqlalchemy import String, Integer, BigInteger, ForeignKey, DateTime, JSON
from sqlalchemy.orm import Mapped, mapped_column, relationship
from .base import Base, TimestampMixin
from datetime import datetime

class UserGoal(Base, TimestampMixin):
    __tablename__ = "user_goals"

    goal_id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("users.user_id"), index=True)
    goal_type: Mapped[str] = mapped_column(String(20))  # verse, time, page
    goal_value: Mapped[int] = mapped_column(Integer)
    preferred_times: Mapped[list[str]] = mapped_column(JSON)  # ["after_fajr", "after_isha"]
    is_active: Mapped[bool] = mapped_column(default=True)

class UserStats(Base, TimestampMixin):
    __tablename__ = "user_stats"

    user_id: Mapped[UUID] = mapped_column(ForeignKey("users.user_id"), primary_key=True)
    total_verses_read: Mapped[int] = mapped_column(Integer, default=0)
    total_hasanat: Mapped[int] = mapped_column(BigInteger, default=0)
    current_streak: Mapped[int] = mapped_column(Integer, default=0)
    longest_streak: Mapped[int] = mapped_column(Integer, default=0)

class ReadingSession(Base, TimestampMixin):
    __tablename__ = "reading_sessions"

    session_id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("users.user_id"), index=True)
    start_time: Mapped[datetime] = mapped_column(DateTime(timezone=True))
    end_time: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    total_duration_seconds: Mapped[int] = mapped_column(Integer, default=0)
    verses_read: Mapped[int] = mapped_column(Integer, default=0)
    hasanat_earned: Mapped[int] = mapped_column(BigInteger, default=0)
    goal_achieved: Mapped[bool] = mapped_column(default=False)
    session_type: Mapped[str] = mapped_column(String(20), default="spontaneous")  # scheduled, spontaneous
    status: Mapped[str] = mapped_column(String(20), default="active")  # active, paused, completed

class VerseReadHistory(Base, TimestampMixin):
    __tablename__ = "verse_read_history"

    history_id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("users.user_id"), index=True)
    verse_id: Mapped[int] = mapped_column(ForeignKey("quran_verses.verse_id"))
    session_id: Mapped[UUID | None] = mapped_column(ForeignKey("reading_sessions.session_id"))
    read_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), default=datetime.utcnow)

class Bookmark(Base, TimestampMixin):
    __tablename__ = "bookmarks"

    bookmark_id: Mapped[UUID] = mapped_column(primary_key=True, default=uuid4)
    user_id: Mapped[UUID] = mapped_column(ForeignKey("users.user_id"), index=True)
    verse_id: Mapped[int] = mapped_column(ForeignKey("quran_verses.verse_id"))
    note: Mapped[str | None] = mapped_column(String(500))
