from typing import List, Optional
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, or_, and_
from sqlalchemy.orm import selectinload
from app.models.quran import QuranSurah, QuranVerse, QuranTranslation

class QuranService:
    @staticmethod
    async def get_verse(
        db: AsyncSession, 
        surah_number: int, 
        verse_number: int,
        translator_names: Optional[List[str]] = None
    ) -> Optional[QuranVerse]:
        """Fetch a single verse with its translations."""
        query = select(QuranVerse).where(
            and_(
                QuranVerse.surah_number == surah_number,
                QuranVerse.verse_number == verse_number
            )
        ).options(selectinload(QuranVerse.translations))
        
        result = await db.execute(query)
        verse = result.scalar_one_or_none()
        
        if verse and translator_names:
            # Filter translations if specific ones requested
            verse.translations = [
                t for t in verse.translations 
                if t.translator_name in translator_names
            ]
            
        return verse

    @staticmethod
    async def get_surah(
        db: AsyncSession, 
        surah_number: int,
        include_verses: bool = False,
        offset: int = 0,
        limit: int = 50
    ) -> Optional[QuranSurah]:
        """Fetch surah metadata."""
        query = select(QuranSurah).where(QuranSurah.surah_number == surah_number)
        if include_verses:
            # Note:selectinload doesn't support easy limit/offset for collections directly here
            # For real pagination of verses within a surah, we might need a separate endpoint
            # or use a more complex query. For MVP, we'll keep it simple or implement the limit.
            query = query.options(
                selectinload(QuranSurah.verses.and_(
                    QuranVerse.verse_number > offset,
                    QuranVerse.verse_number <= offset + limit
                )).selectinload(QuranVerse.translations)
            )
            
        result = await db.execute(query)
        return result.scalar_one_or_none()

    @staticmethod
    async def list_surahs(db: AsyncSession) -> List[QuranSurah]:
        """List all 114 surahs."""
        result = await db.execute(select(QuranSurah).order_by(QuranSurah.surah_number))
        return list(result.scalars().all())

    @staticmethod
    async def search_verses(
        db: AsyncSession, 
        query_text: str, 
        limit: int = 20,
        offset: int = 0
    ) -> List[QuranVerse]:
        """Search verses by Arabic or simple text."""
        query = select(QuranVerse).where(
            or_(
                QuranVerse.arabic_text.ilike(f"%{query_text}%"),
                QuranVerse.simple_text.ilike(f"%{query_text}%")
            )
        ).options(selectinload(QuranVerse.translations)).limit(limit).offset(offset)
        
        result = await db.execute(query)
        return list(result.scalars().all())

    @staticmethod
    async def get_neighbor_verse(
        db: AsyncSession, 
        verse_id: int, 
        direction: str = "next"
    ) -> Optional[QuranVerse]:
        """Get next or previous verse."""
        if direction == "next":
            target_id = verse_id + 1
        else:
            target_id = verse_id - 1
            
        query = select(QuranVerse).where(QuranVerse.verse_id == target_id).options(selectinload(QuranVerse.translations))
        result = await db.execute(query)
        return result.scalar_one_or_none()
