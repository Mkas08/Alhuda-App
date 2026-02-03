from typing import Any
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from uuid import UUID

from app.api import deps
from app.models.user import User
from app.services.goal_service import GoalService
from app.schemas.progress import UserGoal, UserGoalCreate, UserGoalUpdate

router = APIRouter()

@router.get("/", response_model=UserGoal)
async def get_active_goal(
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
) -> Any:
    """Fetch the current active goal for the logged-in user."""
    goal = await GoalService.get_active_goal(db, current_user.user_id)
    if not goal:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="No active goal found for this user."
        )
    return goal

@router.post("/", response_model=UserGoal)
async def create_goal(
    *,
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
    goal_in: UserGoalCreate
) -> Any:
    """Create a new goal for the logged-in user. Automatically deactivates previous goals."""
    return await GoalService.create_goal(db, current_user.user_id, goal_in)

@router.patch("/{goal_id}", response_model=UserGoal)
async def update_goal(
    *,
    db: AsyncSession = Depends(deps.get_db),
    current_user: User = Depends(deps.get_current_active_user),
    goal_id: UUID,
    goal_in: UserGoalUpdate
) -> Any:
    """Update an existing goal."""
    goal = await GoalService.update_goal(db, goal_id, goal_in)
    if not goal:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Goal not found."
        )
    if goal.user_id != current_user.user_id:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Not enough permissions."
        )
    return goal
