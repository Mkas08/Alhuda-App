# Flutter Prototype Migration Plan

> **For Gemini:** REQUIRED SUB-SKILL: Use subagent-driven-development to implement this plan task-by-task.

**Goal:** Convert the HTML/JS "Emerald Night" prototype into a functional Flutter app with mock data.

**Architecture:**
- **Navigation:** `ShellRoute` (GoRouter) for Bottom Navigation.
- **Data:** `MockDataService` to simulate API calls.
- **Theme:** Reuse existing `AppTheme`.
- **State:** Riverpod `StateProvider` for simple UI toggles (reading mode, focus mode).

**Tech Stack:** Flutter, GoRouter, Riverpod, Google Fonts.

---

### Task 1: Mock Data Service
**Files:**
- Create: `lib/shared/services/mock_data_service.dart`

**Step 1: Create Mock Data Service**
Define static JSON-like lists for `surahs`, `posts`, `users`, `blockedApps`. Add async getters with 500ms delay.

### Task 2: Main Application Shell (Bottom Nav)
**Files:**
- Create: `lib/features/main/presentation/screens/main_shell_screen.dart`
- Modify: `lib/config/routes/app_router.dart`
- Modify: `lib/config/routes/route_constants.dart`

**Step 1: Create MainShellScreen**
Implement `Scaffold` with `BottomNavigationBar` using `AppColors.deepForest` and Emerald icons. It should accept `child` (from GoRouter).

**Step 2: Update App Router**
Wrap the main screens (`home`, `reading`, `social`, `challenges`, `more`) in a `ShellRoute` pointing to `MainShellScreen`.

### Task 3: Feature: Reading (Surah List & Modes)
**Files:**
- Create: `lib/features/quran/presentation/screens/surah_list_screen.dart`
- Create: `lib/features/quran/presentation/screens/ayah_reading_screen.dart`
- Create: `lib/features/quran/presentation/screens/mushaf_reading_screen.dart`
- Modify: `lib/features/quran/presentation/screens/reading_screen.dart` (Refactor to use new modes)

**Step 1: Surah List**
Implement list view with search bar. Use `MockDataService.getSurahs()`.

**Step 2: Reading Modes**
Implement `AyahReadingScreen` (PageView) and `MushafReadingScreen` (Image placeholder). Add Toggle Button.

### Task 4: Feature: App Blocking
**Files:**
- Create: `lib/features/blocking/presentation/screens/app_blocking_screen.dart`
- Create: `lib/features/blocking/presentation/widgets/app_block_item.dart`

**Step 1: App Blocking Screen**
Implement "Focus Mode" toggle, Schedule list, and Blocked Apps list using `MockDataService`.

### Task 5: Feature: Social & Challenges
**Files:**
- Create: `lib/features/social/presentation/screens/social_screen.dart`
- Create: `lib/features/challenges/presentation/screens/challenges_screen.dart`
- Create: `lib/features/leaderboard/presentation/screens/leaderboard_screen.dart`

**Step 1: Social Screen**
Implement Feed View with `PostCard` widget.

**Step 2: Challenges & Leaderboard**
Implement simple list views with mock data.
