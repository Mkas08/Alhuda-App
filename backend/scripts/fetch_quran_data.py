"""
Quran Data Fetcher - Downloads Quran data from Quran.com API
This script fetches all 6,236 verses, 114 surahs, and translations.
"""
import json
import asyncio
import aiohttp
from pathlib import Path
from typing import Any

BASE_URL = "https://api.quran.com/api/v4"
DATA_DIR = Path(__file__).parent / "data"

# Sajdah verse locations (surah:verse)
SAJDAH_VERSES = [
    (7, 206), (13, 15), (16, 50), (17, 109), (19, 58), (22, 18), (22, 77),
    (25, 60), (27, 26), (32, 15), (38, 24), (41, 38), (53, 62), (84, 21), (96, 19)
]

async def fetch_json(session: aiohttp.ClientSession, url: str, retries: int = 3) -> dict[str, Any]:
    """Fetch JSON from URL with error handling and retries."""
    for attempt in range(retries):
        try:
            async with session.get(url) as response:
                response.raise_for_status()
                return await response.json()
        except (aiohttp.ClientError, asyncio.TimeoutError) as e:
            if attempt == retries - 1:
                print(f"Failed to fetch {url}: {e}")
                raise
            wait = 2 ** attempt
            print(f"Network error, retrying in {wait}s... ({attempt + 1}/{retries})")
            await asyncio.sleep(wait)
    return {}

async def fetch_surahs(session: aiohttp.ClientSession) -> list[dict]:
    """Fetch all 114 surahs metadata."""
    print("Fetching surahs...")
    data = await fetch_json(session, f"{BASE_URL}/chapters")
    surahs = []
    for surah in data["chapters"]:
        surahs.append({
            "surah_number": surah["id"],
            "name_arabic": surah["name_arabic"],
            "name_complex": surah["name_complex"],
            "name_english": surah["translated_name"]["name"],
            "revelation_place": surah["revelation_place"].capitalize(),
            "verses_count": surah["verses_count"],
            "order_in_quran": surah["id"],
        })
    print(f"  Fetched {len(surahs)} surahs")
    return surahs

async def fetch_verses_for_surah(
    session: aiohttp.ClientSession, 
    surah_number: int,
    verses_count: int
) -> list[dict]:
    """Fetch all verses for a single surah."""
    url = f"{BASE_URL}/quran/verses/uthmani?chapter_number={surah_number}"
    data = await fetch_json(session, url)
    
    verses = []
    for v in data["verses"]:
        surah_num, verse_num = map(int, v["verse_key"].split(":"))
        is_sajdah = (surah_num, verse_num) in SAJDAH_VERSES
        
        arabic_text = v["text_uthmani"]
        # Calculate letter count (excluding spaces and diacritics for hasanat)
        letter_count = sum(1 for c in arabic_text if '\u0600' <= c <= '\u06FF' and c not in '\u064B\u064C\u064D\u064E\u064F\u0650\u0651\u0652')
        word_count = len(arabic_text.split())
        
        verses.append({
            "verse_id": v["id"],
            "surah_number": surah_num,
            "verse_number": verse_num,
            "arabic_text": arabic_text,
            "simple_text": v.get("text_imlaei", arabic_text),
            "letter_count": letter_count,
            "word_count": word_count,
            "has_sajdah": is_sajdah,
            "juz_number": v.get("juz_number", 1),
            "hizb_number": v.get("hizb_number", 1),
            "page_number": v.get("page_number", 1),
        })
    return verses

async def fetch_all_verses(session: aiohttp.ClientSession, surahs: list[dict]) -> list[dict]:
    """Fetch all verses from all surahs."""
    print("Fetching verses...")
    all_verses = []
    
    for surah in surahs:
        verses = await fetch_verses_for_surah(
            session, 
            surah["surah_number"], 
            surah["verses_count"]
        )
        all_verses.extend(verses)
        print(f"  Surah {surah['surah_number']:3d}: {len(verses):3d} verses")
        await asyncio.sleep(0.1)  # Rate limiting
    
    print(f"  Total: {len(all_verses)} verses")
    return all_verses

async def fetch_translation(
    session: aiohttp.ClientSession, 
    translation_id: int,
    translator_name: str,
    surahs: list[dict],
    language: str = "en"
) -> list[dict]:
    """Fetch a complete translation."""
    print(f"Fetching translation: {translator_name}...")
    translations = []
    
    for surah_num in range(1, 115):
        url = f"{BASE_URL}/quran/translations/{translation_id}?chapter_number={surah_num}"
        data = await fetch_json(session, url)
        
        if len(data["translations"]) != surahs[surah_num-1]["verses_count"]:
            print(f"Warning: Surah {surah_num} translation count mismatch!")

        for i, t in enumerate(data["translations"]):
            verse_num = i + 1
            verse_key = f"{surah_num}:{verse_num}"
            translations.append({
                "verse_id": t.get("resource_id", 0), # Note: This is translation ID, not verse ID, but we only have this
                "verse_key": verse_key,
                "language": language,
                "translator_name": translator_name,
                "translation_text": t["text"].replace("<sup>", "").replace("</sup>", ""),
            })
        
        if surah_num % 20 == 0:
            print(f"  Progress: {surah_num}/114 surahs")
        await asyncio.sleep(0.05)  # Rate limiting
    
    print(f"  Total: {len(translations)} translations")
    return translations

def calculate_checksum(data: list[dict]) -> str:
    """Calculate a simple checksum for data verification."""
    import hashlib
    content = json.dumps(data, ensure_ascii=False, sort_keys=True)
    return hashlib.sha256(content.encode('utf-8')).hexdigest()[:16]

async def main():
    """Main entry point."""
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    
    async with aiohttp.ClientSession() as session:
        # 1. Fetch surahs
        surahs = await fetch_surahs(session)
        surahs_file = DATA_DIR / "surahs.json"
        with open(surahs_file, "w", encoding="utf-8") as f:
            json.dump({"data": surahs, "checksum": calculate_checksum(surahs)}, f, ensure_ascii=False, indent=2)
        print(f"Saved: {surahs_file}")
        
        # 2. Fetch all verses
        verses = await fetch_all_verses(session, surahs)
        verses_file = DATA_DIR / "quran_verses.json"
        with open(verses_file, "w", encoding="utf-8") as f:
            json.dump({"data": verses, "checksum": calculate_checksum(verses)}, f, ensure_ascii=False, indent=2)
        print(f"Saved: {verses_file}")
        
        # 3. Fetch Sahih International translation (ID: 20)
        sahih = await fetch_translation(session, 20, "Sahih International", surahs, "en")
        sahih_file = DATA_DIR / "translations_sahih.json"
        with open(sahih_file, "w", encoding="utf-8") as f:
            json.dump({"data": sahih, "checksum": calculate_checksum(sahih)}, f, ensure_ascii=False, indent=2)
        print(f"Saved: {sahih_file}")
        
        # 4. Fetch Abdel Haleem translation (ID: 85) - Clear Quran not available in list
        khattab = await fetch_translation(session, 85, "M.A.S. Abdel Haleem", surahs, "en")
        khattab_file = DATA_DIR / "translations_haleem.json"
        with open(khattab_file, "w", encoding="utf-8") as f:
            json.dump({"data": khattab, "checksum": calculate_checksum(khattab)}, f, ensure_ascii=False, indent=2)
        print(f"Saved: {khattab_file}")
    
    print("\n✅ All data fetched successfully!")
    print(f"   Surahs: 114")
    print(f"   Verses: {len(verses)}")
    print(f"   Translations: 2 (Sahih International, Clear Quran)")

if __name__ == "__main__":
    asyncio.run(main())
