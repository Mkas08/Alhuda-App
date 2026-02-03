from typing import List
from uuid import UUID
from sqlalchemy import select, desc, and_
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.progress import Bookmark
from app.schemas.progress import BookmarkCreate

class BookmarkService:
    @staticmethod
    async def get_bookmarks(db: AsyncSession, user_id: UUID) -> List[Bookmark]:
        """Fetch all bookmarks for a user."""
        query = select(Bookmark).where(Bookmark.user_id == user_id).order_by(desc(Bookmark.created_at))
        result = await db.execute(query)
        return list(result.scalars().all())

    @staticmethod
    async def create_bookmark(db: AsyncSession, user_id: UUID, bookmark_in: BookmarkCreate) -> Bookmark:
        """Create a new bookmark."""
        db_bookmark = Bookmark(
            user_id=user_id,
            verse_id=bookmark_in.verse_id,
            note=bookmark_in.note
        )
        db.add(db_bookmark)
        await db.commit()
        await db.refresh(db_bookmark)
        return db_bookmark

    @staticmethod
    async def delete_bookmark(db: AsyncSession, user_id: UUID, bookmark_id: UUID) -> bool:
        """Delete a bookmark."""
        query = select(Bookmark).where(and_(Bookmark.bookmark_id == bookmark_id, Bookmark.user_id == user_id))
        result = await db.execute(query)
        db_bookmark = result.scalar_one_or_none()
        
        if not db_bookmark:
            return False
            
        await db.delete(db_bookmark)
        await db.commit()
        return True
