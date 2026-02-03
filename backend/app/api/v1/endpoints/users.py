from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.api.deps import get_db, get_current_user
from app.models.user import User
from app.services.streak_service import StreakService
from app.schemas.progress import UserStats

router = APIRouter()

@router.get("/me/streak", response_model=UserStats)
async def get_my_streak(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db)
):
    """Get current user's streak and stats."""
    return await StreakService.get_user_stats(db, current_user.user_id)
