import pytest
import pytest_asyncio
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import delete
from app.models.quran import QuranSurah, QuranVerse, QuranTranslation

@pytest_asyncio.fixture(autouse=True)
async def cleanup_db(db_session: AsyncSession):
    """Clean up Quran tables before each test."""
    await db_session.execute(delete(QuranTranslation))
    await db_session.execute(delete(QuranVerse))
    await db_session.execute(delete(QuranSurah))
    await db_session.commit()

@pytest.mark.asyncio
async def test_list_surahs(client: AsyncClient, db_session: AsyncSession):
    # Seed a surah
    surah = QuranSurah(
        surah_number=1, name_arabic="الفاتحة", name_complex="Al-Fatihah",
        name_english="The Opening", revelation_place="Makkah",
        verses_count=7, order_in_quran=1
    )
    db_session.add(surah)
    await db_session.commit()
    
    response = await client.get("/api/v1/quran/surahs")
    assert response.status_code == 200
    data = response.json()
    assert len(data) >= 1
    assert data[0]["name_complex"] == "Al-Fatihah"

@pytest.mark.asyncio
async def test_get_verse(client: AsyncClient, db_session: AsyncSession):
    # Seed surah and verse
    surah = QuranSurah(
        surah_number=1, name_arabic="الفاتحة", name_complex="Al-Fatihah",
        name_english="The Opening", revelation_place="Makkah",
        verses_count=7, order_in_quran=1
    )
    verse = QuranVerse(
        verse_id=1, surah_number=1, verse_number=1,
        arabic_text="بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
        simple_text="بسم الله الرحمن الرحيم",
        letter_count=19, word_count=4, has_sajdah=False,
        juz_number=1, hizb_number=1, page_number=1
    )
    translation = QuranTranslation(
        verse_id=1, language="en", translator_name="Sahih International",
        translation_text="In the name of Allah, the Entirely Merciful, the Especially Merciful."
    )
    db_session.add_all([surah, verse, translation])
    await db_session.commit()
    
    response = await client.get("/api/v1/quran/verse/1/1")
    assert response.status_code == 200
    data = response.json()
    assert data["arabic_text"] == verse.arabic_text
    assert len(data["translations"]) == 1

@pytest.mark.asyncio
async def test_search_quran(client: AsyncClient, db_session: AsyncSession):
    # Seed surah first (for FK)
    surah = QuranSurah(
        surah_number=1, name_arabic="S", name_complex="S",
        name_english="S", revelation_place="M",
        verses_count=7, order_in_quran=1
    )
    verse = QuranVerse(
        verse_id=2, surah_number=1, verse_number=2,
        arabic_text="الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
        simple_text="الحمد لله رب العالمين",
        letter_count=18, word_count=4, has_sajdah=False,
        juz_number=1, hizb_number=1, page_number=1
    )
    db_session.add_all([surah, verse])
    await db_session.commit()
    
    response = await client.get("/api/v1/quran/search?q=الحمد")
    assert response.status_code == 200
    data = response.json()
    assert len(data) >= 1

@pytest.mark.asyncio
async def test_navigation(client: AsyncClient, db_session: AsyncSession):
    surah = QuranSurah(
        surah_number=1, name_arabic="S", name_complex="S",
        name_english="S", revelation_place="M",
        verses_count=7, order_in_quran=1
    )
    v1 = QuranVerse(
        verse_id=1, surah_number=1, verse_number=1,
        arabic_text="V1", simple_text="V1",
        letter_count=2, word_count=1, has_sajdah=False,
        juz_number=1, hizb_number=1, page_number=1
    )
    v2 = QuranVerse(
        verse_id=2, surah_number=1, verse_number=2,
        arabic_text="V2", simple_text="V2",
        letter_count=2, word_count=1, has_sajdah=False,
        juz_number=1, hizb_number=1, page_number=1
    )
    db_session.add_all([surah, v1, v2])
    await db_session.commit()
    
    # Next
    response = await client.get("/api/v1/quran/verse/ref/1/next")
    assert response.status_code == 200
    assert response.json()["verse_id"] == 2
    
    # Previous
    response = await client.get("/api/v1/quran/verse/ref/2/previous")
    assert response.status_code == 200
    assert response.json()["verse_id"] == 1
