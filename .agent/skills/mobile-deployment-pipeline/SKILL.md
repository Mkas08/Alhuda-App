---
name: deploying-mobile-apps
description: Automate build and deployment for Flutter apps. Use when setting up CI/CD pipelines, configuring Fastlane, or preparing release builds for iOS and Android.
---

# Flutter Deployment Pipeline

## When to use this skill
- When setting up CI/CD (GitHub Actions, Codemagic, etc.).
- When configuring Fastlane.
- When preparing production or beta releases.
- When troubleshooting build failures in CI.

## Environment Setup

Define distinct environments with separate configuration:

| Environment | Build Mode | API | Distribution |
|-------------|-----------|-----|--------------|
| **Development** | Debug | localhost/dev API | Local device |
| **Staging** | Profile/Release | staging API | TestFlight/Firebase |
| **Production** | Release | prod API | App Store/Play Store |

### Environment Configuration
```dart
// lib/config/environment.dart
enum Environment { dev, staging, production }

class AppConfig {
  static late Environment environment;
  
  static String get apiBaseUrl {
    switch (environment) {
      case Environment.dev:
        return 'http://localhost:8000/api/v1';
      case Environment.staging:
        return 'https://staging-api.alhuda.app/api/v1';
      case Environment.production:
        return 'https://api.alhuda.app/api/v1';
    }
  }
}
```

### Build with --dart-define
```bash
# Development
flutter run --dart-define=ENVIRONMENT=dev

# Staging
flutter run --release --dart-define=ENVIRONMENT=staging

# Production
flutter build appbundle --dart-define=ENVIRONMENT=production
```

## Build Process

### CI Pipeline Steps

```yaml
# .github/workflows/build.yml
name: Build & Test

on:
  push:
    branches: [main, develop]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
          
      - name: Install dependencies
        run: flutter pub get
        
      - name: Generate code
        run: dart run build_runner build --delete-conflicting-outputs
        
      - name: Analyze
        run: flutter analyze --fatal-infos
        
      - name: Run tests
        run: flutter test --coverage
        
      - name: Build Android
        run: flutter build apk --release
```

### Pre-Build Checks
```bash
# 1. Lint
flutter analyze --fatal-infos

# 2. Format check
dart format --set-exit-if-changed .

# 3. Tests
flutter test

# 4. Generate code (Riverpod, json_serializable, etc.)
dart run build_runner build --delete-conflicting-outputs
```

## iOS Deployment

### Fastlane Setup
```ruby
# ios/fastlane/Fastfile
default_platform(:ios)

platform :ios do
  desc "Push to TestFlight"
  lane :beta do
    setup_ci if ENV['CI']
    
    match(type: "appstore", readonly: true)
    
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    
    upload_to_testflight(
      skip_waiting_for_build_processing: true
    )
  end
  
  desc "Push to App Store"
  lane :release do
    setup_ci if ENV['CI']
    
    match(type: "appstore", readonly: true)
    
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner"
    )
    
    upload_to_app_store(
      submit_for_review: false,
      force: true
    )
  end
end
```

### Code Signing with Match
```bash
# Initialize match
fastlane match init

# Generate certificates (run once)
fastlane match appstore
fastlane match development
```

### Build Commands
```bash
# iOS Release build
flutter build ios --release

# Archive for App Store
flutter build ipa --release --export-options-plist=ExportOptions.plist
```

## Android Deployment

### Signing Configuration
```gradle
// android/app/build.gradle
android {
    signingConfigs {
        release {
            keyAlias System.getenv("KEY_ALIAS")
            keyPassword System.getenv("KEY_PASSWORD")
            storeFile file(System.getenv("KEYSTORE_PATH"))
            storePassword System.getenv("STORE_PASSWORD")
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

### Fastlane Setup
```ruby
# android/fastlane/Fastfile
default_platform(:android)

platform :android do
  desc "Deploy to internal track"
  lane :internal do
    gradle(
      task: "bundle",
      build_type: "Release"
    )
    
    upload_to_play_store(
      track: "internal",
      aab: "../build/app/outputs/bundle/release/app-release.aab"
    )
  end
  
  desc "Promote to production"
  lane :release do
    upload_to_play_store(
      track: "internal",
      track_promote_to: "production"
    )
  end
end
```

### Build Commands
```bash
# Android App Bundle (for Play Store)
flutter build appbundle --release

# APK (for direct distribution)
flutter build apk --release --split-per-abi
```

## Version Management

### Semantic Versioning
```yaml
# pubspec.yaml
version: 1.2.3+45
# 1.2.3 = version name (shown to users)
# 45 = build number (incremented each build)
```

### Auto-increment in CI
```bash
# Read current version
version=$(grep 'version:' pubspec.yaml | sed 's/version: //')
build=$(echo $version | cut -d'+' -f2)
new_build=$((build + 1))

# Update pubspec.yaml
sed -i "s/+$build/+$new_build/" pubspec.yaml
```

## Pre-Deployment Checklist

Before triggering a production release:

```
[ ] All tests passing?
[ ] flutter analyze clean (no errors/warnings)?
[ ] Performance acceptable on low-end device?
[ ] Accessibility basics checked?
[ ] Privacy policy URL updated?
[ ] App Store assets ready (screenshots, description)?
[ ] Release notes written?
[ ] API version compatible with backend?
[ ] Firebase/analytics configured for production?
[ ] Error tracking (Sentry) configured?
[ ] Secrets/keys are for production environment?
```

## Source Maps & Crash Reporting

### Sentry Setup
```dart
// main.dart
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://xxx@sentry.io/xxx';
      options.environment = AppConfig.environment.name;
      options.release = 'al-huda@${packageInfo.version}';
    },
    appRunner: () => runApp(const MyApp()),
  );
}
```

### Upload Debug Symbols
```bash
# Android
sentry-cli upload-dif --org alhuda --project mobile \
  build/app/intermediates/merged_native_libs/release/out/lib/

# iOS
sentry-cli upload-dif --org alhuda --project mobile \
  build/ios/archive/Runner.xcarchive/dSYMs/
```

## Rollback Plan

If critical issues found post-release:

1. **Immediate:** Halt rollout in Play Console / App Store Connect
2. **Hotfix:** Create hotfix branch, fix issue, run full test suite
3. **Deploy:** Use expedited review (iOS) or staged rollout (Android)
4. **Communicate:** Update users via in-app message if needed
