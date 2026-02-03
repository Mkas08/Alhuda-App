from uuid import UUID
from datetime import datetime
from typing import List, Optional
from pydantic import BaseModel, ConfigDict, Field

# --- User Goal Schemas ---

class UserGoalBase(BaseModel):
    goal_type: str = Field(..., description="verse, time, or page")
    goal_value: int = Field(..., gt=0)
    preferred_times: List[str] = Field(default_factory=list, description='["after_fajr", "after_isha"]')

class UserGoalCreate(UserGoalBase):
    pass

class UserGoalUpdate(BaseModel):
    goal_type: Optional[str] = None
    goal_value: Optional[int] = Field(None, gt=0)
    preferred_times: Optional[List[str]] = None
    is_active: Optional[bool] = None

class UserGoal(UserGoalBase):
    model_config = ConfigDict(from_attributes=True)

    goal_id: UUID
    user_id: UUID
    is_active: bool
    created_at: datetime
    updated_at: datetime

# --- User Stats Schemas ---

class UserStatsBase(BaseModel):
    total_verses_read: int = 0
    total_hasanat: int = 0
    current_streak: int = 0
    longest_streak: int = 0

class UserStats(UserStatsBase):
    model_config = ConfigDict(from_attributes=True)

    user_id: UUID
    updated_at: datetime

# --- Reading Session Schemas ---

class ReadingSessionBase(BaseModel):
    start_time: datetime
    session_type: str = "spontaneous"

class ReadingSessionCreate(ReadingSessionBase):
    pass

class ReadingSessionUpdate(BaseModel):
    end_time: datetime
    total_duration_seconds: int
    verses_read: int
    hasanat_earned: int
    goal_achieved: bool

class ReadingSession(ReadingSessionBase):
    model_config = ConfigDict(from_attributes=True)

    session_id: UUID
    user_id: UUID
    end_time: Optional[datetime] = None
    total_duration_seconds: int
    verses_read: int
    hasanat_earned: int
    hasanat_earned: int
    goal_achieved: bool
    status: str
    created_at: datetime

# --- Progress Tracking Schemas ---

class ProgressUpdate(BaseModel):
    verse_id: int
    session_id: Optional[UUID] = None

class UserProgress(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    stats: UserStats
    active_goal: Optional[UserGoal] = None
    last_session: Optional[ReadingSession] = None
    completion_percentage: float = 0.0

# --- Bookmark Schemas ---

class BookmarkBase(BaseModel):
    verse_id: int
    note: Optional[str] = Field(None, max_length=500)

class BookmarkCreate(BookmarkBase):
    pass

class Bookmark(BookmarkBase):
    model_config = ConfigDict(from_attributes=True)

    bookmark_id: UUID
    user_id: UUID
    created_at: datetime
