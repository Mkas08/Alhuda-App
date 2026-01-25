# CLAUDE.md - Quran Habit Builder Mobile Application

## Project Overview

This is a comprehensive Quran reading habit-building mobile application that combines behavioral psychology, gamification, and community support to help Muslims worldwide develop consistent Quran reading habits.

**Core Mission:** Empower Muslims to read the Quran daily through structure, accountability, encouragement, and community.

---

## Technology Stack

### Frontend
- **Framework:** Flutter 3.x
- **State Management:** Riverpod
- **Local Storage:** Hive
- **Networking:** Dio
- **WebSocket:** web_socket_channel
- **Architecture:** Clean Architecture (Data/Domain/Presentation layers)

### Backend
- **Framework:** FastAPI (Python 3.11+)
- **Database:** PostgreSQL 15+
- **ORM:** SQLAlchemy 2.0
- **Caching:** Redis 7+
- **Task Queue:** Celery
- **Authentication:** JWT
- **Real-time:** WebSockets

### Machine Learning
- **Framework:** PyTorch / TensorFlow
- **Libraries:** scikit-learn, transformers
- **Use Cases:** Content moderation, goal recommendations, challenge personalization

### Infrastructure
- **Storage:** AWS S3 / Google Cloud Storage
- **CDN:** CloudFront
- **Notifications:** Firebase Cloud Messaging
- **Deployment:** Docker containers

---

## Core Features Summary

### 1. **Onboarding & Goal Setting**
- User sets daily reading goals (verse-based, time-based, or page-based)
- Links goals to prayer times (after Fajr, Isha, etc.)
- Selects skill level (beginner/intermediate/advanced)
- Configures app blocking for focus mode

### 2. **Focus Mode & App Blocking**
- Blocks distracting apps during reading sessions (Android)
- Timer pauses when user exits app
- Automatic unblocking when session ends
- iOS: Focus mode reminders (limited blocking capability)

### 3. **Quran Reading Interface**
**Verse-by-Verse Mode (Primary):**
- One ayah per screen with translation
- Automatic hasanat calculation (letter count × 10)
- Progress indicator
- Next/Previous navigation
- Font size adjustment, night mode

**Traditional Mushaf Mode:**
- Standard Medina pagination (604 pages)
- Page-based navigation
- Manual completion tracking

### 4. **Sajdah Reminders**
- Modal notification at 14 sajdah verses
- "Performed" or "Skip" options
- Optional tracking in user stats

### 5. **Completion & Encouragement**
- "I'm Done" button triggers celebration screen
- Shows: verses read, hasanat earned, current streak
- Motivational Quranic verses/hadiths
- Milestone celebrations

### 6. **Social Features**
- Friend system with requests
- One-to-one messaging
- Community feed (Twitter-style)
- Share verses, achievements, reflections
- Like, comment, share posts

### 7. **Leaderboards**
- Three categories: Friends, Regional, Global
- Based on total hasanat earned
- Time filters: Today, Week, Month, All-Time
- Opt-in/opt-out with privacy controls

### 8. **Challenge System**
**User-Created:**
- Custom goals and duration
- Invite friends
- Real-time progress tracking

**Auto-Generated:**
- Friday Surah Al-Kahf challenge
- Ramadan challenges
- Monday/Thursday challenges
- ML-personalized recommendations

### 9. **Dua Library**
- Categorized supplications
- Arabic, transliteration, translation
- Audio recitations
- Source references
- Contextual recommendations

### 10. **Prayer Times**
- Location-based calculation
- Multiple methods (ISNA, MWL, etc.)
- Notifications for each prayer
- Qibla direction compass

---

## Critical Design Principles

### 1. **Respect for Islamic Content**
- Uthmanic script for Arabic text
- Verified translations only
- Scholarly authentication for duas
- Reverent UI design
- No ads during Quran reading

### 2. **Simplicity & Focus**
- Clean, distraction-free reading
- Minimal formatting (avoid over-using lists/bullets)
- Fast, responsive interactions
- Intuitive navigation

### 3. **Behavioral Psychology**
- Immediate positive feedback (hasanat calculation)
- Streak tracking for consistency
- Social accountability through friends
- Achievable goals to prevent abandonment

### 4. **Privacy & Security**
- Granular privacy controls
- Opt-in for competitive features
- GDPR/CCPA compliance
- JWT authentication
- HTTPS everywhere

### 5. **Accessibility**
- RTL language support
- Multiple font sizes
- High contrast modes
- Screen reader compatibility

---

## Database Schema Essentials

### Core Tables
```sql
users (user_id, email, username, password_hash, is_active)
user_profiles (user_id, display_name, profile_picture_url, bio, privacy_level)
user_locations (user_id, latitude, longitude, city, country)
user_goals (goal_id, user_id, goal_type, goal_value, preferred_times)
user_stats (user_id, total_verses_read, total_hasanat, current_streak)

quran_verses (verse_id, surah_number, verse_number, arabic_text, letter_count, has_sajdah)
quran_translations (translation_id, verse_id, language, translation_text)

reading_sessions (session_id, user_id, start_time, end_time, verses_read, hasanat_earned)
verse_read_history (history_id, user_id, verse_id, session_id, read_at)

friendships (friendship_id, user_id, friend_id, status)
messages (message_id, conversation_id, sender_id, content, sent_at)
posts (post_id, user_id, post_type, content, like_count, comment_count)

challenges (challenge_id, creator_id, challenge_name, challenge_type, goal_value)
challenge_participants (participant_id, challenge_id, user_id, current_progress)

duas (dua_id, category, arabic_text, transliteration, translation_en)
prayer_time_settings (user_id, calculation_method, fajr_notification)
```

### Key Relationships
- User has one Profile, Location, Stats
- User has many Goals, Sessions, Friendships
- Session has many VerseReadHistory entries
- Challenge has many Participants
- Post has many Likes, Comments

---

## API Patterns

### Authentication
```python
POST /api/v1/auth/register
POST /api/v1/auth/login
POST /api/v1/auth/refresh
```

### Quran
```python
GET /api/v1/quran/verse/{surah}/{verse}?translation=en
GET /api/v1/quran/surah/{surah_number}
POST /api/v1/quran/verse/{verse_id}/read
```

### Sessions
```python
POST /api/v1/sessions/start
PATCH /api/v1/sessions/{session_id}/pause
PATCH /api/v1/sessions/{session_id}/end
```

### Social
```python
POST /api/v1/friends/request
POST /api/v1/friends/{friendship_id}/accept
GET /api/v1/feed?type=following&limit=20
POST /api/v1/posts
POST /api/v1/posts/{post_id}/like
```

### Challenges
```python
POST /api/v1/challenges
GET /api/v1/challenges/recommended
POST /api/v1/challenges/{challenge_id}/accept
GET /api/v1/challenges/{challenge_id}/leaderboard
```

---

## Machine Learning Components

### 1. **Goal Recommendation Engine**
- **Input:** User's reading history, completion rates, streaks
- **Output:** Optimal daily verse goal
- **Model:** XGBoost regression
- **Features:** avg_daily_verses, completion_rate, current_streak, user_age

### 2. **Content Moderation**
- **Input:** User post text
- **Output:** Safe/Harmful/NeedsReview
- **Model:** Fine-tuned BERT (toxic-bert)
- **Features:** Text embeddings + Islamic content rules

### 3. **Challenge Recommender**
- **Input:** User reading profile, Islamic calendar context
- **Output:** Top 3-5 personalized challenges
- **Model:** Collaborative filtering + content-based
- **Features:** User embeddings, challenge embeddings, completion history

### 4. **Smart Notification Timing**
- **Input:** User's app usage patterns, prayer times
- **Output:** Optimal notification times
- **Model:** Time series classification
- **Features:** Historical open times, day of week, prayer schedule

### 5. **Churn Prediction**
- **Input:** User engagement metrics
- **Output:** Churn probability
- **Model:** Random Forest classifier
- **Features:** Days since last session, streak breaks, goal completion trend

---

## Critical Implementation Notes

### Hasanat Calculation
```python
def calculate_hasanat(verse_id: int) -> int:
    """
    Each Arabic letter = 10 hasanat
    Example: Bismillah (19 letters) = 190 hasanat
    """
    verse = get_verse(verse_id)
    return verse.letter_count * 10
```

### Streak Calculation
```python
def calculate_streak(user_id: UUID) -> int:
    """
    Count consecutive days with at least one reading session.
    Check for sessions on current day, previous day, etc.
    Break streak if gap > 1 day.
    """
    sessions = get_user_sessions(user_id, order_by="desc")
    streak = 0
    current_date = date.today()
    
    for session in sessions:
        session_date = session.created_at.date()
        if session_date == current_date - timedelta(days=streak):
            streak += 1
        else:
            break
    
    return streak
```

### App Blocking (Android Only)
```dart
// Flutter - Use MethodChannel for native Android code
class AppBlockingService {
  static const platform = MethodChannel('com.quranapp/app_blocking');
  
  Future<void> blockApps(List<String> packageNames) async {
    await platform.invokeMethod('blockApps', {'packages': packageNames});
  }
}

// Android native: Use AccessibilityService or UsageStatsManager
```

### Prayer Time Calculation
```python
from praytimes import PrayTimes

def calculate_prayer_times(lat, lon, date, method='ISNA'):
    pt = PrayTimes(method)
    times = pt.getTimes(date, (lat, lon), timezone)
    return times  # {fajr, sunrise, dhuhr, asr, maghrib, isha}
```

### Qibla Direction
```python
def calculate_qibla_direction(user_lat, user_lon):
    """
    Calculate bearing to Kaaba (21.4225°N, 39.8262°E)
    Returns: Bearing in degrees (0-360)
    """
    kaaba_lat, kaaba_lon = 21.4225, 39.8262
    # Use Haversine formula for bearing calculation
    return bearing_degrees
```

---

## Flutter Project Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   └── colors.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── text_styles.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── hasanat_calculator.dart
│   │   └── validators.dart
│   └── network/
│       ├── api_client.dart
│       └── websocket_client.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── screens/
│   │       ├── widgets/
│   │       └── providers/
│   ├── quran/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── reading_screen.dart
│   │       │   ├── mushaf_screen.dart
│   │       │   └── completion_screen.dart
│   │       └── widgets/
│   │           ├── verse_card.dart
│   │           └── progress_indicator.dart
│   ├── goals/
│   ├── focus_mode/
│   ├── social/
│   ├── challenges/
│   ├── prayers/
│   └── duas/
├── shared/
│   ├── widgets/
│   │   ├── loading_indicator.dart
│   │   ├── error_widget.dart
│   │   └── custom_button.dart
│   ├── models/
│   └── services/
│       ├── local_storage_service.dart
│       ├── notification_service.dart
│       └── location_service.dart
└── config/
    ├── routes/
    └── dependencies/
```

---

## Backend Project Structure

```
backend/
├── app/
│   ├── main.py                    # FastAPI app initialization
│   ├── config.py                  # Configuration settings
│   ├── database.py                # Database connection
│   ├── models/
│   │   ├── user.py
│   │   ├── quran.py
│   │   ├── social.py
│   │   └── challenge.py
│   ├── schemas/
│   │   └── (Pydantic models for request/response)
│   ├── api/
│   │   └── v1/
│   │       ├── auth.py
│   │       ├── quran.py
│   │       ├── users.py
│   │       ├── sessions.py
│   │       ├── social.py
│   │       ├── challenges.py
│   │       ├── prayers.py
│   │       └── duas.py
│   ├── services/
│   │   ├── auth_service.py
│   │   ├── quran_service.py
│   │   ├── hasanat_service.py
│   │   ├── streak_service.py
│   │   ├── ml_service.py
│   │   └── notification_service.py
│   ├── ml/
│   │   ├── models/
│   │   │   ├── goal_recommender.py
│   │   │   ├── content_moderator.py
│   │   │   └── challenge_recommender.py
│   │   ├── training/
│   │   └── inference.py
│   ├── utils/
│   │   ├── security.py
│   │   ├── prayer_times.py
│   │   └── islamic_calendar.py
│   └── tests/
├── alembic/                       # Database migrations
├── requirements.txt
└── docker-compose.yml
```

---

## Development Workflow

### Phase 1: MVP (Current Focus)
**Priority Features:**
1. User authentication & onboarding
2. Goal setting
3. Verse-by-verse reading mode
4. Hasanat calculation
5. Basic app blocking (Android)
6. Prayer times
7. Session tracking & encouragement
8. Basic notifications

**Don't Build Yet:**
- Social features
- Community feed
- Challenges
- Leaderboards
- ML recommendations

### Testing Strategy
- **Unit Tests:** Core business logic (hasanat calculation, streak tracking)
- **Integration Tests:** API endpoints, database operations
- **Widget Tests:** Flutter UI components
- **E2E Tests:** Critical user flows (onboarding → reading → completion)

### Code Review Checklist
- [ ] Islamic content handled with respect
- [ ] Arabic text uses proper Uthmanic script
- [ ] Privacy settings respected in all queries
- [ ] Rate limiting applied to endpoints
- [ ] Errors logged appropriately
- [ ] User feedback is encouraging, never negative
- [ ] Database queries optimized (use indexes)
- [ ] Caching implemented for expensive operations

---

## Common Development Patterns

### 1. **Adding a New API Endpoint**
```python
# 1. Define Pydantic schema in schemas/
class CreateGoalRequest(BaseModel):
    goal_type: str
    goal_value: int
    preferred_times: List[str]

# 2. Add route in api/v1/
@router.post("/goals")
async def create_goal(
    request: CreateGoalRequest,
    current_user: User = Depends(get_current_user)
):
    goal = goal_service.create_goal(current_user.id, request)
    return {"goal_id": goal.goal_id}

# 3. Implement service logic
def create_goal(user_id, request):
    goal = Goal(**request.dict(), user_id=user_id)
    db.add(goal)
    db.commit()
    return goal

# 4. Add Flutter service method
Future<String> createGoal(CreateGoalRequest request) async {
  final response = await dio.post('/api/v1/goals', data: request.toJson());
  return response.data['goal_id'];
}
```

### 2. **Implementing a New Screen in Flutter**
```dart
// 1. Create screen in features/{feature}/presentation/screens/
class ReadingScreen extends ConsumerStatefulWidget {
  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends ConsumerState<ReadingScreen> {
  @override
  Widget build(BuildContext context) {
    final verse = ref.watch(currentVerseProvider);
    
    return Scaffold(
      body: verse.when(
        data: (v) => VerseCard(verse: v),
        loading: () => LoadingIndicator(),
        error: (e, st) => ErrorWidget(error: e),
      ),
    );
  }
}

// 2. Define provider
final currentVerseProvider = FutureProvider<Verse>((ref) async {
  return ref.read(quranRepositoryProvider).getCurrentVerse();
});

// 3. Add route
GoRoute(
  path: '/reading',
  builder: (context, state) => ReadingScreen(),
)
```

### 3. **Database Migration**
```python
# 1. Create migration
alembic revision -m "add_sajdah_tracking_table"

# 2. Write upgrade/downgrade
def upgrade():
    op.create_table(
        'sajdah_tracking',
        sa.Column('user_id', sa.UUID(), nullable=False),
        sa.Column('verse_id', sa.Integer(), nullable=False),
        sa.Column('performed', sa.Boolean(), nullable=False),
        sa.ForeignKeyConstraint(['user_id'], ['users.user_id']),
    )

# 3. Apply migration
alembic upgrade head
```

---

## Performance Optimization Guidelines

### Database
- Use indexes on frequently queried columns (user_id, created_at)
- Implement connection pooling (PgBouncer)
- Use materialized views for leaderboards (refresh every 5 min)
- Cache expensive queries in Redis (TTL: 5-60 minutes)
- Paginate results (limit + offset)

### API
- Implement rate limiting (Redis-based)
- Use async/await for I/O operations
- Compress responses (gzip)
- Implement CDN for static assets
- Use WebSocket for real-time features

### Mobile
- Cache Quran data locally (Hive)
- Lazy load images
- Implement pagination for long lists
- Optimize image sizes
- Minimize API calls (batch when possible)

---

## Security Checklist

### Authentication
- [ ] Passwords hashed with bcrypt (cost factor 12)
- [ ] JWT tokens expire (access: 15 min, refresh: 7 days)
- [ ] Refresh tokens rotated on use
- [ ] Account lockout after failed login attempts
- [ ] Email verification required

### API Security
- [ ] All endpoints over HTTPS
- [ ] Rate limiting on all endpoints
- [ ] Input validation using Pydantic
- [ ] SQL injection prevented (ORM parameterized queries)
- [ ] CORS configured properly
- [ ] Authentication required except public endpoints

### Data Privacy
- [ ] PII encrypted at rest
- [ ] Privacy settings checked in all queries
- [ ] User can export their data
- [ ] User can delete their account
- [ ] Audit logging for sensitive operations

---

## Error Handling

### Backend
```python
# Use custom exceptions
class QuranAppException(Exception):
    def __init__(self, message: str, status_code: int):
        self.message = message
        self.status_code = status_code

# Exception handler
@app.exception_handler(QuranAppException)
async def handle_app_exception(request, exc):
    return JSONResponse(
        status_code=exc.status_code,
        content={"error": exc.message}
    )
```

### Frontend
```dart
// Use Either pattern or Result type
Future<Either<Failure, Verse>> getVerse(int surah, int verse) async {
  try {
    final response = await api.getVerse(surah, verse);
    return Right(Verse.fromJson(response));
  } on DioError catch (e) {
    return Left(ServerFailure(e.message));
  }
}

// Display user-friendly errors
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('Unable to load verse. Please try again.')),
);
```

---

## Monitoring & Analytics

### Key Metrics to Track
- User registration & retention (D1, D7, D30)
- Daily active users (DAU)
- Reading sessions per user
- Average verses read per session
- Goal completion rate
- Streak maintenance rate
- Feature adoption (challenges, social, etc.)
- API response times
- Error rates
- Crash-free users percentage

### Tools
- **Analytics:** Firebase Analytics / Mixpanel
- **Crash Reporting:** Sentry
- **API Monitoring:** Prometheus + Grafana
- **Logging:** ELK Stack (Elasticsearch, Logstash, Kibana)

---

## Deployment

### Backend
```bash
# Docker containerization
docker build -t quran-app-api .
docker push registry/quran-app-api:latest

# Deploy with docker-compose or Kubernetes
kubectl apply -f k8s/deployment.yaml
```

### Mobile
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
# Then use Xcode for App Store submission
```

### Database Migrations
```bash
# Always backup before migration
pg_dump quran_db > backup.sql

# Run migrations
alembic upgrade head

# Verify
psql quran_db -c "SELECT version_num FROM alembic_version;"
```

---

## Troubleshooting Common Issues

### Issue: App blocking not working on Android
- Check if accessibility permissions granted
- Verify package names are correct
- Test on different Android versions (varies by API level)

### Issue: Prayer times inaccurate
- Verify user location is correct
- Check calculation method setting
- Ensure timezone is properly detected

### Issue: Hasanat calculation mismatch
- Verify letter_count in quran_verses table
- Check for Arabic diacritics being counted
- Ensure formula: hasanat = letter_count × 10

### Issue: Streak not updating
- Check timezone handling (user's local vs server)
- Verify session creation timestamps
- Review streak calculation logic in calculate_streak()

### Issue: WebSocket connection drops
- Implement reconnection logic with exponential backoff
- Check firewall/proxy settings
- Verify WebSocket endpoint is accessible

---

## Additional Resources

### Islamic Resources
- Quran.com API: https://api.quran.com/
- Prayer Times Calculation: https://praytimes.org/
- Hadith Collections: https://sunnah.com/

### Technical Documentation
- Flutter: https://docs.flutter.dev/
- FastAPI: https://fastapi.tiangolo.com/
- PostgreSQL: https://www.postgresql.org/docs/
- Redis: https://redis.io/documentation

### Design Inspiration
- Islamic Design Patterns
- Material Design 3
- iOS Human Interface Guidelines

---

## Contact & Support

For questions during development:
1. Check this GEMINI.md file first
2. Review the full PRD document
3. Consult API documentation
4. Check existing codebase for similar implementations

When implementing new features:
1. Follow the clean architecture pattern
2. Write tests for critical logic
3. Document complex algorithms
4. Respect Islamic content guidelines
5. Prioritize user privacy and security

---

**Remember:** This app serves a sacred purpose—helping Muslims connect with the Quran. Every line of code should reflect that responsibility with quality, respect, and care.