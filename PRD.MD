# Product Requirements Document (PRD)
## Quran Habit Building Mobile Application

**Version:** 1.0  
**Last Updated:** January 2, 2026  
**Document Owner:** Product Team  
**Status:** Approved

---

## Table of Contents
1. [Executive Summary](#executive-summary)
2. [Product Overview](#product-overview)
3. [Objectives & Success Metrics](#objectives--success-metrics)
4. [User Personas](#user-personas)
5. [Functional Requirements](#functional-requirements)
6. [Technical Architecture](#technical-architecture)
7. [User Interface & Experience](#user-interface--experience)
8. [Machine Learning Integration](#machine-learning-integration)
9. [Data Models & Database Schema](#data-models--database-schema)
10. [API Specifications](#api-specifications)
11. [Security & Privacy](#security--privacy)
12. [Release Planning](#release-planning)
13. [Open Questions & Future Considerations](#open-questions--future-considerations)

---

## 1. Executive Summary

### 1.1 Product Vision
To create the most effective Quran reading habit-building application that combines behavioral psychology, community support, and spiritual growth tracking to help Muslims worldwide develop and maintain a consistent relationship with the Quran.

### 1.2 Product Mission
Empower Muslims to read the Quran daily by providing structure, accountability, encouragement, and community through an intuitive mobile application.

### 1.3 Target Market
- Primary: Muslims aged 16-45 who want to build a Quran reading habit
- Secondary: Parents seeking tools for their children (13+)
- Geographic Focus: Global (prioritize English, Arabic, Urdu, Indonesian, Turkish)

### 1.4 Technology Stack Summary
- **Frontend:** Flutter (iOS & Android)
- **Backend:** Python (FastAPI/Django)
- **Database:** PostgreSQL
- **ML Components:** Python (scikit-learn, TensorFlow/PyTorch for recommendations)
- **Real-time:** WebSockets (Django Channels or FastAPI)
- **Caching:** Redis
- **Storage:** AWS S3 / Google Cloud Storage
- **Notifications:** Firebase Cloud Messaging

---

## 2. Product Overview

### 2.1 Core Features Summary
1. **Onboarding & Goal Setting** - Personalized habit configuration
2. **Focus Mode & App Blocking** - Distraction elimination during reading
3. **Dual Reading Modes** - Verse-by-verse and traditional Mushaf
4. **Hasanat Calculation** - Automatic spiritual reward tracking
5. **Sajdah Reminders** - Prostration notifications
6. **Completion Encouragement** - Motivational feedback system
7. **Social Features** - Messaging, community feed, friendships
8. **Leaderboards** - Friends, regional, and global rankings
9. **Challenges** - User-created and auto-generated
10. **Dua Library** - Categorized supplications
11. **Prayer Times** - Location-based salah notifications
12. **ML-Powered Recommendations** - Personalized content and goals

### 2.2 Key Differentiators
- Comprehensive app blocking during reading sessions (Android)
- Automatic hasanat calculation with letter-level precision
- Community-driven motivation system
- ML-powered personalization for optimal habit formation
- Seamless integration of Quran reading with daily prayer schedule

---

## 3. Objectives & Success Metrics

### 3.1 Business Objectives
1. Achieve 100,000 active users within 12 months
2. Maintain 40%+ Day 30 retention rate
3. Foster engaged community with 25%+ users participating in social features
4. Establish as top 3 Quran app in target markets

### 3.2 User Objectives
1. Help 60%+ of users establish 7-day reading streak
2. Enable 30%+ of users to complete a juz (section) within first month
3. Achieve 4.5+ star rating on app stores
4. User testimonials of improved spiritual connection

### 3.3 Key Performance Indicators (KPIs)

| Metric | Target | Measurement Frequency |
|--------|--------|----------------------|
| Daily Active Users (DAU) | 40% of MAU | Daily |
| Average Session Duration | 15+ minutes | Weekly |
| 7-Day Streak Completion | 60% of active users | Weekly |
| 30-Day Streak Completion | 35% of active users | Monthly |
| Day 1 Retention | 70% | Daily |
| Day 7 Retention | 50% | Weekly |
| Day 30 Retention | 40% | Monthly |
| Verses Read per User per Day | 15+ | Weekly |
| Challenge Participation Rate | 25% | Monthly |
| Community Post Engagement | 3+ interactions/post | Weekly |
| App Store Rating | 4.5+ stars | Monthly |
| Net Promoter Score (NPS) | 50+ | Quarterly |

### 3.4 Success Criteria for MVP
- Stable app performance (< 1% crash rate)
- 10,000 downloads in first 3 months
- 50%+ Day 7 retention
- Positive user feedback on core reading experience

---

## 4. User Personas

### 4.1 Primary Persona: "Aspiring Aisha"
**Demographics:**
- Age: 25
- Location: London, UK
- Occupation: Marketing professional
- Tech-savviness: High

**Goals:**
- Read at least 2 pages of Quran daily
- Understand what she's reading (needs translation)
- Build consistent habit despite busy schedule

**Pain Points:**
- Gets distracted by social media apps
- Forgets to read due to irregular schedule
- Loses motivation when reading alone
- Doesn't know how much reward she's earning

**How Our App Helps:**
- App blocking keeps her focused
- Prayer time-based reminders
- Community support and accountability
- Visual hasanat tracking motivates her

### 4.2 Secondary Persona: "Committed Kareem"
**Demographics:**
- Age: 35
- Location: Cairo, Egypt
- Occupation: Engineer
- Has basic Quran knowledge

**Goals:**
- Complete full Quran every month
- Compete with friends for motivation
- Track spiritual progress quantitatively
- Teach children through example

**Pain Points:**
- Needs accountability structure
- Wants to measure improvement
- Lacks community of like-minded readers

**How Our App Helps:**
- Challenge system with friends
- Detailed progress analytics
- Leaderboards for friendly competition
- Shareable achievements to inspire family

### 4.3 Tertiary Persona: "Beginner Bilal"
**Demographics:**
- Age: 19
- Location: Jakarta, Indonesia
- Occupation: University student
- New to consistent Quran reading

**Goals:**
- Start reading Quran regularly (even 5 verses/day)
- Learn proper recitation over time
- Not feel overwhelmed

**Pain Points:**
- Doesn't know where to start
- Intimidated by length of Quran
- Needs gentle guidance and encouragement

**How Our App Helps:**
- Smart onboarding with modest initial goals
- Auto-generated beginner challenges
- Encouragement system celebrates small wins
- ML recommendations adjust to his pace

---

## 5. Functional Requirements

### 5.1 Onboarding & Goal Setting

#### 5.1.1 Initial Onboarding Flow
**Priority:** P0 (Must Have for MVP)

**User Story:**
As a new user, I want to set up my reading goals during onboarding so that the app can personalize my experience from day one.

**Acceptance Criteria:**
- [ ] Welcome screen explains app's core value proposition
- [ ] User selects preferred language (Arabic, English, Urdu, Indonesian, Turkish)
- [ ] User chooses reading goal type:
  - Verse-based (e.g., 10 verses per day)
  - Time-based (e.g., 15 minutes per day)
  - Page-based (e.g., 2 pages per day)
- [ ] User selects preferred reading time(s) linked to prayer times:
  - After Fajr
  - After Dhuhr
  - After Asr
  - After Maghrib
  - After Isha
  - Custom time
- [ ] User can select multiple time slots
- [ ] User sets starting level: Beginner / Intermediate / Advanced
- [ ] System suggests appropriate goals based on level selection
- [ ] User can accept suggestion or customize
- [ ] Onboarding completion tracked in database

**Technical Specifications:**
```python
# Database Model
class UserGoal:
    user_id: UUID (FK)
    goal_type: Enum['verse', 'time', 'page']
    goal_value: Integer  # verses/minutes/pages
    preferred_times: JSONB  # Array of time preferences
    start_date: DateTime
    is_active: Boolean
    created_at: DateTime
    updated_at: DateTime
```

**API Endpoint:**
```
POST /api/v1/onboarding/goals
Request Body:
{
  "goal_type": "verse",
  "goal_value": 10,
  "preferred_times": ["after_fajr", "after_isha"],
  "user_level": "beginner"
}

Response: 201 Created
{
  "goal_id": "uuid",
  "message": "Goal successfully created",
  "recommended_start_surah": "Al-Baqarah",
  "recommended_start_ayah": 1
}
```

#### 5.1.2 App Blocking Configuration
**Priority:** P0 (MVP - Android), P1 (iOS - Limited)

**User Story:**
As a user who gets easily distracted, I want to block specific apps during my reading sessions so I can maintain focus.

**Acceptance Criteria:**
- [ ] User presented with list of installed apps (Android only)
- [ ] User can select multiple apps to block
- [ ] System validates app blocking permissions are granted
- [ ] iOS users see alternative: "Focus Mode Reminder" that encourages manual focus
- [ ] User can modify blocked apps list anytime in settings
- [ ] System provides clear explanation of how app blocking works
- [ ] Emergency apps (Phone, Messages) cannot be blocked

**Technical Specifications:**

**Android Implementation:**
```dart
// Flutter - Android
class AppBlockingService {
  static const platform = MethodChannel('com.quranapp/app_blocking');
  
  Future<bool> requestAccessibilityPermission() async {
    return await platform.invokeMethod('requestPermission');
  }
  
  Future<void> blockApps(List<String> packageNames) async {
    await platform.invokeMethod('blockApps', {
      'packages': packageNames,
    });
  }
  
  Future<void> unblockApps() async {
    await platform.invokeMethod('unblockApps');
  }
}
```

**Python Backend:**
```python
# Store blocked apps configuration
class BlockedAppsConfig:
    user_id: UUID (FK)
    blocked_packages: JSONB  # Array of package names
    is_active: Boolean
    platform: Enum['android', 'ios']
    created_at: DateTime
    updated_at: DateTime
```

**iOS Limitation Note:**
iOS does not allow third-party apps to block other apps. Alternative approach:
- Suggest enabling "Focus Mode" manually
- Provide in-app reminders
- Show encouragement to stay focused
- Track manual focus mode activation

#### 5.1.3 Goal Modification
**Priority:** P0 (MVP)

**User Story:**
As an active user, I want to adjust my daily goals based on my progress so I can challenge myself or reduce pressure as needed.

**Acceptance Criteria:**
- [ ] Settings screen has "Edit Goals" option
- [ ] User can change goal type (verse/time/page)
- [ ] User can adjust goal value (increase/decrease)
- [ ] User can modify preferred reading times
- [ ] System shows goal modification history
- [ ] Changes take effect from next day (not retroactive)
- [ ] ML system adjusts recommendations based on new goals

**API Endpoint:**
```
PATCH /api/v1/users/{user_id}/goals/{goal_id}
Request Body:
{
  "goal_value": 15,
  "preferred_times": ["after_fajr"]
}

Response: 200 OK
{
  "message": "Goal updated successfully",
  "effective_date": "2026-01-03",
  "previous_goal": {...},
  "new_goal": {...}
}
```

---

### 5.2 Focus Mode & App Blocking

#### 5.2.1 Reading Session with App Blocking
**Priority:** P0 (MVP - Android)

**User Story:**
As a user, when I start a reading session, I want selected apps to be automatically blocked so I can maintain focus without manual willpower.

**Acceptance Criteria:**
- [ ] When user taps "Start Reading Session", timer begins
- [ ] Blocked apps become inaccessible immediately (Android)
- [ ] Timer displays prominently on reading screen
- [ ] If user exits app, timer pauses automatically
- [ ] Timer resumes only when user returns to app
- [ ] User can manually end session anytime
- [ ] Session data (duration, verses read) saved to database
- [ ] Blocked apps unblock immediately when session ends

**State Machine:**
```
States:
- INACTIVE: No active session
- ACTIVE: Reading session in progress, apps blocked
- PAUSED: User left app, timer paused, apps unblocked
- COMPLETED: Session ended by user

Transitions:
INACTIVE → ACTIVE: User starts session
ACTIVE → PAUSED: User exits app
PAUSED → ACTIVE: User returns to app
ACTIVE → COMPLETED: User ends session or goal reached
```

**Technical Implementation:**

**Flutter Frontend:**
```dart
class FocusSession {
  String sessionId;
  DateTime startTime;
  DateTime? endTime;
  int elapsedSeconds;
  SessionState state;
  int versesRead;
  
  void start() {
    state = SessionState.ACTIVE;
    AppBlockingService.blockApps();
    startTimer();
  }
  
  void pause() {
    state = SessionState.PAUSED;
    AppBlockingService.unblockApps();
    pauseTimer();
  }
  
  void resume() {
    state = SessionState.ACTIVE;
    AppBlockingService.blockApps();
    resumeTimer();
  }
  
  void end() {
    state = SessionState.COMPLETED;
    AppBlockingService.unblockApps();
    saveSession();
  }
}
```

**Python Backend API:**
```python
# Session Model
class ReadingSession:
    session_id: UUID (PK)
    user_id: UUID (FK)
    start_time: DateTime
    end_time: DateTime (nullable)
    total_duration_seconds: Integer
    verses_read: Integer
    hasanat_earned: BigInteger
    goal_achieved: Boolean
    session_type: Enum['scheduled', 'spontaneous']
    created_at: DateTime
    
# API Endpoints
@router.post("/api/v1/sessions/start")
async def start_session(user_id: UUID):
    session = create_reading_session(user_id)
    return {"session_id": session.session_id, "start_time": session.start_time}

@router.patch("/api/v1/sessions/{session_id}/pause")
async def pause_session(session_id: UUID):
    session = pause_reading_session(session_id)
    return {"status": "paused", "elapsed_time": session.elapsed_seconds}

@router.patch("/api/v1/sessions/{session_id}/end")
async def end_session(session_id: UUID, verses_read: int):
    session = complete_reading_session(session_id, verses_read)
    hasanat = calculate_hasanat(verses_read)
    return {
        "status": "completed",
        "duration": session.total_duration_seconds,
        "verses_read": verses_read,
        "hasanat_earned": hasanat,
        "goal_achieved": session.goal_achieved
    }
```

#### 5.2.2 Timer Persistence
**Priority:** P0 (MVP)

**User Story:**
As a user, if I accidentally close the app during a reading session, I want the timer to save my progress so I don't lose my session data.

**Acceptance Criteria:**
- [ ] App saves session state to local storage every 10 seconds
- [ ] On app restart, user sees option to "Resume Previous Session"
- [ ] User can choose to resume or start new session
- [ ] Resumed session shows time already elapsed
- [ ] If session was inactive for > 2 hours, mark as abandoned

**Local Storage (Flutter):**
```dart
class SessionPersistence {
  static const String SESSION_KEY = 'active_reading_session';
  
  Future<void> saveSession(FocusSession session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SESSION_KEY, jsonEncode(session.toJson()));
  }
  
  Future<FocusSession?> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionJson = prefs.getString(SESSION_KEY);
    if (sessionJson != null) {
      return FocusSession.fromJson(jsonDecode(sessionJson));
    }
    return null;
  }
}
```

---

### 5.3 Quran Reading Interface

#### 5.3.1 Verse-by-Verse Reading Mode
**Priority:** P0 (MVP)

**User Story:**
As a user, I want to read one verse at a time with its translation so I can focus on understanding each ayah and track my hasanat accurately.

**Acceptance Criteria:**
- [ ] Display single ayah in clear Arabic text (Uthmanic script)
- [ ] Display translation immediately below Arabic text
- [ ] Show surah name and ayah number (e.g., "Al-Baqarah 2:255")
- [ ] "Next" button advances to next verse
- [ ] "Previous" button goes back to previous verse
- [ ] Automatic hasanat calculation on "Next" click
- [ ] Visual progress indicator (e.g., "Verse 5 of 286")
- [ ] Smooth transition animations between verses
- [ ] Font size adjustable (3 sizes: small, medium, large)
- [ ] Night mode toggle
- [ ] Bookmark current verse
- [ ] Last read position auto-saved

**UI Layout:**
```
┌──────────────────────────────────────┐
│  ☰  Al-Baqarah (2:255)        🔖 Aa │
├──────────────────────────────────────┤
│                                       │
│      [Arabic Text - Ayat al-Kursi]   │
│       (Large, centered, Uthmanic)    │
│                                       │
├──────────────────────────────────────┤
│                                       │
│  Allah - there is no deity except    │
│  Him, the Ever-Living, the Sustainer │
│  of existence. Neither drowsiness... │
│  (Translation - smaller, justified)   │
│                                       │
├──────────────────────────────────────┤
│  Progress: 255 of 286 verses          │
│  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░ 89%              │
├──────────────────────────────────────┤
│  Hasanat Earned: 9,850 (+35)         │
├──────────────────────────────────────┤
│   [← Previous]      [Next →]          │
└──────────────────────────────────────┘
```

**Database Models:**
```python
class QuranVerse:
    verse_id: Integer (PK)
    surah_number: Integer
    verse_number: Integer
    arabic_text: Text
    simple_text: Text  # Without diacritics for search
    letter_count: Integer  # For hasanat calculation
    word_count: Integer
    has_sajdah: Boolean
    juz_number: Integer
    hizb_number: Integer
    page_number: Integer (Mushaf Medina)
    
class QuranTranslation:
    translation_id: UUID (PK)
    verse_id: Integer (FK)
    language: String
    translator_name: String
    translation_text: Text
    
class UserReadingProgress:
    user_id: UUID (FK)
    current_surah: Integer
    current_verse: Integer
    total_verses_read: Integer
    total_hasanat: BigInteger
    last_read_at: DateTime
    updated_at: DateTime
```

**API Endpoints:**
```python
@router.get("/api/v1/quran/verse/{surah}/{verse}")
async def get_verse(
    surah: int,
    verse: int,
    translation_lang: str = "en",
    translator: str = "sahih_international"
):
    verse_data = get_verse_from_db(surah, verse)
    translation = get_translation(verse_data.verse_id, translation_lang, translator)
    
    return {
        "verse_id": verse_data.verse_id,
        "surah": verse_data.surah_number,
        "verse": verse_data.verse_number,
        "arabic_text": verse_data.arabic_text,
        "translation": translation.translation_text,
        "letter_count": verse_data.letter_count,
        "has_sajdah": verse_data.has_sajdah,
        "next_verse": {
            "surah": next_surah,
            "verse": next_verse
        },
        "previous_verse": {
            "surah": prev_surah,
            "verse": prev_verse
        }
    }

@router.post("/api/v1/quran/verse/{verse_id}/read")
async def mark_verse_read(verse_id: int, user_id: UUID):
    """Mark verse as read and calculate hasanat"""
    verse = get_verse(verse_id)
    hasanat = verse.letter_count * 10
    
    update_user_progress(user_id, verse_id, hasanat)
    
    return {
        "verse_id": verse_id,
        "hasanat_earned": hasanat,
        "total_hasanat": get_user_total_hasanat(user_id)
    }
```

**Hasanat Calculation Logic:**
```python
def calculate_hasanat(verses_read: List[int]) -> int:
    """
    Calculate hasanat for verses read.
    Hadith: Each letter = 10 hasanat
    Example: Bismillah (19 letters) = 190 hasanat
    """
    total_hasanat = 0
    for verse_id in verses_read:
        verse = get_verse_by_id(verse_id)
        total_hasanat += verse.letter_count * 10
    return total_hasanat

# Cache frequently accessed verses
@cache(ttl=3600)
def get_verse_letter_count(verse_id: int) -> int:
    return db.query(QuranVerse.letter_count).filter(
        QuranVerse.verse_id == verse_id
    ).scalar()
```

#### 5.3.2 Traditional Mushaf Layout Mode
**Priority:** P1 (Post-MVP)

**User Story:**
As a user familiar with physical Quran, I want to read in traditional page layout so I can maintain my usual reading experience.

**Acceptance Criteria:**
- [ ] Display Quran in standard Medina Mushaf pagination (604 pages)
- [ ] Page image rendered clearly at all zoom levels
- [ ] Swipe left/right to navigate pages
- [ ] Page number indicator
- [ ] Jump to page/surah functionality
- [ ] Bookmark pages
- [ ] Manual "I'm Done" button to mark pages as read
- [ ] System estimates verses read based on page count
- [ ] Option to switch to verse-by-verse mode from any page

**Technical Implementation:**
```python
class MushafPage:
    page_id: Integer (PK)
    page_number: Integer (1-604)
    start_surah: Integer
    start_verse: Integer
    end_surah: Integer
    end_verse: Integer
    image_url: String  # High-res page image in S3
    estimated_verses: Integer
    
# API
@router.get("/api/v1/quran/mushaf/page/{page_number}")
async def get_mushaf_page(page_number: int):
    page = get_page_data(page_number)
    return {
        "page_number": page_number,
        "image_url": page.image_url,
        "range": f"{page.start_surah}:{page.start_verse} - {page.end_surah}:{page.end_verse}",
        "estimated_verses": page.estimated_verses
    }
```

#### 5.3.3 Reading Preferences
**Priority:** P0 (MVP)

**Acceptance Criteria:**
- [ ] Font size: Small, Medium, Large
- [ ] Theme: Light mode, Dark mode, Sepia
- [ ] Translation: Multiple languages and translators
- [ ] Display options: Arabic only, Translation only, Both
- [ ] Tajweed coloring: On/Off (color-coded pronunciation rules)
- [ ] Preferences saved per user
- [ ] Changes apply immediately

**Settings UI:**
```dart
class ReadingPreferences {
  FontSize fontSize;  // small, medium, large
  ThemeMode theme;  // light, dark, sepia
  String translationLanguage;
  String translatorName;
  DisplayMode displayMode;  // arabic, translation, both
  bool showTajweed;
  bool showTransliteration;
}
```

---

### 5.4 Sajdah (Prostration) Reminders

#### 5.4.1 Sajdah Notification
**Priority:** P1 (Post-MVP)

**User Story:**
As a user, when I reach a verse requiring sajdah, I want to be reminded so I can perform it properly.

**Acceptance Criteria:**
- [ ] When user reaches verse with sajdah marker and clicks "Next", modal appears
- [ ] Modal displays: "This verse contains Sajdah Tilawah"
- [ ] Options: "Performed Sajdah" or "Skip"
- [ ] If "Performed", track in user stats (optional)
- [ ] No judgment or negative feedback for "Skip"
- [ ] Sajdah verses: 7:206, 13:15, 16:49, 17:107, 19:58, 22:18, 22:77, 25:60, 27:25, 32:15, 38:24, 41:37, 53:62, 84:21, 96:19

**UI Modal:**
```
┌─────────────────────────────────────┐
│  🕌 Sajdah Tilawah                  │
├─────────────────────────────────────┤
│  This verse contains a place of      │
│  prostration. It is recommended to   │
│  perform sajdah at this point.       │
│                                      │
│  [Learn More]                        │
├─────────────────────────────────────┤
│  [✓ Performed Sajdah]  [Skip]       │
└─────────────────────────────────────┘
```

**Database:**
```python
class SajdahTracking:
    user_id: UUID (FK)
    verse_id: Integer (FK)
    performed: Boolean
    performed_at: DateTime
```

---

### 5.5 Completion & Encouragement System

#### 5.5.1 Session Completion Screen
**Priority:** P0 (MVP)

**User Story:**
As a user who completes a reading session, I want to see encouraging feedback that shows my progress so I feel motivated to continue.

**Acceptance Criteria:**
- [ ] "I'm Done" button visible during reading session
- [ ] On click, display full-screen encouragement screen
- [ ] Show: Verses read today, Hasanat earned, Current streak, Progress toward daily goal
- [ ] Display motivational Quranic verse or hadith (randomized)
- [ ] Celebration animation for milestones (first completion, 7-day streak, etc.)
- [ ] "Share Achievement" button (optional)
- [ ] "Continue Reading" or "Finish Session" options

**UI Design:**
```
┌─────────────────────────────────────┐
│         ✨ Alhamdulillah! ✨        │
├─────────────────────────────────────┤
│                                      │
│     [Celebration Animation]          │
│                                      │
│  You read 15 verses today!           │
│                                      │
│  📿 Hasanat Earned: 4,230            │
│  🔥 Current Streak: 8 days           │
│  🎯 Daily Goal: ✓ Completed          │
│                                      │
├─────────────────────────────────────┤
│  "The best of you are those who      │
│   learn the Quran and teach it."     │
│   - Prophet Muhammad ﷺ               │
├─────────────────────────────────────┤
│  [Share Achievement] [Continue]      │
└─────────────────────────────────────┘
```

**Backend Logic:**
```python
@router.post("/api/v1/sessions/complete")
async def complete_session(
    session_id: UUID,
    user_id: UUID,
    verses_read: int
):
    # Update session
    session = update_session_completion(session_id, verses_read)
    
    # Calculate hasanat
    hasanat = calculate_session_hasanat(verses_read)
    
    # Update user stats
    user_stats = update_user_statistics(user_id, verses_read, hasanat)
    
    # Check streak
    streak = calculate_streak(user_id)
    
    # Check if goal achieved
    goal_achieved = check_daily_goal(user_id)
    
    # Get motivational content
    motivation = get_random_motivation_quote()
    
    # Check for milestones
    milestone = check_milestone_achievement(user_id, streak, hasanat)
    
    return {
        "verses_read": verses_read,
        "hasanat_earned": hasanat,
        "total_hasanat": user_stats.total_hasanat,
        "current_streak": streak,
        "goal_achieved": goal_achieved,
        "motivation_quote": motivation,
        "milestone": milestone  # e.g., "First week completed!"
    }

def calculate_streak(user_id: UUID) -> int:
    """Calculate consecutive days of reading"""
    sessions = get_user_sessions(user_id, order_by="desc")
    streak = 0
    current_date = date.today()
    
    for session in sessions:
        session_date = session.created_at.date()
        if session_date == current_date or session_date == current_date - timedelta(days=streak):
            streak += 1
            current_date = session_date
        else:
            break
    
    return streak
```

#### 5.5.2 Motivational Content Database
**Priority:** P1 (Post-MVP)

**Acceptance Criteria:**
- [ ] Database of 100+ Quranic verses about reading Quran
- [ ] Database of 100+ relevant hadiths
- [ ] Database of 50+ inspirational quotes from scholars
- [ ] Content in multiple languages
- [ ] Randomized selection, avoid repetition
- [ ] User can favorite motivational content

**Database:**
```python
class MotivationalContent:
    content_id: UUID (PK)
    content_type: Enum['quran', 'hadith', 'quote']
    arabic_text: Text
    translation: Text
    language: String
    source: String  # e.g., "Sahih Bukhari 5027"
    category: String  # e.g., "perseverance", "reward"
    
class UserFavoriteContent:
    user_id: UUID (FK)
    content_id: UUID (FK)
    favorited_at: DateTime

# ML-powered content recommendation
def get_personalized_motivation(user_id: UUID) -> MotivationalContent:
    """Use ML to select most relevant motivational content"""
    user_context = get_user_context(user_id)
    
    # Factors: current streak, time of day, recent achievements, struggle patterns
    content_candidates = query_motivational_content(user_context)
    
    # ML model predicts which content will be most motivating
    best_content = motivation_recommendation_model.predict(
        user_features=user_context,
        content_features=content_candidates
    )
    
    return best_content
```

---

### 5.6 Social Features

#### 5.6.1 User Profiles & Friend System
**Priority:** P1 (Post-MVP, Phase 3)

**User Story:**
As a user, I want to connect with friends so we can motivate each other and share our Quran reading journey.

**Acceptance Criteria:**
- [ ] User profile with: Username, Display name, Profile picture, Bio, Join date
- [ ] Public reading stats: Total verses read, Current streak, Hasanat earned
- [ ] Privacy settings: Public, Friends-only, Private
- [ ] Friend request system: Send, Accept, Decline
- [ ] Friend list with search functionality
- [ ] View friend's profile and public stats
- [ ] Unfriend option
- [ ] Block user functionality

**Database Models:**
```python
class UserProfile:
    user_id: UUID (PK, FK)
    username: String (unique, indexed)
    display_name: String
    profile_picture_url: String
    bio: Text (max 500 chars)
    privacy_level: Enum['public', 'friends', 'private']
    show_on_leaderboard: Boolean
    created_at: DateTime
    updated_at: DateTime

class Friendship:
    friendship_id: UUID (PK)
    user_id: UUID (FK)
    friend_id: UUID (FK)
    status: Enum['pending', 'accepted', 'declined', 'blocked']
    requested_at: DateTime
    responded_at: DateTime
    
    # Composite unique constraint on (user_id, friend_id)
    
class UserStats:
    user_id: UUID (FK)
    total_verses_read: Integer
    total_hasanat: BigInteger
    current_streak: Integer
    longest_streak: Integer
    total_sessions: Integer
    total_reading_time_minutes: Integer
    surahs_completed: JSONB  # Array of surah numbers
    juz_completed: JSONB  # Array of juz numbers
    updated_at: DateTime
```

**API Endpoints:**
```python
@router.post("/api/v1/friends/request")
async def send_friend_request(
    from_user_id: UUID,
    to_user_id: UUID
):
    """Send friend request"""
    friendship = create_friendship_request(from_user_id, to_user_id)
    send_notification(to_user_id, "friend_request", from_user_id)
    return {"status": "sent", "friendship_id": friendship.friendship_id}

@router.post("/api/v1/friends/{friendship_id}/accept")
async def accept_friend_request(friendship_id: UUID, user_id: UUID):
    """Accept friend request"""
    friendship = update_friendship_status(friendship_id, "accepted")
    create_bidirectional_friendship(friendship)
    send_notification(friendship.user_id, "friend_request_accepted", user_id)
    return {"status": "accepted"}

@router.get("/api/v1/friends")
async def get_friends(user_id: UUID, status: str = "accepted"):
    """Get user's friends list"""
    friends = query_friends(user_id, status)
    return {
        "friends": [
            {
                "friend_id": f.friend_id,
                "username": f.username,
                "display_name": f.display_name,
                "profile_picture": f.profile_picture_url,
                "current_streak": f.stats.current_streak
            }
            for f in friends
        ]
    }

@router.get("/api/v1/users/{username}")
async def get_user_profile(username: str, viewer_id: UUID):
    """Get user profile (respects privacy settings)"""
    user = get_user_by_username(username)
    
    # Check privacy permissions
    can_view = check_view_permission(viewer_id, user.user_id, user.privacy_level)
    
    if not can_view:
        return {"error": "Profile is private"}, 403
    
    stats = get_user_stats(user.user_id)
    
    return {
        "user_id": user.user_id,
        "username": user.username,
        "display_name": user.display_name,
        "profile_picture": user.profile_picture_url,
        "bio": user.bio,
        "stats": {
            "total_verses": stats.total_verses_read,
            "current_streak": stats.current_streak,
            "total_hasanat": stats.total_hasanat
        } if user.privacy_level != 'private' else None
    }
```

#### 5.6.2 In-App Messaging
**Priority:** P1 (Post-MVP, Phase 3)

**User Story:**
As a user, I want to message my friends directly so we can encourage each other and discuss verses we've read.

**Acceptance Criteria:**
- [ ] One-to-one chat with friends only
- [ ] Send text messages
- [ ] Share verses with reference (e.g., "Al-Baqarah 2:255")
- [ ] Share achievements (e.g., "I completed 7-day streak!")
- [ ] Real-time message delivery via WebSocket
- [ ] Message read receipts (optional)
- [ ] Push notifications for new messages
- [ ] Chat history persistence
- [ ] Block/report functionality
- [ ] Delete messages (own messages only)

**Database Models:**
```python
class Conversation:
    conversation_id: UUID (PK)
    participant_1: UUID (FK)
    participant_2: UUID (FK)
    created_at: DateTime
    last_message_at: DateTime
    
class Message:
    message_id: UUID (PK)
    conversation_id: UUID (FK)
    sender_id: UUID (FK)
    message_type: Enum['text', 'verse_share', 'achievement_share']
    content: Text
    metadata: JSONB  # For verse references, achievement data
    sent_at: DateTime
    read_at: DateTime (nullable)
    is_deleted: Boolean
    
class MessageReadStatus:
    message_id: UUID (FK)
    user_id: UUID (FK)
    read_at: DateTime
```

**WebSocket Implementation:**
```python
# Django Channels / FastAPI WebSocket
class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.user_id = self.scope['user_id']
        self.room_group_name = f'chat_{self.user_id}'
        
        await self.channel_layer.group_add(
            self.room_group_name,
            self.channel_name
        )
        await self.accept()
    
    async def receive(self, text_data):
        data = json.loads(text_data)
        message_type = data['type']
        
        if message_type == 'send_message':
            message = await create_message(
                conversation_id=data['conversation_id'],
                sender_id=self.user_id,
                content=data['content']
            )
            
            # Send to recipient
            recipient_id = get_conversation_recipient(
                data['conversation_id'], 
                self.user_id
            )
            
            await self.channel_layer.group_send(
                f'chat_{recipient_id}',
                {
                    'type': 'chat_message',
                    'message': message.to_dict()
                }
            )
            
            # Send push notification if recipient offline
            await send_push_notification(recipient_id, message)
    
    async def chat_message(self, event):
        await self.send(text_data=json.dumps(event['message']))
```

**Flutter WebSocket Client:**
```dart
class ChatService {
  late WebSocketChannel channel;
  
  void connect(String userId, String token) {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://api.quranapp.com/ws/chat?token=$token')
    );
    
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      _handleIncomingMessage(data);
    });
  }
  
  void sendMessage(String conversationId, String content) {
    channel.sink.add(jsonEncode({
      'type': 'send_message',
      'conversation_id': conversationId,
      'content': content
    }));
  }
  
  void shareVerse(String conversationId, int surah, int verse) {
    channel.sink.add(jsonEncode({
      'type': 'send_message',
      'conversation_id': conversationId,
      'message_type': 'verse_share',
      'metadata': {
        'surah': surah,
        'verse': verse
      }
    }));
  }
}
```

#### 5.6.3 Group Chats
**Priority:** P2 (Future Enhancement)

**Acceptance Criteria:**
- [ ] Create group with friends (max 50 members)
- [ ] Group name and description
- [ ] Add/remove members (creator only)
- [ ] Group chat messaging
- [ ] Share group challenges

**Database:**
```python
class GroupChat:
    group_id: UUID (PK)
    group_name: String
    description: Text
    creator_id: UUID (FK)
    created_at: DateTime
    
class GroupMember:
    group_id: UUID (FK)
    user_id: UUID (FK)
    role: Enum['creator', 'admin', 'member']
    joined_at: DateTime
```

#### 5.6.4 Community Feed
**Priority:** P1 (Post-MVP, Phase 3)

**User Story:**
As a user, I want to share my reflections and read others' posts so I can feel part of a larger community.

**Acceptance Criteria:**
- [ ] Create text post (max 500 characters)
- [ ] Share verse with personal reflection
- [ ] Share achievement with context
- [ ] Like, comment, and share posts
- [ ] Follow users to see their posts in feed
- [ ] Explore page with trending posts
- [ ] Report inappropriate content
- [ ] Content moderation queue for admins

**UI Design (X/Twitter-style):**
```
┌─────────────────────────────────────┐
│  [👤 Profile]  Community  [🔔 3]    │
├─────────────────────────────────────┤
│  [What's on your mind? Write post...] │
├─────────────────────────────────────┤
│  👤 Sarah Ahmed  @sarah_22  • 2h     │
│  Just completed Surah Ar-Rahman!     │
│  The description of Paradise is so   │
│  beautiful. Alhamdulillah 🤲         │
│                                      │
│  ❤️ 24   💬 5   🔄 3                 │
├─────────────────────────────────────┤
│  👤 Ahmed Khan  @ahmk  • 5h          │
│  📿 Shared: Al-Baqarah 2:286        │
│  "Allah does not burden a soul       │
│  beyond that it can bear..."         │
│                                      │
│  This verse always gives me hope     │
│  when things are difficult. 💚       │
│                                      │
│  ❤️ 156   💬 23   🔄 45              │
└─────────────────────────────────────┘
```

**Database Models:**
```python
class Post:
    post_id: UUID (PK)
    user_id: UUID (FK)
    post_type: Enum['text', 'verse_share', 'achievement', 'reflection']
    content: Text (max 500 chars)
    verse_reference: JSONB (nullable)  # {surah, verse}
    achievement_data: JSONB (nullable)
    media_urls: JSONB (array of image URLs)
    created_at: DateTime
    updated_at: DateTime
    is_hidden: Boolean  # Moderation
    like_count: Integer (denormalized)
    comment_count: Integer (denormalized)
    share_count: Integer (denormalized)

class PostLike:
    like_id: UUID (PK)
    post_id: UUID (FK)
    user_id: UUID (FK)
    created_at: DateTime
    
class PostComment:
    comment_id: UUID (PK)
    post_id: UUID (FK)
    user_id: UUID (FK)
    content: Text (max 300 chars)
    parent_comment_id: UUID (FK, nullable)  # For nested comments
    created_at: DateTime
    
class PostShare:
    share_id: UUID (PK)
    post_id: UUID (FK)
    user_id: UUID (FK)
    shared_at: DateTime

class UserFollow:
    follower_id: UUID (FK)
    following_id: UUID (FK)
    followed_at: DateTime
```

**API Endpoints:**
```python
@router.post("/api/v1/posts")
async def create_post(
    user_id: UUID,
    post_type: str,
    content: str,
    verse_reference: dict = None
):
    """Create new post"""
    # Content moderation check (ML-based)
    is_appropriate = await moderate_content(content)
    
    if not is_appropriate:
        return {"error": "Content violates community guidelines"}, 400
    
    post = create_community_post(user_id, post_type, content, verse_reference)
    
    # Notify followers
    await notify_followers(user_id, post.post_id)
    
    return {"post_id": post.post_id, "created_at": post.created_at}

@router.get("/api/v1/feed")
async def get_feed(
    user_id: UUID,
    feed_type: str = "following",  # following, explore, trending
    limit: int = 20,
    offset: int = 0
):
    """Get community feed"""
    if feed_type == "following":
        posts = get_following_posts(user_id, limit, offset)
    elif feed_type == "explore":
        posts = get_explore_posts(user_id, limit, offset)
    elif feed_type == "trending":
        posts = get_trending_posts(limit, offset)
    
    return {
        "posts": [format_post(p) for p in posts],
        "has_more": len(posts) == limit
    }

@router.post("/api/v1/posts/{post_id}/like")
async def like_post(post_id: UUID, user_id: UUID):
    """Like a post"""
    like = create_post_like(post_id, user_id)
    increment_like_count(post_id)
    notify_post_author(post_id, "like", user_id)
    return {"status": "liked"}

@router.post("/api/v1/posts/{post_id}/comment")
async def comment_on_post(
    post_id: UUID,
    user_id: UUID,
    content: str,
    parent_comment_id: UUID = None
):
    """Comment on post"""
    comment = create_comment(post_id, user_id, content, parent_comment_id)
    increment_comment_count(post_id)
    notify_post_author(post_id, "comment", user_id)
    return {"comment_id": comment.comment_id}
```

**Content Moderation (ML-based):**
```python
from transformers import pipeline

# Load pre-trained moderation model
moderation_classifier = pipeline(
    "text-classification",
    model="unitary/toxic-bert"
)

async def moderate_content(text: str) -> bool:
    """
    Check if content is appropriate using ML model.
    Returns True if content is safe, False otherwise.
    """
    result = moderation_classifier(text)[0]
    
    # Check for toxic content
    if result['label'] == 'toxic' and result['score'] > 0.7:
        return False
    
    # Additional Islamic content guidelines
    if contains_inappropriate_islamic_content(text):
        return False
    
    return True

def contains_inappropriate_islamic_content(text: str) -> bool:
    """
    Check for content that violates Islamic guidelines.
    - Disrespect to Allah, prophets, or religious figures
    - Promotion of sectarian hatred
    - Mockery of religious practices
    """
    # Implement keyword-based and ML-based checks
    forbidden_patterns = load_forbidden_patterns()
    
    for pattern in forbidden_patterns:
        if re.search(pattern, text, re.IGNORECASE):
            return True
    
    return False
```

---

### 5.7 Leaderboard System

#### 5.7.1 Three-Tier Leaderboards
**Priority:** P1 (Post-MVP, Phase 3)

**User Story:**
As a user, I want to see how I rank compared to my friends and others globally so I can feel motivated by friendly competition.

**Acceptance Criteria:**
- [ ] Three leaderboard categories: Friends, Regional, Global
- [ ] Rankings based on total hasanat earned
- [ ] Time period filters: Today, This Week, This Month, All Time
- [ ] Display: Rank, Username, Hasanat, Streak
- [ ] User's own rank always visible (sticky header if not in top 10)
- [ ] Top 3 get special badges/icons
- [ ] Opt-in/opt-out toggle for appearing on leaderboards
- [ ] Anonymous mode option (show rank but hide username)
- [ ] Refresh button with rate limiting

**UI Design:**
```
┌─────────────────────────────────────┐
│  🏆 Leaderboard                      │
│  [Friends] [Regional] [Global]       │
│  [Today] [Week] [Month] [All Time]   │
├─────────────────────────────────────┤
│  YOUR RANK: #47 (12,450 hasanat)    │
├─────────────────────────────────────┤
│  1. 🥇 @aisha_m      245,670 📿 45🔥│
│  2. 🥈 @kareem.k     198,230 📿 38🔥│
│  3. 🥉 @fatima.z     176,890 📿 52🔥│
│  4.    @ibrahim.a    145,320 📿 28🔥│
│  5.    @maryam.s     132,100 📿 41🔥│
│  ...                                 │
└─────────────────────────────────────┘
```

**Database Models:**
```python
class Leaderboard:
    leaderboard_id: UUID (PK)
    leaderboard_type: Enum['friends', 'regional', 'global']
    time_period: Enum['today', 'week', 'month', 'all_time']
    generated_at: DateTime
    data: JSONB  # Cached leaderboard data
    
class LeaderboardEntry:
    user_id: UUID (FK)
    leaderboard_id: UUID (FK)
    rank: Integer
    hasanat: BigInteger
    verses_read: Integer
    current_streak: Integer
    
class UserLeaderboardSettings:
    user_id: UUID (FK)
    show_on_friends: Boolean (default: True)
    show_on_regional: Boolean (default: True)
    show_on_global: Boolean (default: True)
    anonymous_mode: Boolean (default: False)
```

**Efficient Leaderboard Calculation:**
```python
# Use materialized views and caching for performance
@cache(ttl=300)  # Cache for 5 minutes
def get_leaderboard(
    leaderboard_type: str,
    time_period: str,
    user_id: UUID = None,
    limit: int = 100
) -> Dict:
    """
    Get leaderboard data with efficient querying.
    Uses Redis for caching and PostgreSQL materialized views.
    """
    cache_key = f"leaderboard:{leaderboard_type}:{time_period}"
    
    # Try cache first
    cached_data = redis_client.get(cache_key)
    if cached_data:
        leaderboard_data = json.loads(cached_data)
    else:
        # Generate leaderboard from database
        if time_period == "today":
            start_date = datetime.now().date()
        elif time_period == "week":
            start_date = datetime.now().date() - timedelta(days=7)
        elif time_period == "month":
            start_date = datetime.now().date() - timedelta(days=30)
        else:  # all_time
            start_date = None
        
        query = build_leaderboard_query(
            leaderboard_type, 
            start_date, 
            user_id
        )
        
        leaderboard_data = db.execute(query).fetchall()
        
        # Cache result
        redis_client.setex(
            cache_key, 
            300,  # 5 minutes
            json.dumps(leaderboard_data)
        )
    
    # Get user's rank if not in top 100
    user_rank = None
    if user_id:
        user_rank = get_user_rank(user_id, leaderboard_type, time_period)
    
    return {
        "leaderboard_type": leaderboard_type,
        "time_period": time_period,
        "entries": leaderboard_data[:limit],
        "user_rank": user_rank,
        "generated_at": datetime.now().isoformat()
    }

def build_leaderboard_query(
    leaderboard_type: str,
    start_date: date,
    user_id: UUID
):
    """Build efficient SQL query for leaderboard"""
    base_query = """
        WITH user_hasanat AS (
            SELECT 
                u.user_id,
                u.username,
                u.display_name,
                SUM(rs.hasanat_earned) as total_hasanat,
                SUM(rs.verses_read) as total_verses,
                MAX(us.current_streak) as current_streak
            FROM users u
            JOIN reading_sessions rs ON u.user_id = rs.user_id
            JOIN user_stats us ON u.user_id = us.user_id
            JOIN user_leaderboard_settings uls ON u.user_id = uls.user_id
            WHERE 1=1
    """
    
    # Add filters based on leaderboard type
    if leaderboard_type == "friends":
        base_query += f"""
            AND u.user_id IN (
                SELECT friend_id FROM friendships 
                WHERE user_id = '{user_id}' AND status = 'accepted'
            )
        """
    elif leaderboard_type == "regional":
        user_region = get_user_region(user_id)
        base_query += f" AND u.region = '{user_region}' "
    
    # Add time filter
    if start_date:
        base_query += f" AND rs.created_at >= '{start_date}' "
    
    # Add privacy filters
    if leaderboard_type == "friends":
        base_query += " AND uls.show_on_friends = TRUE "
    elif leaderboard_type == "regional":
        base_query += " AND uls.show_on_regional = TRUE "
    elif leaderboard_type == "global":
        base_query += " AND uls.show_on_global = TRUE "
    
    base_query += """
            GROUP BY u.user_id, u.username, u.display_name
        )
        SELECT 
            ROW_NUMBER() OVER (ORDER BY total_hasanat DESC) as rank,
            user_id,
            username,
            display_name,
            total_hasanat,
            total_verses,
            current_streak
        FROM user_hasanat
        ORDER BY total_hasanat DESC
        LIMIT 100
    """
    
    return base_query

@router.get("/api/v1/leaderboard/{leaderboard_type}")
async def get_leaderboard_api(
    leaderboard_type: str,
    time_period: str = "week",
    user_id: UUID = None
):
    """API endpoint for leaderboard"""
    return get_leaderboard(leaderboard_type, time_period, user_id)
```

**Regional Leaderboard:**
```python
class UserLocation:
    user_id: UUID (FK)
    country: String
    region: String  # State/Province
    city: String
    timezone: String
    
def get_user_region(user_id: UUID) -> str:
    """Get user's region for regional leaderboard"""
    location = db.query(UserLocation).filter(
        UserLocation.user_id == user_id
    ).first()
    return location.country if location else "global"
```

---

### 5.8 Challenge System

#### 5.8.1 User-Created Challenges
**Priority:** P1 (Post-MVP, Phase 3)

**User Story:**
As a user, I want to create challenges with my friends so we can motivate each other to read more Quran together.

**Acceptance Criteria:**
- [ ] Create challenge with custom parameters
- [ ] Challenge types: Verse count, Time-based, Surah completion, Hasanat target
- [ ] Set duration: 1 day, 3 days, 1 week, custom
- [ ] Invite specific friends or make open to all friends
- [ ] Track real-time progress for all participants
- [ ] Display winner(s) upon completion
- [ ] Notifications for challenge updates
- [ ] Challenge history and stats

**UI - Create Challenge:**
```
┌─────────────────────────────────────┐
│  Create Challenge                    │
├─────────────────────────────────────┤
│  Challenge Name:                     │
│  [7-Day Streak Challenge_______]    │
│                                      │
│  Type:                               │
│  ◉ Verse Count  ○ Time  ○ Surah     │
│                                      │
│  Goal: [100] verses                  │
│                                      │
│  Duration: [7] days                  │
│                                      │
│  Invite Friends:                     │
│  ✓ @aisha_m                          │
│  ✓ @kareem_k                         │
│  ✓ @fatima_z                         │
│                                      │
│  [Create Challenge]                  │
└─────────────────────────────────────┘
```

**Database Models:**
```python
class Challenge:
    challenge_id: UUID (PK)
    creator_id: UUID (FK)
    challenge_name: String
    challenge_type: Enum['verse_count', 'time_based', 'surah_completion', 'hasanat_target']
    goal_value: Integer
    duration_days: Integer
    start_date: DateTime
    end_date: DateTime
    is_public: Boolean  # Open to all friends vs invite-only
    status: Enum['pending', 'active', 'completed', 'cancelled']
    created_at: DateTime
    
class ChallengeParticipant:
    participant_id: UUID (PK)
    challenge_id: UUID (FK)
    user_id: UUID (FK)
    invitation_status: Enum['invited', 'accepted', 'declined']
    current_progress: Integer
    goal_achieved: Boolean
    rank: Integer (nullable)  # Final rank after challenge ends
    joined_at: DateTime
    
class ChallengeProgress:
    progress_id: UUID (PK)
    challenge_id: UUID (FK)
    user_id: UUID (FK)
    progress_value: Integer
    recorded_at: DateTime
```

**API Endpoints:**
```python
@router.post("/api/v1/challenges")
async def create_challenge(
    creator_id: UUID,
    challenge_name: str,
    challenge_type: str,
    goal_value: int,
    duration_days: int,
    invited_users: List[UUID]
):
    """Create new challenge"""
    challenge = Challenge(
        creator_id=creator_id,
        challenge_name=challenge_name,
        challenge_type=challenge_type,
        goal_value=goal_value,
        duration_days=duration_days,
        start_date=datetime.now(),
        end_date=datetime.now() + timedelta(days=duration_days),
        status='pending'
    )
    db.add(challenge)
    db.commit()
    
    # Send invitations
    for user_id in invited_users:
        participant = ChallengeParticipant(
            challenge_id=challenge.challenge_id,
            user_id=user_id,
            invitation_status='invited'
        )
        db.add(participant)
        send_notification(user_id, "challenge_invitation", challenge.challenge_id)
    
    db.commit()
    
    return {"challenge_id": challenge.challenge_id}

@router.post("/api/v1/challenges/{challenge_id}/accept")
async def accept_challenge(challenge_id: UUID, user_id: UUID):
    """Accept challenge invitation"""
    participant = db.query(ChallengeParticipant).filter(
        ChallengeParticipant.challenge_id == challenge_id,
        ChallengeParticipant.user_id == user_id
    ).first()
    
    participant.invitation_status = 'accepted'
    participant.joined_at = datetime.now()
    db.commit()
    
    # Start challenge if all invited users have responded
    check_and_start_challenge(challenge_id)
    
    return {"status": "accepted"}

@router.get("/api/v1/challenges/{challenge_id}/leaderboard")
async def get_challenge_leaderboard(challenge_id: UUID):
    """Get real-time challenge leaderboard"""
    participants = db.query(
        ChallengeParticipant,
        User.username,
        User.display_name
    ).join(User).filter(
        ChallengeParticipant.challenge_id == challenge_id,
        ChallengeParticipant.invitation_status == 'accepted'
    ).order_by(
        ChallengeParticipant.current_progress.desc()
    ).all()
    
    challenge = db.query(Challenge).filter(
        Challenge.challenge_id == challenge_id
    ).first()
    
    return {
        "challenge": {
            "name": challenge.challenge_name,
            "goal": challenge.goal_value,
            "end_date": challenge.end_date.isoformat()
        },
        "participants": [
            {
                "rank": idx + 1,
                "username": p.username,
                "display_name": p.display_name,
                "progress": p.current_progress,
                "goal_achieved": p.current_progress >= challenge.goal_value
            }
            for idx, p in enumerate(participants)
        ]
    }

# Background task to update challenge progress
async def update_challenge_progress(user_id: UUID, verses_read: int):
    """
    Update user's progress in all active challenges.
    Called after each reading session.
    """
    active_challenges = db.query(Challenge).join(
        ChallengeParticipant
    ).filter(
        ChallengeParticipant.user_id == user_id,
        ChallengeParticipant.invitation_status == 'accepted',
        Challenge.status == 'active',
        Challenge.end_date > datetime.now()
    ).all()
    
    for challenge in active_challenges:
        participant = db.query(ChallengeParticipant).filter(
            ChallengeParticipant.challenge_id == challenge.challenge_id,
            ChallengeParticipant.user_id == user_id
        ).first()
        
        # Update progress based on challenge type
        if challenge.challenge_type == 'verse_count':
            participant.current_progress += verses_read
        
        # Check if goal achieved
        if participant.current_progress >= challenge.goal_value:
            participant.goal_achieved = True
            notify_challenge_participants(
                challenge.challenge_id,
                f"{participant.username} completed the challenge!"
            )
        
        db.commit()
```

#### 5.8.2 Auto-Generated Challenges
**Priority:** P1 (Post-MVP, Phase 3)

**User Story:**
As a user, I want to receive recommended challenges based on Islamic traditions so I can follow Sunnah and build good habits.

**Acceptance Criteria:**
- [ ] Weekly auto-generated challenges appear every Monday
- [ ] Friday challenge: Read Surah Al-Kahf (18)
- [ ] Monday/Thursday challenges for optional fasting days
- [ ] Ramadan-specific challenges (if during Ramadan)
- [ ] First 10 days of Dhul Hijjah challenges
- [ ] Beginner-friendly challenges for new users
- [ ] Users can join/decline challenges
- [ ] Challenges adapt to user's reading level (ML-based)

**Challenge Templates:**
```python
class ChallengeTemplate:
    template_id: UUID (PK)
    template_name: String
    description: Text
    challenge_type: Enum['verse_count', 'surah_completion', 'time_based']
    goal_value: Integer
    duration_days: Integer
    recurrence: Enum['weekly', 'monthly', 'annual', 'special_occasion']
    islamic_significance: Text
    difficulty_level: Enum['beginner', 'intermediate', 'advanced']
    tags: JSONB  # ['friday', 'sunnah', 'ramadan']

# Pre-defined challenge templates
CHALLENGE_TEMPLATES = [
    {
        "name": "Friday Surah Al-Kahf",
        "description": "Read Surah Al-Kahf on Friday as recommended by the Prophet ﷺ",
        "challenge_type": "surah_completion",
        "goal_value": 1,  # 1 surah
        "duration_days": 1,
        "recurrence": "weekly",
        "day_of_week": "friday",
        "islamic_significance": "The Prophet ﷺ said: 'Whoever reads Surah Al-Kahf on Friday, light will shine for him between the two Fridays.'",
        "difficulty": "intermediate"
    },
    {
        "name": "Last 10 Nights of Ramadan",
        "description": "Complete one Juz per night during the last 10 nights",
        "challenge_type": "verse_count",
        "goal_value": 600,  # Approximate verses per juz
        "duration_days": 10,
        "recurrence": "annual",
        "islamic_significance": "Seek Laylatul Qadr in the odd nights of the last 10",
        "difficulty": "advanced"
    },
    {
        "name": "Monday Momentum",
        "description": "Start your week strong with 15 verses",
        "challenge_type": "verse_count",
        "goal_value": 15,
        "duration_days": 1,
        "recurrence": "weekly",
        "day_of_week": "monday",
        "difficulty": "beginner"
    }
]

# ML-powered challenge recommendation
async def generate_personalized_challenges(user_id: UUID) -> List[Challenge]:
    """
    Use ML to recommend challenges based on:
    - User's reading history
    - Current skill level
    - Previous challenge completion rate
    - Time of year (Ramadan, Dhul Hijjah, etc.)
    - Friends' active challenges
    """
    user_profile = get_user_reading_profile(user_id)
    
    # Get appropriate difficulty level
    difficulty = ml_model.predict_user_level(user_profile)
    
    # Get contextually relevant templates
    current_date = datetime.now()
    islamic_calendar = get_islamic_calendar_context(current_date)
    
    # Filter templates
    relevant_templates = [
        t for t in CHALLENGE_TEMPLATES
        if t['difficulty'] == difficulty
        and is_template_relevant(t, current_date, islamic_calendar)
    ]
    
    # Rank templates by likelihood of completion
    ranked_templates = challenge_recommendation_model.rank(
        user_profile,
        relevant_templates
    )
    
    return ranked_templates[:3]  # Return top 3 recommendations

@router.get("/api/v1/challenges/recommended")
async def get_recommended_challenges(user_id: UUID):
    """Get personalized challenge recommendations"""
    challenges = await generate_personalized_challenges(user_id)
    return {"recommended_challenges": challenges}
```

**Automatic Challenge Creation (Cron Job):**
```python
# Celery/APScheduler task
@scheduler.scheduled_job('cron', day_of_week='fri', hour=0, minute=0)
async def create_friday_challenges():
    """
    Every Friday at midnight, create Surah Al-Kahf challenge
    for all active users who haven't opted out
    """
    active_users = db.query(User).filter(
        User.is_active == True,
        User.auto_challenges_enabled == True
    ).all()
    
    for user in active_users:
        challenge = Challenge(
            creator_id=None,  # System-generated
            challenge_name="Friday Surah Al-Kahf",
            challenge_type="surah_completion",
            goal_value=1,
            duration_days=1,
            start_date=datetime.now(),
            end_date=datetime.now() + timedelta(days=1),
            is_public=False,
            status='active'
        )
        db.add(challenge)
        
        participant = ChallengeParticipant(
            challenge_id=challenge.challenge_id,
            user_id=user.user_id,
            invitation_status='accepted'
        )
        db.add(participant)
        
        send_notification(
            user.user_id,
            "new_challenge",
            challenge.challenge_id,
            "It's Friday! Don't forget to read Surah Al-Kahf today."
        )
    
    db.commit()
```

---

### 5.9 Dua (Supplication) Library

#### 5.9.1 Categorized Dua Collection
**Priority:** P1 (Post-MVP)

**User Story:**
As a user, I want to access authentic duas for different situations so I can make proper supplications throughout my day.

**Acceptance Criteria:**
- [ ] Duas categorized by situation (morning, evening, travel, illness, etc.)
- [ ] Arabic text with diacritics
- [ ] Transliteration for non-Arabic speakers
- [ ] Translation in multiple languages
- [ ] Audio recitation for each dua
- [ ] Source reference (Quran verse or Hadith number)
- [ ] Contextual information (when to recite, benefits)
- [ ] Favorite/bookmark duas
- [ ] Search functionality
- [ ] Daily dua notifications

**Categories:**
```python
DUA_CATEGORIES = [
    "morning_evening",
    "before_after_meals",
    "before_after_sleep",
    "entering_exiting_home",
    "traveling",
    "illness_healing",
    "seeking_knowledge",
    "seeking_forgiveness",
    "gratitude_thanks",
    "difficulty_hardship",
    "before_after_wudu",
    "entering_masjid",
    "rain_weather",
    "for_parents",
    "for_children",
    "for_marriage",
    "general_duas"
]
```

**Database Models:**
```python
class Dua:
    dua_id: UUID (PK)
    category: String
    subcategory: String (nullable)
    arabic_text: Text
    transliteration: Text
    translation_en: Text
    translation_ar: Text (original if from Arabic hadith)
    translation_ur: Text
    translation_id: Text (Indonesian)
    translation_tr: Text (Turkish)
    source_type: Enum['quran', 'hadith', 'other']
    source_reference: String  # e.g., "Sahih Bukhari 6306"
    context: Text  # When to recite
    benefits: Text  # Spiritual benefits mentioned in sources
    audio_url: String
    reciter: String
    order_in_category: Integer
    created_at: DateTime
    
class UserFavoriteDua:
    user_id: UUID (FK)
    dua_id: UUID (FK)
    favorited_at: DateTime
    
class DuaNotificationSettings:
    user_id: UUID (FK)
    enable_morning_duas: Boolean
    morning_time: Time
    enable_evening_duas: Boolean
    evening_time: Time
    enable_contextual_duas: Boolean  # Based on location, time, etc.
```

**Sample Dua Data:**
```python
SAMPLE_DUAS = [
    {
        "category": "morning_evening",
        "arabic_text": "أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ",
        "transliteration": "Aṣbaḥnā wa aṣbaḥal-mulku lillāh, walḥamdu lillāh",
        "translation_en": "We have reached the morning and with it all dominion is Allah's, and all praise is for Allah.",
        "source_type": "hadith",
        "source_reference": "Muslim 2723",
        "context": "Recite in the morning after Fajr",
        "benefits": "Protection and seeking Allah's dominion"
    },
    {
        "category": "before_after_meals",
        "arabic_text": "بِسْمِ اللهِ",
        "transliteration": "Bismillāh",
        "translation_en": "In the name of Allah",
        "source_type": "hadith",
        "source_reference": "Abu Dawud 3767",
        "context": "Recite before eating",
        "benefits": "Shaytan cannot eat with you when you mention Allah's name"
    }
]
```

**API Endpoints:**
```python
@router.get("/api/v1/duas")
async def get_duas(
    category: str = None,
    search: str = None,
    language: str = "en",
    limit: int = 50
):
    """Get duas with optional filtering"""
    query = db.query(Dua)
    
    if category:
        query = query.filter(Dua.category == category)
    
    if search:
        query = query.filter(
            or_(
                Dua.arabic_text.contains(search),
                Dua.transliteration.ilike(f"%{search}%"),
                getattr(Dua, f"translation_{language}").ilike(f"%{search}%")
            )
        )
    
    duas = query.order_by(Dua.order_in_category).limit(limit).all()
    
    return {
        "duas": [
            {
                "dua_id": d.dua_id,
                "category": d.category,
                "arabic_text": d.arabic_text,
                "transliteration": d.transliteration,
                "translation": getattr(d, f"translation_{language}"),
                "source": d.source_reference,
                "audio_url": d.audio_url
            }
            for d in duas
        ]
    }

@router.get("/api/v1/duas/categories")
async def get_dua_categories():
    """Get all dua categories with counts"""
    categories = db.query(
        Dua.category,
        func.count(Dua.dua_id).label('count')
    ).group_by(Dua.category).all()
    
    return {
        "categories": [
            {
                "category": c.category,
                "count": c.count,
                "display_name": format_category_name(c.category)
            }
            for c in categories
        ]
    }

@router.post("/api/v1/duas/{dua_id}/favorite")
async def favorite_dua(dua_id: UUID, user_id: UUID):
    """Add dua to favorites"""
    favorite = UserFavoriteDua(
        user_id=user_id,
        dua_id=dua_id,
        favorited_at=datetime.now()
    )
    db.add(favorite)
    db.commit()
    return {"status": "favorited"}
```

**Contextual Dua Recommendations (ML):**
```python
async def get_contextual_duas(user_id: UUID, context: dict) -> List[Dua]:
    """
    Recommend duas based on user's context:
    - Time of day
    - Location (home, masjid, traveling)
    - Recent activities
    - Current challenges/goals
    """
    current_time = context.get('time', datetime.now().time())
    location = context.get('location', 'unknown')
    user_state = context.get('user_state', 'normal')
    
    # Time-based recommendations
    if current_time.hour < 12:
        category = 'morning_evening'
    elif current_time.hour >= 18:
        category = 'morning_evening'
    
    # Location-based
    if location == 'masjid':
        category = 'entering_masjid'
    elif location == 'traveling':
        category = 'traveling'
    
    # State-based
    if user_state == 'difficulty':
        category = 'difficulty_hardship'
    
    duas = db.query(Dua).filter(
        Dua.category == category
    ).order_by(func.random()).limit(3).all()
    
    return duas

@router.get("/api/v1/duas/contextual")
async def get_contextual_duas_api(user_id: UUID):
    """Get contextual dua recommendations"""
    # Gather context
    context = {
        'time': datetime.now().time(),
        'location': get_user_current_location(user_id),
        'user_state': predict_user_state(user_id)  # ML model
    }
    
    duas = await get_contextual_duas(user_id, context)
    return {"contextual_duas": [format_dua(d) for d in duas]}
```

---

### 5.10 Prayer Times

#### 5.10.1 Location-Based Prayer Times
**Priority:** P0 (MVP)

**User Story:**
As a user, I want to see accurate prayer times for my location so I can pray on time and schedule my Quran reading around prayers.

**Acceptance Criteria:**
- [ ] Automatic prayer time calculation based on GPS location
- [ ] Manual location selection (city search)
- [ ] Display all 5 daily prayers: Fajr, Dhuhr, Asr, Maghrib, Isha
- [ ] Countdown to next prayer
- [ ] Multiple calculation methods (ISNA, Muslim World League, Egyptian, etc.)
- [ ] Adjustable notification timing (at prayer time, 10 min before, etc.)
- [ ] Qibla direction compass
- [ ] Integration with reading goals ("Read after Fajr")
- [ ] Hijri calendar date

**UI Design:**
```
┌─────────────────────────────────────┐
│  📍 London, UK  🕌 2 Sha'ban 1447   │
├─────────────────────────────────────┤
│  Next Prayer: Dhuhr in 2h 34m       │
│  ▓▓▓▓▓▓▓░░░░░░░░░░░                 │
├─────────────────────────────────────┤
│  Fajr      ✓  05:45 AM               │
│  Sunrise      07:32 AM               │
│  Dhuhr        12:15 PM               │
│  Asr          02:48 PM               │
│  Maghrib      04:58 PM               │
│  Isha         06:45 PM               │
├─────────────────────────────────────┤
│  [🧭 Qibla Direction]  [⚙️ Settings]│
└─────────────────────────────────────┘
```

**Database Models:**
```python
class PrayerTimeSettings:
    user_id: UUID (FK)
    calculation_method: Enum[
        'ISNA',  # Islamic Society of North America
        'MWL',   # Muslim World League
        'EGYPT', # Egyptian General Authority of Survey
        'MAKKAH', # Umm Al-Qura University, Makkah
        'KARACHI', # University of Islamic Sciences, Karachi
        'TEHRAN'  # Institute of Geophysics, University of Tehran
    ]
    fajr_notification: Boolean
    fajr_notification_minutes: Integer  # Minutes before
    dhuhr_notification: Boolean
    dhuhr_notification_minutes: Integer
    asr_notification: Boolean
    asr_notification_minutes: Integer
    maghrib_notification: Boolean
    maghrib_notification_minutes: Integer
    isha_notification: Boolean
    isha_notification_minutes: Integer
    
class UserLocation:
    user_id: UUID (FK)
    latitude: Float
    longitude: Float
    city: String
    country: String
    timezone: String
    updated_at: DateTime
```

**Prayer Time Calculation:**
```python
from praytimes import PrayTimes  # Python Islamic prayer times library

async def calculate_prayer_times(
    latitude: float,
    longitude: float,
    date: datetime,
    calculation_method: str = 'ISNA'
) -> dict:
    """
    Calculate prayer times for given location and date.
    Uses astronomical calculations based on sun position.
    """
    pt = PrayTimes(calculation_method)
    
    # Set calculation parameters
    if calculation_method == 'ISNA':
        pt.setMethod('ISNA')
    elif calculation_method == 'MWL':
        pt.setMethod('MWL')
    # ... other methods
    
    times = pt.getTimes(
        date,
        (latitude, longitude),
        timezone=get_timezone_offset(latitude, longitude)
    )
    
    return {
        'fajr': times['fajr'],
        'sunrise': times['sunrise'],
        'dhuhr': times['dhuhr'],
        'asr': times['asr'],
        'maghrib': times['maghrib'],
        'isha': times['isha']
    }

@router.get("/api/v1/prayer-times")
async def get_prayer_times(
    user_id: UUID,
    date: str = None
):
    """Get prayer times for user's location"""
    # Get user location
    location = db.query(UserLocation).filter(
        UserLocation.user_id == user_id
    ).first()
    
    if not location:
        return {"error": "Location not set"}, 404
    
    # Get user's calculation method preference
    settings = db.query(PrayerTimeSettings).filter(
        PrayerTimeSettings.user_id == user_id
    ).first()
    
    calculation_method = settings.calculation_method if settings else 'ISNA'
    
    # Parse date or use today
    prayer_date = datetime.fromisoformat(date) if date else datetime.now()
    
    # Calculate prayer times
    times = await calculate_prayer_times(
        location.latitude,
        location.longitude,
        prayer_date,
        calculation_method
    )
    
    # Get Hijri date
    hijri_date = get_hijri_date(prayer_date)
    
    return {
        "location": {
            "city": location.city,
            "country": location.country
        },
        "date": {
            "gregorian": prayer_date.strftime("%Y-%m-%d"),
            "hijri": hijri_date
        },
        "prayer_times": times,
        "next_prayer": get_next_prayer(times)
    }

def get_next_prayer(times: dict) -> dict:
    """Determine which prayer is next and time remaining"""
    current_time = datetime.now().time()
    prayer_order = ['fajr', 'dhuhr', 'asr', 'maghrib', 'isha']
    
    for prayer in prayer_order:
        prayer_time = datetime.strptime(times[prayer], "%H:%M").time()
        if current_time < prayer_time:
            time_diff = datetime.combine(date.today(), prayer_time) - \
                       datetime.combine(date.today(), current_time)
            return {
                "name": prayer,
                "time": times[prayer],
                "remaining_minutes": int(time_diff.total_seconds() / 60)
            }
    
    # If no prayer left today, next is Fajr tomorrow
    return {
        "name": "fajr",
        "time": times['fajr'],
        "remaining_minutes": "tomorrow"
    }
```

**Qibla Direction:**
```python
import math

def calculate_qibla_direction(latitude: float, longitude: float) -> float:
    """
    Calculate Qibla direction (bearing to Kaaba in Makkah).
    Kaaba coordinates: 21.4225° N, 39.8262° E
    """
    # Kaaba location
    kaaba_lat = math.radians(21.4225)
    kaaba_lon = math.radians(39.8262)
    
    # User location
    user_lat = math.radians(latitude)
    user_lon = math.radians(longitude)
    
    # Calculate bearing using Haversine formula
    delta_lon = kaaba_lon - user_lon
    
    x = math.sin(delta_lon) * math.cos(kaaba_lat)
    y = math.cos(user_lat) * math.sin(kaaba_lat) - \
        math.sin(user_lat) * math.cos(kaaba_lat) * math.cos(delta_lon)
    
    bearing = math.atan2(x, y)
    bearing = math.degrees(bearing)
    bearing = (bearing + 360) % 360  # Normalize to 0-360
    
    return bearing

@router.get("/api/v1/qibla")
async def get_qibla_direction(user_id: UUID):
    """Get Qibla direction for user's location"""
    location = db.query(UserLocation).filter(
        UserLocation.user_id == user_id
    ).first()
    
    if not location:
        return {"error": "Location not set"}, 404
    
    direction = calculate_qibla_direction(
        location.latitude,
        location.longitude
    )
    
    return {
        "qibla_direction": direction,
        "compass_direction": get_compass_direction(direction)
    }

def get_compass_direction(bearing: float) -> str:
    """Convert bearing to compass direction"""
    directions = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE',
                  'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW']
    index = round(bearing / (360 / len(directions))) % len(directions)
    return directions[index]
```

**Prayer Time Notifications:**
```python
from firebase_admin import messaging

async def schedule_prayer_notifications(user_id: UUID):
    """
    Schedule notifications for all prayers based on user preferences.
    Runs daily at midnight to schedule next day's notifications.
    """
    settings = db.query(PrayerTimeSettings).filter(
        PrayerTimeSettings.user_id == user_id
    ).first()
    
    location = db.query(UserLocation).filter(
        UserLocation.user_id == user_id
    ).first()
    
    # Calculate tomorrow's prayer times
    tomorrow = datetime.now() + timedelta(days=1)
    times = await calculate_prayer_times(
        location.latitude,
        location.longitude,
        tomorrow,
        settings.calculation_method
    )
    
    # Schedule notifications
    prayers = ['fajr', 'dhuhr', 'asr', 'maghrib', 'isha']
    
    for prayer in prayers:
        if getattr(settings, f"{prayer}_notification"):
            prayer_time = datetime.strptime(times[prayer], "%H:%M")
            notification_minutes = getattr(settings, f"{prayer}_notification_minutes")
            notification_time = prayer_time - timedelta(minutes=notification_minutes)
            
            # Schedule push notification
            schedule_push_notification(
                user_id=user_id,
                scheduled_time=notification_time,
                title=f"{prayer.capitalize()} Prayer Time",
                body=f"It's time for {prayer.capitalize()} prayer. Don't forget to read Quran!",
                data={'type': 'prayer_reminder', 'prayer': prayer}
            )

def schedule_push_notification(
    user_id: UUID,
    scheduled_time: datetime,
    title: str,
    body: str,
    data: dict
):
    """Schedule a push notification using FCM"""
    user_device = get_user_device_token(user_id)
    
    message = messaging.Message(
        notification=messaging.Notification(
            title=title,
            body=body
        ),
        data=data,
        token=user_device.fcm_token
    )
    
    # Use FCM scheduling or background task queue
    # (Firebase doesn't support native scheduling, use Celery/APScheduler)
    schedule_task(
        task=send_fcm_notification,
        args=[message],
        eta=scheduled_time
    )
```

---

## 6. Technical Architecture

### 6.1 System Architecture Overview

**High-Level Architecture:**
```
┌─────────────────────────────────────────────────────────────┐
│                     Mobile Clients                           │
│              (Flutter - iOS & Android)                       │
└────────────────┬────────────────────────────────────────────┘
                 │
                 │ HTTPS/WSS
                 │
┌────────────────┴────────────────────────────────────────────┐
│                   API Gateway / Load Balancer                │
│                    (Nginx / AWS ALB)                         │
└────────────────┬────────────────────────────────────────────┘
                 │
        ┌────────┴────────┐
        │                 │
┌───────┴────────┐ ┌─────┴──────────┐
│   REST API     │ │   WebSocket    │
│  (FastAPI)     │ │  (Django       │
│                │ │   Channels)    │
└───────┬────────┘ └─────┬──────────┘
        │                │
        └────────┬────────┘
                 │
┌────────────────┴────────────────────────────────────────────┐
│                    Business Logic Layer                      │
│   ┌─────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│   │  Auth   │  │  Quran   │  │  Social  │  │  ML/AI   │  │
│   │ Service │  │ Service  │  │ Service  │  │ Service  │  │
│   └─────────┘  └──────────┘  └──────────┘  └──────────┘  │
└────────────────┬────────────────────────────────────────────┘
                 │
        ┌────────┴────────┐
        │                 │
┌───────┴────────┐ ┌─────┴──────────┐
│   PostgreSQL   │ │     Redis      │
│   (Primary DB) │ │    (Cache)     │
└────────────────┘ └────────────────┘
        │
        └────────┬────────┐
                 │        │
        ┌────────┴────┐ ┌─┴────────────┐
        │   AWS S3    │ │  Firebase    │
        │   (Media)   │ │    (FCM)     │
        └─────────────┘ └──────────────┘
```

### 6.2 Technology Stack Details

#### 6.2.1 Frontend (Mobile)

Framework: Flutter 3.x
State Management: Riverpod / Provider
Local Storage: Hive / SQLite
Networking: Dio (HTTP client)
WebSocket: web_socket_channel
Push Notifications: firebase_messaging
Location Services: geolocator
Audio Playback: just_audio
Analytics: firebase_analytics
Crash Reporting: sentry_flutter

Flutter Project Structure:
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── network/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── quran/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── social/
│   ├── challenges/
│   ├── prayers/
│   └── duas/
├── shared/
│   ├── widgets/
│   ├── models/
│   └── services/
└── config/
    ├── routes/
    └── dependencies/
6.2.2 Backend (API Server)

Framework: FastAPI 0.100+
Language: Python 3.11+
ASGI Server: Uvicorn with Gunicorn
ORM: SQLAlchemy 2.0
Migration: Alembic
Validation: Pydantic v2
Authentication: JWT with PyJWT
Task Queue: Celery with Redis
WebSocket: Django Channels (alternative FastAPI stack)

Backend Project Structure:
backend/
├── app/
│   ├── main.py
│   ├── config.py
│   ├── database.py
│   ├── models/
│   │   ├── user.py
│   │   ├── quran.py
│   │   ├── social.py
│   │   └── challenge.py
│   ├── schemas/
│   │   └── (Pydantic models)
│   ├── api/
│   │   ├── v1/
│   │   │   ├── auth.py
│   │   │   ├── quran.py
│   │   │   ├── users.py
│   │   │   ├── social.py
│   │   │   ├── challenges.py
│   │   │   └── prayers.py
│   │   └── dependencies.py
│   ├── services/
│   │   ├── auth_service.py
│   │   ├── quran_service.py
│   │   ├── ml_service.py
│   │   └── notification_service.py
│   ├── ml/
│   │   ├── models/
│   │   ├── training/
│   │   └── inference.py
│   ├── utils/
│   └── tests/
├── alembic/
├── requirements.txt
└── docker-compose.yml
6.2.3 Database

Primary: PostgreSQL 15+
Extensions: pg_trgm (fuzzy search), pgcrypto
Connection Pooling: PgBouncer
Backup Strategy: Daily automated backups with point-in-time recovery

6.2.4 Caching & Session Management

Redis 7+
Use Cases:

Session storage
API response caching
Leaderboard caching
Rate limiting
Real-time features (pub/sub)



6.2.5 Storage

Object Storage: AWS S3 / Google Cloud Storage
CDN: CloudFront / Cloud CDN
Content:

User profile pictures
Mushaf page images
Audio files (Quran recitations, Dua)
Post media



6.2.6 Machine Learning Stack

Framework: PyTorch / TensorFlow
Libraries:

scikit-learn (traditional ML)
transformers (NLP for content moderation)
pandas, numpy (data processing)


Model Serving: TorchServe / TensorFlow Serving
Training Infrastructure: GPU instances (AWS p3, Google Cloud GPU)


7. User Interface & Experience
7.1 Design Principles

Simplicity: Clean, distraction-free reading experience
Respect: Reverence for Quranic content in all design choices
Accessibility: Support for users with different abilities
Delight: Subtle animations and encouraging feedback
Performance: Fast, responsive interactions

7.2 Key Screens
7.2.1 Home Screen
┌─────────────────────────────────────┐
│  ☰  Quran Habit Builder      👤 🔔  │
├─────────────────────────────────────┤
│  Assalamu Alaikum, Ahmad! 👋        │
│                                      │
│  ┌─────────────────────────────────┐│
│  │  Today's Goal: 10 verses         ││
│  │  Progress: 6/10 verses ✓         ││
│  │  ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░ 60%       ││
│  │                                  ││
│  │  [Continue Reading →]            ││
│  └─────────────────────────────────┘│
│                                      │
│  🔥 Current Streak: 8 days          │
│  📿 Total Hasanat: 45,230           │
│                                      │
│  ┌─────────────────────────────────┐│
│  │  📅 Today's Challenge            ││
│  │  Friday Surah Al-Kahf            ││
│  │  [Start Challenge →]             ││
│  └─────────────────────────────────┘│
│                                      │
│  🕌 Next Prayer: Dhuhr in 2h 15m    │
│                                      │
│  Quick Actions:                      │
│  [📖 Read] [🤲 Duas] [🏆 Challenges]│
└─────────────────────────────────────┘
7.2.2 Bottom Navigation
┌─────────────────────────────────────┐
│  [🏠 Home] [📖 Read] [👥 Social]    │
│  [🏆 Challenges] [⚙️ More]          │
└─────────────────────────────────────┘
7.3 Color Palette
Primary Colors:
- Islamic Green: #006747 (trust, growth)
- Gold Accent: #D4AF37 (premium, value)
- Deep Purple: #4A148C (spiritual depth)

Neutral Colors:
- Background: #FAFAFA (light mode)
- Dark Background: #121212 (dark mode)
- Text Primary: #212121
- Text Secondary: #757575

Semantic Colors:
- Success: #4CAF50
- Warning: #FF9800
- Error: #F44336
- Info: #2196F3
7.4 Typography
Arabic Text:
- Font: Traditional Arabic / Uthmanic (e.g., KFGQPC Uthmanic Script)
- Sizes: 24sp (main), 20sp (secondary)

Latin Text:
- Font: Inter / Roboto
- Headings: 20sp - 24sp (Semi-Bold)
- Body: 16sp (Regular)
- Caption: 14sp (Regular)
7.5 Animation Guidelines

Micro-interactions: 200-300ms
Page transitions: 300-400ms
Celebration animations: 500-1000ms
Easing: Ease-out for entrances, Ease-in for exits


8. Machine Learning Integration
8.1 ML Use Cases
8.1.1 Personalized Goal Recommendations
Objective: Recommend optimal reading goals for each user based on their behavior
Features:

Historical reading patterns
Time of day preferences
Session completion rates
Streak maintenance patterns
User demographics (age, location)

Model: Gradient Boosting (XGBoost) for regression
Output: Recommended verses per day (5-50 range)
Training Data:
pythonX_features = [
    'avg_daily_verses_last_7_days',
    'avg_daily_verses_last_30_days',
    'completion_rate',
    'avg_session_duration_minutes',
    'preferred_time_slot',
    'user_age',
    'days_since_registration',
    'longest_streak',
    'current_streak'
]

y_target = 'optimal_daily_goal'  # What user successfully maintains
8.1.2 Content Moderation
Objective: Automatically detect inappropriate content in community posts
Model: Fine-tuned BERT for text classification
Categories:

Safe
Potentially harmful (requires review)
Harmful (auto-block)

Implementation:
pythonfrom transformers import pipeline

moderation_model = pipeline(
    "text-classification",
    model="unitary/toxic-bert"
)

def moderate_post(text: str) -> dict:
    result = moderation_model(text)[0]
    
    # Additional Islamic content checks
    islamic_check = check_islamic_appropriateness(text)
    
    return {
        "is_safe": result['label'] == 'non-toxic' and islamic_check,
        "confidence": result['score'],
        "requires_review": result['score'] < 0.85
    }
8.1.3 Challenge Recommendation Engine
Objective: Recommend challenges most likely to be completed by user
Features:

User's reading level
Historical challenge completion rate
Time of year (Islamic calendar)
Friend participation
Recent reading patterns

Model: Collaborative Filtering + Content-Based
Implementation:
pythonclass ChallengeRecommender:
    def __init__(self):
        self.user_embeddings = load_user_embeddings()
        self.challenge_embeddings = load_challenge_embeddings()
    
    def recommend(self, user_id: UUID, n: int = 5) -> List[Challenge]:
        # Get user embedding
        user_vec = self.user_embeddings[user_id]
        
        # Calculate similarity scores
        scores = cosine_similarity(
            user_vec.reshape(1, -1),
            self.challenge_embeddings
        )[0]
        
        # Get top N challenges
        top_indices = np.argsort(scores)[-n:][::-1]
        
        return [self.challenges[i] for i in top_indices]
8.1.4 Smart Notification Timing
Objective: Send reading reminders at optimal times for each user
Features:

Historical app open times
Reading session start times
User timezone
Prayer times
Day of week patterns

Model: Time Series Analysis + Classification
Output: Probability distribution over 24-hour period
8.1.5 Churn Prediction
Objective: Identify users at risk of abandoning the app
Features:

Days since last session
Session frequency trend
Goal completion rate decline
Social engagement level
Streak breaks

Model: Random Forest Classifier
Action: Trigger personalized re-engagement campaign
8.2 ML Model Deployment
Model Serving Architecture:
┌──────────────────┐
│  FastAPI Server  │
│                  │
│  ┌────────────┐ │     ┌──────────────┐
│  │ ML Service │─┼────→│ Model Cache  │
│  │            │ │     │   (Redis)    │
│  └────────────┘ │     └──────────────┘
│        │         │
│        ↓         │
│  ┌────────────┐ │
│  │ TorchServe │ │
│  │  /  TF     │ │
│  │  Serving   │ │
│  └────────────┘ │
└──────────────────┘
Deployment Strategy:

Models served via dedicated microservice
A/B testing for model improvements
Monitoring: Prediction latency, accuracy metrics
Fallback: Rule-based system if ML unavailable

8.3 Continuous Improvement
Feedback Loop:

Collect user interactions
Label data (implicit & explicit feedback)
Retrain models monthly
A/B test new models
Deploy if performance improves

Key Metrics:

Goal completion rate improvement
Challenge participation increase
Engagement time increase
Churn rate reduction


9. Data Models & Database Schema
9.1 Core Tables
Users & Authentication
sqlCREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_profiles (
    user_id UUID PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    display_name VARCHAR(100),
    profile_picture_url VARCHAR(500),
    bio TEXT,
    date_of_birth DATE,
    gender VARCHAR(20),
    privacy_level VARCHAR(20) DEFAULT 'friends',
    show_on_leaderboard BOOLEAN DEFAULT TRUE,
    auto_challenges_enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_locations (
    user_id UUID PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    city VARCHAR(100),
    country VARCHAR(100),
    region VARCHAR(100),
    timezone VARCHAR(50),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_user_locations_country ON user_locations(country);
CREATE INDEX idx_user_locations_region ON user_locations(region);
Quran Data
sqlCREATE TABLE quran_verses (
    verse_id INTEGER PRIMARY KEY,
    surah_number INTEGER NOT NULL,
    verse_number INTEGER NOT NULL,
    arabic_text TEXT NOT NULL,
    simple_text TEXT NOT NULL,  -- Without diacritics
    letter_count INTEGER NOT NULL,
    word_count INTEGER NOT NULL,
    has_sajdah BOOLEAN DEFAULT FALSE,
    juz_number INTEGER,
    hizb_number INTEGER,
    page_number INTEGER,  -- Mushaf Medina pagination
    UNIQUE(surah_number, verse_number)
);

CREATE TABLE quran_translations (
    translation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    verse_id INTEGER REFERENCES quran_verses(verse_id),
    language VARCHAR(10) NOT NULL,
    translator_name VARCHAR(100),
    translation_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE quran_surahs (
    surah_number INTEGER PRIMARY KEY,
    surah_name_arabic VARCHAR(100) NOT NULL,
    surah_name_english VARCHAR(100) NOT NULL,
    revelation_place VARCHAR(20),  -- Makkah or Madinah
    verse_count INTEGER NOT NULL,
    order_in_quran INTEGER NOT NULL
);

CREATE INDEX idx_verse_surah ON quran_verses(surah_number);
CREATE INDEX idx_translation_verse_lang ON quran_translations(verse_id, language);
Reading Progress & Sessions
sqlCREATE TABLE user_reading_progress (
    user_id UUID PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    current_surah INTEGER,
    current_verse INTEGER,
    total_verses_read INTEGER DEFAULT 0,
    total_hasanat BIGINT DEFAULT 0,
    last_read_at TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reading_sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    total_duration_seconds INTEGER,
    verses_read INTEGER DEFAULT 0,
    hasanat_earned BIGINT DEFAULT 0,
    goal_achieved BOOLEAN DEFAULT FALSE,
    session_type VARCHAR(20),  -- 'scheduled' or 'spontaneous'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE verse_read_history (
    history_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    verse_id INTEGER REFERENCES quran_verses(verse_id),
    session_id UUID REFERENCES reading_sessions(session_id),
    read_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sessions_user_date ON reading_sessions(user_id, created_at DESC);
CREATE INDEX idx_verse_history_user ON verse_read_history(user_id);
User Goals & Stats
sqlCREATE TABLE user_goals (
    goal_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    goal_type VARCHAR(20) NOT NULL,  -- 'verse', 'time', 'page'
    goal_value INTEGER NOT NULL,
    preferred_times JSONB,  -- Array of time preferences
    start_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_stats (
    user_id UUID PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    total_verses_read INTEGER DEFAULT 0,
    total_hasanat BIGINT DEFAULT 0,
    current_streak INTEGER DEFAULT 0,
    longest_streak INTEGER DEFAULT 0,
    total_sessions INTEGER DEFAULT 0,
    total_reading_time_minutes INTEGER DEFAULT 0,
    surahs_completed JSONB,  -- Array of surah numbers
    juz_completed JSONB,  -- Array of juz numbers
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_goals_user_active ON user_goals(user_id, is_active);
Social Features
sqlCREATE TABLE friendships (
    friendship_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    friend_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'pending',  -- 'pending', 'accepted', 'declined', 'blocked'
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    responded_at TIMESTAMP,
    UNIQUE(user_id, friend_id),
    CHECK (user_id != friend_id)
);

CREATE TABLE conversations (
    conversation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    participant_1 UUID REFERENCES users(user_id) ON DELETE CASCADE,
    participant_2 UUID REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_message_at TIMESTAMP,
    UNIQUE(participant_1, participant_2)
);

CREATE TABLE messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID REFERENCES conversations(conversation_id) ON DELETE CASCADE,
    sender_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    message_type VARCHAR(20) DEFAULT 'text',
    content TEXT,
    metadata JSONB,  -- For verse references, achievements
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP,
    is_deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE posts (
    post_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    post_type VARCHAR(30),  -- 'text', 'verse_share', 'achievement', 'reflection'
    content TEXT,
    verse_reference JSONB,
    achievement_data JSONB,
    media_urls JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_hidden BOOLEAN DEFAULT FALSE,
    like_count INTEGER DEFAULT 0,
    comment_count INTEGER DEFAULT 0,
    share_count INTEGER DEFAULT 0
);

CREATE TABLE post_likes (
    like_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id UUID REFERENCES posts(post_id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(post_id, user_id)
);

CREATE TABLE post_comments (
    comment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id UUID REFERENCES posts(post_id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    parent_comment_id UUID REFERENCES post_comments(comment_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_friendships_user ON friendships(user_id, status);
CREATE INDEX idx_messages_conversation ON messages(conversation_id, sent_at DESC);
CREATE INDEX idx_posts_user_date ON posts(user_id, created_at DESC);
CREATE INDEX idx_posts_created ON posts(created_at DESC) WHERE is_hidden = FALSE;
Challenges
sqlCREATE TABLE challenges (
    challenge_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    creator_id UUID REFERENCES users(user_id) ON DELETE SET NULL,
    challenge_name VARCHAR(200) NOT NULL,
    challenge_type VARCHAR(30) NOT NULL,
    goal_value INTEGER NOT NULL,
    duration_days INTEGER NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    is_public BOOLEAN DEFAULT FALSE,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE challenge_participants (
    participant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    challenge_id UUID REFERENCES challenges(challenge_id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    invitation_status VARCHAR(20) DEFAULT 'invited',
    current_progress INTEGER DEFAULT 0,
    goal_achieved BOOLEAN DEFAULT FALSE,
    rank INTEGER,
    joined_at TIMESTAMP,
    UNIQUE(challenge_id, user_id)
);

CREATE INDEX idx_challenges_status_date ON challenges(status, end_date);
CREATE INDEX idx_participants_challenge ON challenge_participants(challenge_id, current_progress DESC);
Prayer Times & Duas
sqlCREATE TABLE prayer_time_settings (
    user_id UUID PRIMARY KEY REFERENCES users(user_id) ON DELETE CASCADE,
    calculation_method VARCHAR(20) DEFAULT 'ISNA',
    fajr_notification BOOLEAN DEFAULT TRUE,
    fajr_notification_minutes INTEGER DEFAULT 10,
    dhuhr_notification BOOLEAN DEFAULT TRUE,
    dhuhr_notification_minutes INTEGER DEFAULT 10,
    asr_notification BOOLEAN DEFAULT TRUE,
    asr_notification_minutes INTEGER DEFAULT 10,
    maghrib_notification BOOLEAN DEFAULT TRUE,
    maghrib_notification_minutes INTEGER DEFAULT 10,
    isha_notification BOOLEAN DEFAULT TRUE,
    isha_notification_minutes INTEGER DEFAULT 10,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE duas (
    dua_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category VARCHAR(50) NOT NULL,
    subcategory VARCHAR(50),
    arabic_text TEXT NOT NULL,
    transliteration TEXT,
    translation_en TEXT,
    translation_ar TEXT,
    translation_ur TEXT,
    translation_id TEXT,
    translation_tr TEXT,
    source_type VARCHAR(20),
    source_reference VARCHAR(200),
    context TEXT,
    benefits TEXT,
    audio_url VARCHAR(500),
    reciter VARCHAR(100),
    order_in_category INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_favorite_duas (
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    dua_id UUID REFERENCES duas(dua_id) ON DELETE CASCADE,
    favorited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, dua_id)
);

CREATE INDEX idx_duas_category ON duas(category, order_in_category);
9.2 Materialized Views for Performance
sql-- Leaderboard materialized view (refreshed every 5 minutes)
CREATE MATERIALIZED VIEW leaderboard_global AS
SELECT 
    u.user_id,
    u.username,
    up.display_name,
    up.profile_picture_url,
    us.total_hasanat,
    us.current_streak,
    us.total_verses_read,
    ROW_NUMBER() OVER (ORDER BY us.total_hasanat DESC) as rank
FROM users u
JOIN user_profiles up ON u.user_id = up.user_id
JOIN user_stats us ON u.user_id = us.user_id
WHERE up.show_on_leaderboard = TRUE
    AND u.is_active = TRUE
ORDER BY us.total_hasanat DESC
LIMIT 1000;

CREATE UNIQUE INDEX idx_leaderboard_global_user ON leaderboard_global(user_id);
CREATE INDEX idx_leaderboard_global_rank ON leaderboard_global(rank);

-- Refresh function (called by cron job)
CREATE OR REPLACE FUNCTION refresh_leaderboards()
RETURNS void AS $
BEGIN
    REFRESH MATERIALIZED VIEW CONCURRENTLY leaderboard_global;
END;
$ LANGUAGE plpgsql;

10. API Specifications
10.1 Authentication Endpoints
pythonPOST /api/v1/auth/register
Request:
{
  "email": "user@example.com",
  "username": "ahmad_123",
  "password": "SecurePass123!",
  "display_name": "Ahmad"
}
Response: 201 Created
{
  "user_id": "uuid",
  "email": "user@example.com",
  "username": "ahmad_123",
  "access_token": "jwt_token",
  "refresh_token": "refresh_jwt"
}

POST /api/v1/auth/login
Request:
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}
Response: 200 OK
{
  "access_token": "jwt_token",
  "refresh_token": "refresh_jwt",
  "user": {
    "user_id": "uuid",
    "username": "ahmad_123",
    "email": "user@example.com"
  }
}

POST /api/v1/auth/refresh
Request:
{
  "refresh_token": "refresh_jwt"
}
Response: 200 OK
{
  "access_token": "new_jwt_token"
}
10.2 Quran Endpoints
pythonGET /api/v1/quran/verse/{surah}/{verse}?translation=en&translator=sahih
Response: 200 OK
{
  "verse_id": 255,
  "surah": 2,
  "verse": 255,
  "arabic_text": "...",
  "translation": "...",
  "letter_count": 170,
  "has_sajdah": false
}

GET /api/v1/quran/surah/{surah_number}
Response: 200 OK
{
  "surah_number": 2,
  "name_arabic": "البقرة",
  "name_english": "The Cow",
  "verses": [...]
}

POST /api/v1/quran/verse/{verse_id}/read
Response: 200 OK
{
  "hasanat_earned": 1700,
  "total_hasanat": 45230
}
10.3 Rate Limiting
python# Apply rate limiting to prevent abuse
Rate Limits:
- Authentication: 5 requests/minute
- Reading endpoints: 100 requests/minute
- Social endpoints: 60 requests/minute
- Leaderboard: 20 requests/minute

Headers returned:
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1609459200

11. Security & Privacy
11.1 Authentication & Authorization

JWT-based authentication
Access tokens: 15-minute expiry
Refresh tokens: 7-day expiry, stored securely
Password requirements: Min 8 chars, uppercase, lowercase, number, special char
Bcrypt hashing with salt rounds = 12

11.2 Data Protection

All API calls over HTTPS/TLS 1.3
Encryption at rest for sensitive data
PII (email, location) encrypted in database
GDPR/CCPA compliance
User data export functionality
Right to be forgotten (account deletion)

11.3 Privacy Controls

Granular privacy settings (public, friends, private)
Opt-in for leaderboards
Opt-in for data collection beyond essential
Anonymous mode for competitive features
Block/report functionality

11.4 Content Moderation

ML-based automated moderation
Human moderator review queue
User reporting system
Three-strike policy for violations
Appeals process


12. Release Planning
12.1 MVP (Phase 1) - 3-4 Months
Target: Core reading experience + basic habit formation
Features:

✅ User authentication & onboarding
✅ Goal setting (verse-based)
✅ Verse-by-verse reading mode
✅ Hasanat calculation
✅ Basic app blocking (Android)
✅ Prayer times integration
✅ Session completion & encouragement
✅ Basic user stats (streak, total hasanat)
✅ Simple notifications

Success Criteria:

10,000 downloads
50% Day-7 retention
4.0+ app store rating
< 1% crash rate

12.2 Phase 2 - 4-5 Months
Target: Enhanced reading + community foundations
Features:

✅ Traditional Mushaf layout
✅ Dua library (100+ duas)
✅ User profiles
✅ Friend system
✅ Basic leaderboard (friends only)
✅ Bookmarks & notes
✅ Multiple translations
✅ Tajweed color-coding
✅ Audio recitations

Success Criteria:

50,000 users
40% Day-30 retention
10% friend connection rate

12.3 Phase 3 - 4-5 Months
Target: Full social & gamification
Features:

✅ In-app messaging
✅ Community feed
✅ Challenge system (user-created & auto)
✅ Global/regional leaderboards
✅ Advanced analytics
✅ ML-powered recommendations
✅ Group chats
✅ Badges & achievements

Success Criteria:

100,000 users
35% Day-60# Product Requirements Document (PRD)

Quran Habit Building Mobile Application
Version: 1.0
Last Updated: January 2, 2026
Document Owner: Product Team
Status: Approved