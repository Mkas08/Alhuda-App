# Al-Huda Technical Stack

**Platform:** Mobile (iOS & Android)  
**Framework:** Flutter 3.x

---

## Frontend Stack (Flutter)

### Core
| Package | Version | Purpose |
|---------|---------|---------|
| flutter | ^3.16.0 | Core framework |
| dart | ^3.2.0 | Language runtime |

### State Management
| Package | Purpose |
|---------|---------|
| flutter_riverpod | Global & local state management |
| riverpod_annotation | Code generation for providers |

### Local Storage
| Package | Purpose |
|---------|---------|
| hive | Fast NoSQL local database |
| hive_flutter | Flutter integration for Hive |
| flutter_secure_storage | Secure token storage (Keychain/Keystore) |

### Networking
| Package | Purpose |
|---------|---------|
| dio | HTTP client with interceptors |
| web_socket_channel | Real-time WebSocket |

### Navigation
| Package | Purpose |
|---------|---------|
| go_router | Declarative routing |

### UI & Animation
| Package | Purpose |
|---------|---------|
| google_fonts | Custom typography (Lexend, Manrope) |
| shimmer | Loading skeleton effects |
| cached_network_image | Optimized image loading |
| flutter_svg | SVG support |
| lottie | JSON-based animations |

### Firebase
| Package | Purpose |
|---------|---------|
| firebase_core | Firebase initialization |
| firebase_messaging | Push notifications (FCM) |
| firebase_analytics | Usage analytics |

### Utilities
| Package | Purpose |
|---------|---------|
| intl | Date/time formatting, i18n |
| timeago | Relative time display |
| uuid | ID generation |
| geolocator | Location services |
| just_audio | Audio playback (recitations) |

### Error Tracking
| Package | Purpose |
|---------|---------|
| sentry_flutter | Crash reporting & monitoring |

---

## Backend Stack

### Framework
- **FastAPI** (Python 3.11+) - Modern async web framework
- **SQLAlchemy 2.0** (Async ORM) - Database operations
- **Pydantic v2** - Request/response validation
- **Alembic** - Database migrations

### Database
- **PostgreSQL 15+** - Primary database
- **Redis 7+** - Caching, sessions, leaderboards

### Authentication
- **JWT tokens** via python-jose
- **passlib[bcrypt]** - Password hashing
- Access token: 15 min expiry
- Refresh token: 7 days expiry

### Task Queue
- **Celery** - Background jobs (notifications, analytics)
- **Redis** - Celery broker

### ML/AI (Future)
- **PyTorch / TensorFlow** - Recommendations
- **scikit-learn** - Goal prediction
- **transformers** - Content moderation

---

## Native Modules (Android)

### App Blocking Module
The app blocking feature requires a custom Kotlin native module:

```kotlin
// android/app/src/main/kotlin/com/alhuda/appblocking/
AppBlockingModule.kt      // Flutter MethodChannel bridge
AppBlockingService.kt     // AccessibilityService implementation
```

This module uses Android's AccessibilityService to:
- Monitor app launches
- Block specified package names
- Return user to Quran app

**iOS Note:** App blocking not available on iOS. Use Focus Mode reminders instead.

---

## Development Tools

### IDE & Extensions
- **VS Code** with:
  - Flutter
  - Dart
  - Error Lens
  - GitLens
- **Android Studio** (for Android-specific debugging)
- **Xcode** (macOS only, for iOS builds)

### Debugging
- Flutter DevTools (performance, widgets, network)
- Dart DevTools
- VS Code Flutter Debugger

### Testing
| Tool | Purpose |
|------|---------|
| flutter_test | Unit & widget tests |
| integration_test | Integration tests |
| mockito | Mocking dependencies |
| bloc_test | Testing providers (if using BLoC) |

---

## Project Structure (Clean Architecture)

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
│   │   ├── text_styles.dart
│   │   └── theme_extensions.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── hasanat_calculator.dart
│   │   └── validators.dart
│   └── network/
│       ├── api_client.dart
│       ├── api_interceptors.dart
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
│   ├── onboarding/
│   ├── quran/
│   ├── goals/
│   ├── focus_mode/
│   ├── prayers/
│   └── social/ (post-MVP)
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

## Build Commands

### Development
```bash
# Install dependencies
flutter pub get

# Generate code (Riverpod, Hive adapters, etc.)
dart run build_runner build --delete-conflicting-outputs

# iOS (requires macOS)
cd ios && pod install && cd ..
flutter run -d ios

# Android
flutter run -d android
```

### Production
```bash
# Android (App Bundle)
flutter build appbundle --release

# Android (APK)
flutter build apk --release

# iOS (requires macOS + Xcode)
flutter build ios --release
```

### Testing
```bash
# Unit & widget tests
flutter test

# Integration tests
flutter test integration_test/

# With coverage
flutter test --coverage
```

---

## Performance Guidelines

1. **Use Hive** instead of SharedPreferences for faster reads
2. **Use const constructors** for static widgets
3. **Memoize expensive computations** with Riverpod's select()
4. **Lazy load** feature screens with go_router
5. **Cache Quran data** locally after first fetch
6. **Optimize images** with cached_network_image
7. **Use RepaintBoundary** for complex custom painters

---

## Key Implementation Notes

### Hasanat Calculation
```dart
int calculateHasanat(String arabicText) {
  // Each Arabic letter = 10 hasanat
  final letterCount = arabicText.replaceAll(RegExp(r'\s'), '').length;
  return letterCount * 10;
}
```

### Streak Calculation
- Consecutive days with at least one reading session
- Timezone-aware (use user's local timezone)
- Grace period: Optional 1-day buffer (configurable)

### Theme Extension (Emerald Night)
```dart
extension EmeraldNightTheme on ThemeData {
  Color get emeraldPrimary => const Color(0xFF13ec5b);
  Color get emeraldGlow => const Color(0xFF13ec5b).withOpacity(0.3);
  Color get deepForest => const Color(0xFF102216);
  Color get gold => const Color(0xFFd4af37);
}
```

---

## Memory & Performance Targets

- App launch: < 2 seconds
- API response: < 200ms (p95)
- Verse navigation: < 100ms
- Crash rate: < 1%
- 60 FPS on mid-range devices
