from typing import Any, List, Optional
from fastapi import APIRouter, Depends, HTTPException, Query, Request
from sqlalchemy.ext.asyncio import AsyncSession
from redis.asyncio import Redis
from app.api import deps
from app.services.quran_service import QuranService
from app.schemas.quran import QuranVerseSchema, QuranSurahSchema, QuranSurahDetailSchema
from app.core.cache import cache_response

router = APIRouter()

@router.get("/surahs", response_model=List[QuranSurahSchema])
@cache_response(expire=86400)
async def list_surahs(
    db: AsyncSession = Depends(deps.get_db),
    request: Request = None,
    redis: Redis = Depends(deps.get_redis)
) -> Any:
    """List all surahs."""
    return await QuranService.list_surahs(db)

@router.get("/surah/{surah_number}", response_model=QuranSurahDetailSchema)
async def get_surah(
    surah_number: int,
    include_verses: bool = Query(False),
    offset: int = Query(0, ge=0),
    limit: int = Query(50, ge=1, le=286),
    db: AsyncSession = Depends(deps.get_db)
) -> Any:
    """Get surah details."""
    surah = await QuranService.get_surah(db, surah_number, include_verses, offset, limit)
    if not surah:
        raise HTTPException(status_code=404, detail="Surah not found")
    return surah

@router.get("/verse/{surah_number}/{verse_number}", response_model=QuranVerseSchema)
@cache_response(expire=86400)
async def get_verse(
    surah_number: int,
    verse_number: int,
    translator: Optional[List[str]] = Query(None),
    db: AsyncSession = Depends(deps.get_db),
    request: Request = None,
    redis: Redis = Depends(deps.get_redis)
) -> Any:
    """Get a specific verse with translations."""
    verse = await QuranService.get_verse(db, surah_number, verse_number, translator)
    if not verse:
        raise HTTPException(status_code=404, detail="Verse not found")
    return verse

@router.get("/verse/ref/{verse_id}/next", response_model=QuranVerseSchema)
async def get_next_verse(
    verse_id: int,
    db: AsyncSession = Depends(deps.get_db)
) -> Any:
    """Get next verse in sequence."""
    verse = await QuranService.get_neighbor_verse(db, verse_id, "next")
    if not verse:
        raise HTTPException(status_code=404, detail="No more verses")
    return verse

@router.get("/verse/ref/{verse_id}/previous", response_model=QuranVerseSchema)
async def get_previous_verse(
    verse_id: int,
    db: AsyncSession = Depends(deps.get_db)
) -> Any:
    """Get previous verse in sequence."""
    verse = await QuranService.get_neighbor_verse(db, verse_id, "previous")
    if not verse:
        raise HTTPException(status_code=404, detail="First verse reached")
    return verse

@router.get("/search", response_model=List[QuranVerseSchema])
async def search_quran(
    q: str = Query(..., min_length=2),
    limit: int = Query(20, ge=1, le=100),
    offset: int = Query(0, ge=0),
    db: AsyncSession = Depends(deps.get_db)
) -> Any:
    """Search the Quran for matching text."""
    return await QuranService.search_verses(db, q, limit, offset)
