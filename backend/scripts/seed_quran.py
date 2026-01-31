"""
Quran Database Seeder
Populates the database with Surahs, Verses, and Translations from fetched JSON data.
"""
import asyncio
import json
import logging
from pathlib import Path
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, delete, func

# Add parent directory to path for imports
import sys
sys.path.append(str(Path(__file__).parent.parent))

from app.database import AsyncSessionLocal as async_session_factory
from app.models.quran import QuranSurah, QuranVerse, QuranTranslation

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

DATA_DIR = Path(__file__).parent / "data"

async def seed_surahs(session: AsyncSession):
    """Seed Quran Surahs."""
    logger.info("Seeding Surahs...")
    with open(DATA_DIR / "surahs.json", encoding="utf-8") as f:
        data = json.load(f)["data"]
    
    # Check existing
    existing = await session.scalars(select(QuranSurah.surah_number))
    existing_ids = set(existing.all())
    
    to_add = []
    for s in data:
        if s["surah_number"] not in existing_ids:
            to_add.append(QuranSurah(
                surah_number=s["surah_number"],
                name_arabic=s["name_arabic"],
                name_complex=s["name_complex"],
                name_english=s["name_english"],
                revelation_place=s["revelation_place"],
                verses_count=s["verses_count"],
                order_in_quran=s["order_in_quran"]
            ))
    
    if to_add:
        session.add_all(to_add)
        await session.commit()
        logger.info(f"Added {len(to_add)} surahs.")
    else:
        logger.info("Surahs already populated.")

async def seed_verses(session: AsyncSession):
    """Seed Quran Verses."""
    logger.info("Seeding Verses...")
    with open(DATA_DIR / "quran_verses.json", encoding="utf-8") as f:
        data = json.load(f)["data"]
    
    # Check count to avoid redundant check if mostly full
    count = await session.scalar(select(func.count()).select_from(QuranVerse))
    if count and count >= len(data):
        logger.info(f"Verses likely populated ({count}/{len(data)}). Skipping.")
        return

    # Clear existing if partial? No, let's just add missing.
    # Actually simpler to upsert or just check existence of ID 1.
    
    to_add = []
    # For performance, we'll try to add all found. If conflict, we roll back?
    # Better: Fetch all IDs first.
    existing = await session.scalars(select(QuranVerse.verse_id))
    existing_ids = set(existing.all())
    
    for v in data:
        if v["verse_id"] not in existing_ids:
            to_add.append(QuranVerse(
                verse_id=v["verse_id"],
                surah_number=v["surah_number"],
                verse_number=v["verse_number"],
                arabic_text=v["arabic_text"],
                simple_text=v["simple_text"],
                letter_count=v["letter_count"],
                word_count=v["word_count"],
                has_sajdah=v["has_sajdah"],
                juz_number=v["juz_number"],
                hizb_number=v["hizb_number"],
                page_number=v["page_number"]
            ))
            
    if to_add:
        # Batch insert
        batch_size = 1000
        for i in range(0, len(to_add), batch_size):
            batch = to_add[i:i+batch_size]
            session.add_all(batch)
            await session.commit()
            logger.info(f"Added batch {i}-{i+len(batch)} verses.")
    else:
        logger.info("Verses already populated.")

async def seed_translations(session: AsyncSession, filename: str, translator_name: str):
    """Seed Translations."""
    file_path = DATA_DIR / filename
    if not file_path.exists():
        logger.warning(f"File {filename} not found. Skipping.")
        return

    logger.info(f"Seeding Translation: {translator_name}...")
    with open(file_path, encoding="utf-8") as f:
        data = json.load(f)["data"]
        
    # Check if this translation exists for first verse
    # Note: We can't check by ID easily as IDs are auto-increment or consistent?
    # The JSON data has "verse_id" which is actually "resource_id" from previous API call, 
    # but we need to map to actual Verse ID.
    # Wait, my fetcher didn't map "verse_key" (1:1) to global verse_id (1..6236).
    # I need to verify mapping.
    # Global verse ID 1 = 1:1.
    # I can lookup verse_id by surah/verse number or just assume order if I sorted verses.
    
    # Let's build a map of "surah:verse" -> global_verse_id from database
    # This ensures accuracy.
    
    verse_map_result = await session.execute(
        select(QuranVerse.verse_id, QuranVerse.surah_number, QuranVerse.verse_number)
    )
    verse_map = {f"{s}:{v}": vid for vid, s, v in verse_map_result.all()}
    
    to_add = []
    
    # Check existing translations for this translator
    existing_count = await session.scalar(
        select(func.count())
        .select_from(QuranTranslation)
        .where(QuranTranslation.translator_name == translator_name)
    )
    
    if existing_count >= len(data):
        logger.info(f"Translation {translator_name} already populated.")
        return

    for t in data:
        key = t["verse_key"]
        if key not in verse_map:
            logger.warning(f"Verse key {key} not found in DB. Skipping translation.")
            continue
            
        real_verse_id = verse_map[key]
        
        to_add.append(QuranTranslation(
            verse_id=real_verse_id,
            language=t["language"],
            translator_name=translator_name,
            translation_text=t["translation_text"]
        ))
        
    if to_add:
        batch_size = 1000
        for i in range(0, len(to_add), batch_size):
            batch = to_add[i:i+batch_size]
            session.add_all(batch)
            await session.commit()
            logger.info(f"Added batch {i}-{i+len(batch)} translations.")

async def main():
    async with async_session_factory() as session:
        await seed_surahs(session)
        await seed_verses(session)
        await seed_translations(session, "translations_sahih.json", "Sahih International")
        await seed_translations(session, "translations_haleem.json", "M.A.S. Abdel Haleem")
        logger.info("Seeding complete.")

if __name__ == "__main__":
    asyncio.run(main())
