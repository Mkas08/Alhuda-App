import pytest
import pytest_asyncio
from httpx import AsyncClient
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import delete

from app.models.quran import QuranSurah, QuranVerse
from app.models.progress import UserGoal, UserStats, VerseReadHistory, Bookmark

@pytest_asyncio.fixture(autouse=True)
async def cleanup_db(db_session: AsyncSession):
    await db_session.execute(delete(Bookmark))
    await db_session.execute(delete(VerseReadHistory))
    await db_session.execute(delete(UserGoal))
    await db_session.execute(delete(UserStats))
    await db_session.execute(delete(QuranVerse))
    await db_session.execute(delete(QuranSurah))
    await db_session.commit()

async def get_token(client: AsyncClient):
    # Helper to get auth token
    await client.post(
        "/api/v1/auth/register",
        json={"email": "test@example.com", "username": "testuser", "password": "TestPassword123"}
    )
    res = await client.post(
        "/api/v1/auth/login",
        data={"username": "testuser", "password": "TestPassword123"}
    )
    return res.json()["access_token"]

@pytest.mark.asyncio
async def test_create_goal(client: AsyncClient):
    token = await get_token(client)
    headers = {"Authorization": f"Bearer {token}"}
    
    response = await client.post(
        "/api/v1/goals/",
        headers=headers,
        json={
            "goal_type": "verse",
            "goal_value": 5,
            "preferred_times": ["after_fajr"]
        }
    )
    assert response.status_code == 200
    data = response.json()
    assert data["goal_type"] == "verse"
    assert data["goal_value"] == 5
    assert data["is_active"] is True

@pytest.mark.asyncio
async def test_get_progress_summary(client: AsyncClient, db_session: AsyncSession):
    token = await get_token(client)
    headers = {"Authorization": f"Bearer {token}"}
    
    # First get summary (should have default stats)
    response = await client.get("/api/v1/progress/", headers=headers)
    assert response.status_code == 200
    data = response.json()
    assert data["stats"]["total_verses_read"] == 0
    assert data["active_goal"] is None
    
    # Create a goal
    await client.post(
        "/api/v1/goals/",
        headers=headers,
        json={"goal_type": "verse", "goal_value": 10}
    )
    
    response = await client.get("/api/v1/progress/", headers=headers)
    assert response.status_code == 200
    assert response.json()["active_goal"]["goal_value"] == 10

@pytest.mark.asyncio
async def test_update_progress(client: AsyncClient, db_session: AsyncSession):
    token = await get_token(client)
    headers = {"Authorization": f"Bearer {token}"}
    
    # Seed a surah and verse
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
    db_session.add_all([surah, verse])
    await db_session.commit()
    
    # Update progress
    response = await client.post(
        "/api/v1/progress/update",
        headers=headers,
        json={"verse_id": 1}
    )
    assert response.status_code == 200
    data = response.json()
    assert data["total_verses_read"] == 1
    assert data["total_hasanat"] == 190 # 19 letters * 10
    assert data["current_streak"] == 1

@pytest.mark.asyncio
async def test_bookmarks_crud(client: AsyncClient, db_session: AsyncSession):
    token = await get_token(client)
    headers = {"Authorization": f"Bearer {token}"}
    
    # 1. Create a bookmark
    response = await client.post(
        "/api/v1/progress/bookmarks",
        headers=headers,
        json={"verse_id": 1, "note": "Test note"}
    )
    assert response.status_code == 200
    bookmark = response.json()
    assert bookmark["verse_id"] == 1
    assert bookmark["note"] == "Test note"
    bookmark_id = bookmark["bookmark_id"]
    
    # 2. Get bookmarks
    response = await client.get("/api/v1/progress/bookmarks", headers=headers)
    assert response.status_code == 200
    bookmarks = response.json()
    assert len(bookmarks) == 1
    assert bookmarks[0]["bookmark_id"] == bookmark_id
    
    # 3. Delete bookmark
    response = await client.delete(f"/api/v1/progress/bookmarks/{bookmark_id}", headers=headers)
    assert response.status_code == 200
    assert response.json() is True
    
    # 4. Verify deleted
    response = await client.get("/api/v1/progress/bookmarks", headers=headers)
    assert response.status_code == 200
    assert len(response.json()) == 0
