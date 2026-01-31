import asyncio
import sys
from pathlib import Path
sys.path.append(str(Path(__file__).parent.parent))

from sqlalchemy import select, func
from app.database import AsyncSessionLocal
from app.models.quran import QuranSurah, QuranVerse, QuranTranslation

async def verify():
    async with AsyncSessionLocal() as session:
        surah_count = await session.scalar(select(func.count()).select_from(QuranSurah))
        verse_count = await session.scalar(select(func.count()).select_from(QuranVerse))
        trans_count = await session.scalar(select(func.count()).select_from(QuranTranslation))
        
        print(f"Surahs: {surah_count}")
        print(f"Verses: {verse_count}")
        print(f"Translations: {trans_count}")
        
        if surah_count == 114 and verse_count == 6236 and trans_count == 12472:
            print("VERIFICATION_SUCCESS")
        else:
            print("VERIFICATION_FAILURE")

if __name__ == "__main__":
    asyncio.run(verify())
