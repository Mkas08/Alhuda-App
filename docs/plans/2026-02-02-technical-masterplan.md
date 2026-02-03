# Al-Huda Technical Masterplan & Architecture

> **Vision**: A "Premium", offline-first Quran habit builder with instantaneous social interaction and robust syncing.

## 1. System Architecture Overview

We are adopting a **Hybrid Offline-First** architecture.
*   **Mobile (Frontend)**: Thick client. Uses `SQLite` for static content (Quran text) and cached user data.
*   **Backend (API)**: Sync & Social Hub. Uses `FastAPI` + `Postgres` + `Redis`.
*   **Protocol**: REST for Sync/CRUD, WebSockets for Chat.

---

## 2. Core Service Modules

### A. Reading & Quran Data Engine
**Strategy**: Zero-Latency, Offline-Access.
*   **Mobile**:
    *   Pre-populated `quran_text.db` (SQLite) shipped with app assets.
    *   Contains: `surahs`, `ayahs` (Uthmani), `translations` (En/Ur), `page_mappings`.
    *   **Search**: Full-text search (FTS5) runs locally on the device (instant).
*   **Backend**:
    *   Does **NOT** serve Quran text via API reading.
    *   Stores `quran_metadata` only for referential integrity (Foreign Keys).

### B. Progress & Sync Engine
**Strategy**: Aggregated Analytics.
*   **Data Models**:
    *   `ReadingSession`: Raw log (Start/End time, Verses list).
    *   `VerseReadHistory`: Hot storage for recent sessions.
    *   `SurahProgress`: Cold aggregation (User X completed Surah Y).
*   **Sync Logic**:
    *   Mobile queues session data when offline.
    *   On connection: `POST /sync/sessions` (Batch upload).
    *   Backend processes batch -> Updates `UserStats` -> Updates Redis Leaderboard.

### C. Social & Feed
**Strategy**: Activity Stream.
*   **Polymorphic Feed**:
    *   Table `activities`: `id`, `user_id`, `type` (post/read/challenge), `ref_id`, `created_at`.
    *   Service `FeedGenerator`: Queries activities from `followed_users`.
    *   **Privacy**: Strict row-level security based on `user_relations` status.

### D. Real-Time Chat
**Strategy**: Redis Pub/Sub.
*   **Stack**: FastAPI WebSockets + Redis.
*   **Flow**:
    1.  User A connects WS -> Subscribes to Redis Channel `chat:{room_id}`.
    2.  User A sends message -> Server saves to Postgres -> Publishes to Redis.
    3.  Server pushes Redis event to all active WS subscribers on that channel.
*   **Offline Support**: Mobile stores `chat_history` in local DB. Syncs missing messages on connect.

### E. Challenges & Leaderboards
**Strategy**: High-Performance Caching.
*   **Storage**: Redis Sorted Sets (`ZSET`).
*   **Key**: `leaderboard:global_weekly`.
*   **Operations**:
    *   `ZINCRBY`: Update score O(1).
    *   `ZREVRANGE`: Get Top 50 O(log N).
    *   `ZREVRANK`: Get 'My Rank' O(log N).

### F. App Blocking
**Strategy**: Native Enforcement.
*   **Mobile**:
    *   Flutter Platform Channels (Android/iOS Native APIs) to detect foreground apps.
    *   Overlay "Focus Screen" if blocked app is opened during a session.
*   **Backend**:
    *   Stores `FocusStats` for gamification (e.g., "4 hours focused this week").

---

## 3. Database Schema Plan (Postgres)

### Users & Social
*   `users`: Auth & Profile.
*   `user_relations`: Follower/Following logic (`requester_id`, `addressee_id`, `status`).
*   `posts`: User manual posts.

### Quran & Progress
*   `reading_sessions`: The source of truth for stats.
*   `bookmarks`: User saved places.
*   `daily_goals`: Configuration for habits.

### Gamification
*   `challenges`: Event definitions.
*   `challenge_participants`: Progress tracking.
*   `badges`: Achievements unlocked.

---

## 4. Technology Stack Summary

| Component | Technology | Role |
|-----------|------------|------|
| **Mobile DB** | **SQLite (Drift)** | Offline Quran text, cached chats, local session queue |
| **API Framework** | **FastAPI (Async)** | High-performance REST & WebSockets |
| **Primary DB** | **PostgreSQL** | Durable data storage, relational integrity |
| **Cache/PubSub**| **Redis** | Chat message bus, Leaderboard calculations, API Caching |
| **Search** | **FTS5 (Mobile)** | Instant offline local search |

## 5. Next Implementation Steps
1.  **Backend Foundation**: Configure Redis connection & Async Database drivers.
2.  **API Services**: Implement `ReadingSession` endpoints and `Social` logic.
3.  **Real-Time**: Build the WebSocket manager for Chat.
