# Design Document: Reading Screen (Milestone 3.1)

## 1. Overview
The Reading Screen is the core feature of the Al-Huda app, providing an immersive verse-by-verse reading experience. It must support Arabic text (Uthmanic), translations, navigation, and seamless session tracking.

## 2. Requirements (from PRD 5.3.1 & User Feedback)
- **Verse-by-Verse Mode**: clearly display one ayah at a time.
- **Reading Modes**:
    - **Normal Reading**: Default mode. Free reading, no timer overlay.
    - **Focus Session**: **Automatic Entry**. If user opens app during their scheduled goal time (e.g., "After Fajr"), system automatically starts a Focus Session with timer + app blocking.
- **Arabic & Translation**: Uthmanic script + user-selected translation.
- **Navigation**: Next/Previous buttons, auto-advance.
- **Session Tracking**: Visible in Focus Mode.
- **Design**: "Emerald Night" theme, premium feel, smooth transitions.
- **Offline Support**: Core reading must work offline.

## 3. Architecture

### 3.1 State Management (Riverpod)
We will use a `ReadingStateNotifier` (or `AsyncNotifier`) to manage:
- `currentSurah`: int
- `currentAyah`: int
- `verses`: List<QuranVerse> (cached/preloaded)
- `isLoading`: bool
- `fontSize`: double (user preference)
- `showTranslation`: bool

### 3.2 Navigation
- Route: `/reading/:surahId/:ayahId` (allows deep linking and state restoration).
- `GoRouter` will handle parameters.

### 3.3 Services
- `QuranService`: Fetches verses from local database (Isar/SQLite) or Remote API. (Ideally local for instant load).
- `SessionService`: Syncs progress to backend (`end_session` endpoint via Celery).
- `AudioService`: (Future M3.2) - Interface placeholder.

## 4. UI Components

### 4.1 `ReadingScreen` (Scaffold)
- **AppBar**: Surah Name, Ayah Number, "Finish Session" button.
- **Body**: `PageView` for swipeable verses (or buttons for Next/Prev if preferred, PRD mentions buttons).
    - *Decision*: `PageView` is more natural for mobile. We will support both Swipe and Buttons.

### 4.2 `VerseCard` (Widget)
- Central component.
- **Arabic Text**: Large, centered, using `Amiri` or `Uthmanic` font.
- **Translation**: Smaller, readable Sans-serif (Manrope).
- **Actions**: Bookmark icon, Play icon (placeholder).

### 4.3 `SessionOverlay` (Widget)
- Floating or fixed top bar.
- **Visibility**: Only shown when `SessionStatus == active`.
- Shows: `MM:SS` timer, `Verses: N`.
- Pulses gently to indicate active recording.
- **Normal Mode**: Replaced by a subtle "Start Focus Session" action or hidden entirely.

### 4.4 `ControlBar` (Widget)
- Bottom bar.
- `< Prev` | `Play/Pause` | `Next >`
- "1x" speed toggle (for audio later).
- **Focus Action**: Button to "Enter Focus Mode" if in Normal Mode.

## 5. Data Flow
1. **Init**: User opens Reading Screen.
2. **Check Context**: 
    - `SessionService` checks current time vs. `UserGoal.preferred_times`.
    - **If Match**: Auto-start "Focus Session". Show "Focus Mode Active" toast/overlay.
    - **If No Match**: precise "Normal Reading" mode.
3. **Load**: `ReadingProvider` fetches verse batch.
4. **Interaction**:
    - User completes reading an Ayah -> Taps "Next".
    - `SessionProvider` increments `versesRead`.
    - `ReadingProvider` advances index.
5. **End**: 
    - **Focus Mode**: User taps "End Session" -> Summary Screen.
    - **Normal**: User simple navigation or exiting saves position silently.

## 6. Error Handling
- **Network**: If fetching from API fails, show "Offline Mode" banner (if local DB empty).
- **Missing Verses**: Show retry button.

## 7. Testing Strategy
- **Unit**: Test `ReadingState` transitions (next/prev/end).
- **Widget**: Test `VerseCard` rendering (Arabic + Translation).
- **Integration**: Start Session -> Read 3 Verses -> End Session -> Verify Stats.
