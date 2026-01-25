---
name: ensuring-mobile-security
description: Ensure app security for Flutter apps. Use when handling sensitive data, configuring networking, or preparing for production.
---

# Flutter Security Standards

## When to use this skill
- When handling user credentials or sensitive personal data (PII).
- When configuring API calls and networking.
- When implementing authentication logic.
- When preparing the app for a production release.

## Data Storage

### Secure Storage
**NEVER** store tokens, passwords, or API keys in:
- SharedPreferences
- Hive (unencrypted)
- Local files

**ALWAYS** use `flutter_secure_storage`:
```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  
  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }
  
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
```

### Encrypted Local Database
For sensitive user data in Hive:
```dart
await Hive.initFlutter();

// Use encrypted box for sensitive data
final encryptionKey = await SecureStorageService.getOrCreateKey();
final encryptedBox = await Hive.openBox(
  'secure_data',
  encryptionCipher: HiveAesCipher(encryptionKey),
);
```

### Logout Cleanup
Clear ALL sensitive data on logout:
```dart
Future<void> logout() async {
  // Clear secure storage
  await SecureStorageService.clearAll();
  
  // Clear Hive boxes with sensitive data
  await Hive.box('user_data').clear();
  
  // Clear in-memory state
  ref.invalidate(userProvider);
  ref.invalidate(sessionsProvider);
  
  // Navigate to login
  context.go('/login');
}
```

## Network Security

### HTTPS Only
Configure Android (`android/app/src/main/AndroidManifest.xml`):
```xml
<application
    android:usesCleartextTraffic="false"
    ...>
```

Configure iOS (`ios/Runner/Info.plist`):
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <false/>
</dict>
```

### Certificate Pinning
For critical APIs, implement SSL pinning:
```dart
// Using dio with certificate pinning
dio.httpClientAdapter = IOHttpClientAdapter(
  createHttpClient: () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) {
      // Verify certificate fingerprint
      return cert.sha256.toString() == EXPECTED_FINGERPRINT;
    };
    return client;
  },
);
```

### Sensitive Data Logging
**NEVER** log in production:
- Authentication tokens
- Passwords
- Personal information
- Request/response bodies with PII

```dart
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, handler) {
    if (kDebugMode) {
      // Only log in debug mode
      debugPrint('REQUEST: ${options.method} ${options.path}');
      // Never log Authorization header
    }
    handler.next(options);
  }
}
```

## Authentication

### Password Handling
```dart
// ✅ Good: Send to server, never store locally
Future<void> login(String email, String password) async {
  final response = await dio.post('/auth/login', data: {
    'email': email,
    'password': password,
  });
  // Store tokens, NOT password
  await SecureStorageService.saveTokens(response.data);
}

// ❌ Bad: Storing password locally
await prefs.setString('password', password);
```

### Biometric Authentication
```dart
import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();
  
  Future<bool> authenticate() async {
    final canAuth = await _auth.canCheckBiometrics;
    if (!canAuth) return false;
    
    return await _auth.authenticate(
      localizedReason: 'Authenticate to access your Quran reading',
      options: const AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );
  }
}
```

### Session Timeout
For sensitive apps, implement session timeout:
```dart
class SessionManager {
  static const _timeout = Duration(minutes: 15);
  Timer? _timer;
  
  void resetTimer() {
    _timer?.cancel();
    _timer = Timer(_timeout, _onTimeout);
  }
  
  void _onTimeout() {
    // Require re-authentication
    authNotifier.requireReauth();
  }
}
```

## Code Security

### Production Builds

**Android (`android/app/build.gradle`):**
```gradle
buildTypes {
    release {
        minifyEnabled true
        shrinkResources true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

**Remove debug output:**
```dart
// Use kDebugMode guard
if (kDebugMode) {
  print('Debug info');
}

// Or configure logger
Logger.level = kDebugMode ? Level.debug : Level.warning;
```

### Input Validation
Validate ALL user inputs:
```dart
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }
  
  static String? password(String? value) {
    if (value == null || value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain uppercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    return null;
  }
}
```

### App Preview Protection
Hide sensitive content from task switcher:
```dart
// Android: In MainActivity.kt
override fun onPause() {
    super.onPause()
    window.setFlags(
        WindowManager.LayoutParams.FLAG_SECURE,
        WindowManager.LayoutParams.FLAG_SECURE
    )
}

// iOS: In AppDelegate.swift
func applicationWillResignActive(_ application: UIApplication) {
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    blurView.frame = window?.bounds ?? .zero
    blurView.tag = 999
    window?.addSubview(blurView)
}
```

## Rate Limiting
Handle 429 responses gracefully:
```dart
void onError(DioException err, handler) {
  if (err.response?.statusCode == 429) {
    final retryAfter = err.response?.headers.value('Retry-After');
    throw RateLimitException(
      'Too many requests. Try again in $retryAfter seconds.',
    );
  }
  handler.next(err);
}
```
