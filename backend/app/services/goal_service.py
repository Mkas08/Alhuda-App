from typing import Optional
from uuid import UUID
from sqlalchemy import select, update, and_, desc
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.progress import UserGoal
from app.schemas.progress import UserGoalCreate, UserGoalUpdate

class GoalService:
    @staticmethod
    async def get_active_goal(db: AsyncSession, user_id: UUID) -> Optional[UserGoal]:
        """Fetch the current active goal for a user."""
        query = select(UserGoal).where(
            and_(UserGoal.user_id == user_id, UserGoal.is_active == True)
        ).order_by(desc(UserGoal.created_at))
        result = await db.execute(query)
        return result.scalar_one_or_none()

    @staticmethod
    async def create_goal(db: AsyncSession, user_id: UUID, goal_in: UserGoalCreate) -> UserGoal:
        """Create a new goal and deactivate previous active ones."""
        # Deactivate previous active goals
        await db.execute(
            update(UserGoal)
            .where(and_(UserGoal.user_id == user_id, UserGoal.is_active == True))
            .values(is_active=False)
        )
        
        db_goal = UserGoal(
            user_id=user_id,
            goal_type=goal_in.goal_type,
            goal_value=goal_in.goal_value,
            preferred_times=goal_in.preferred_times,
            is_active=True
        )
        db.add(db_goal)
        await db.commit()
        await db.refresh(db_goal)
        return db_goal

    @staticmethod
    async def update_goal(db: AsyncSession, goal_id: UUID, goal_in: UserGoalUpdate) -> Optional[UserGoal]:
        """Update an existing goal."""
        query = select(UserGoal).where(UserGoal.goal_id == goal_id)
        result = await db.execute(query)
        db_goal = result.scalar_one_or_none()
        
        if not db_goal:
            return None
            
        update_data = goal_in.model_dump(exclude_unset=True)
        for key, value in update_data.items():
            setattr(db_goal, key, value)
            
        await db.commit()
        await db.refresh(db_goal)
        return db_goal
