from typing import Any, List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from uuid import UUID

from app.api import deps
from app.models.user import User
from app.services.streak_service import StreakService
from app.services.goal_service import GoalService
from app.services.session_service import SessionService
from app.services.bookmark_service import BookmarkService
from app.schemas.progress import UserProgress, ProgressUpdate, UserStats, Bookmark, BookmarkCreate

router = APIRouter()

@router.get("/", response_model=UserProgress)
async def get_progress_summary(
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """Get a summary of the user's progress, including stats and active goal."""
    stats = await StreakService.get_user_stats(db, current_user.user_id)
    goal = await GoalService.get_active_goal(db, current_user.user_id)
    
    # Calculate completion percentage for MVP (e.g. out of total Quran verses 6236)
    total_quran_verses = 6236
    completion_percentage = (stats.total_verses_read / total_quran_verses) * 100
    
    return {
        "stats": stats,
        "active_goal": goal,
        "completion_percentage": min(completion_percentage, 100.0)
    }

@router.post("/update", response_model=UserStats)
async def update_progress(
    *,
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
    progress_in: ProgressUpdate
) -> Any:
    """Record a verse read and update stats (hasanat, streak)."""
    try:
        return await SessionService.update_progress(db, current_user.user_id, progress_in)
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=str(e)
        )

@router.get("/bookmarks", response_model=List[Bookmark])
async def get_bookmarks(
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """Fetch all bookmarks for the current user."""
    return await BookmarkService.get_bookmarks(db, current_user.user_id)

@router.post("/bookmarks", response_model=Bookmark)
async def create_bookmark(
    *,
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
    bookmark_in: BookmarkCreate
) -> Any:
    """Create a new bookmark."""
    return await BookmarkService.create_bookmark(db, current_user.user_id, bookmark_in)

@router.delete("/bookmarks/{bookmark_id}", response_model=bool)
async def delete_bookmark(
    *,
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
    bookmark_id: UUID
) -> Any:
    """Delete a bookmark."""
    success = await BookmarkService.delete_bookmark(db, current_user.user_id, bookmark_id)
    if not success:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Bookmark not found"
        )
    return True
