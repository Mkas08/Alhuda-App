---
name: standardizing-api-integration
description: Standardize API communication, error handling, and authentication for Flutter apps. Use when building new API services or debugging network issues.
---

# Flutter API Integration Standards

## When to use this skill
- When creating new API services or endpoints.
- When setting up authentication flows.
- When debugging network errors or timeout issues.
- When configuring the Dio HTTP client.

## API Client Setup

### Dio Configuration
```dart
class ApiClient {
  late final Dio dio;
  
  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ));
    
    dio.interceptors.addAll([
      AuthInterceptor(),
      LoggingInterceptor(),
      ErrorInterceptor(),
    ]);
  }
}
```

### Auth Interceptor
```dart
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Attempt token refresh
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Retry original request
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      }
    }
    handler.next(err);
  }
}
```

## Request Handling

### Service Layer Pattern
Centralize all API calls in feature-specific services:
```dart
// lib/features/quran/data/datasources/quran_remote_datasource.dart
class QuranRemoteDataSource {
  final Dio dio;
  
  QuranRemoteDataSource(this.dio);
  
  Future<VerseModel> getVerse(int surah, int verse) async {
    final response = await dio.get('/api/v1/quran/verse/$surah/$verse');
    return VerseModel.fromJson(response.data);
  }
  
  Future<List<VerseModel>> getSurah(int surahNumber) async {
    final response = await dio.get('/api/v1/quran/surah/$surahNumber');
    return (response.data['verses'] as List)
        .map((v) => VerseModel.fromJson(v))
        .toList();
  }
}
```

### Typed Responses
Always define strict types for API payloads:
```dart
@JsonSerializable()
class VerseModel {
  final int verseId;
  final int surahNumber;
  final int verseNumber;
  final String arabicText;
  final String translation;
  final int letterCount;
  final bool hasSajdah;
  
  VerseModel({...});
  
  factory VerseModel.fromJson(Map<String, dynamic> json) =>
      _$VerseModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$VerseModelToJson(this);
}
```

### Request Cancellation
Prevent race conditions with CancelToken:
```dart
class SearchService {
  CancelToken? _cancelToken;
  
  Future<List<Verse>> search(String query) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    
    final response = await dio.get(
      '/api/v1/quran/search',
      queryParameters: {'q': query},
      cancelToken: _cancelToken,
    );
    return parseVerses(response.data);
  }
}
```

## Error Handling

### Custom Exception Hierarchy
```dart
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  AppException(this.message, {this.code});
}

class NetworkException extends AppException {
  NetworkException([String message = 'Network error occurred'])
      : super(message, code: 'NETWORK_ERROR');
}

class ApiException extends AppException {
  final int? statusCode;
  
  ApiException(String message, {this.statusCode, String? code})
      : super(message, code: code);
  
  factory ApiException.fromDio(DioException error) {
    final response = error.response;
    return ApiException(
      response?.data?['message'] ?? 'Unknown error',
      statusCode: response?.statusCode,
      code: response?.data?['code'],
    );
  }
}

class ValidationException extends AppException {
  final Map<String, String> fieldErrors;
  
  ValidationException(this.fieldErrors)
      : super('Validation failed', code: 'VALIDATION_ERROR');
}
```

### Error Interceptor
```dart
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timed out');
      case DioExceptionType.connectionError:
        throw NetworkException('No internet connection');
      case DioExceptionType.badResponse:
        throw ApiException.fromDio(err);
      default:
        throw AppException('Unknown error: ${err.message}');
    }
  }
}
```

## Authentication

### Secure Token Storage
```dart
class SecureStorage {
  static const _storage = FlutterSecureStorage();
  
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }
  
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }
  
  static Future<void> clearTokens() async {
    await _storage.deleteAll();
  }
}
```

### Token Lifecycle
- **Access Token:** 15 minutes expiry
- **Refresh Token:** 7 days expiry
- **Auto-Refresh:** Intercept 401 responses and refresh transparently
- **Logout:** Clear all tokens and navigate to login

### Auth Provider (Riverpod)
```dart
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  
  AuthNotifier(this._repository) : super(const AuthState.initial());
  
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _repository.login(email, password);
      state = AuthState.authenticated(user);
    } on AppException catch (e) {
      state = AuthState.error(e.message);
    }
  }
  
  Future<void> logout() async {
    await SecureStorage.clearTokens();
    state = const AuthState.unauthenticated();
  }
}
```

## Retry Logic
```dart
Future<T> withRetry<T>(
  Future<T> Function() operation, {
  int maxAttempts = 3,
  Duration delay = const Duration(seconds: 1),
}) async {
  int attempts = 0;
  while (true) {
    try {
      return await operation();
    } on NetworkException {
      attempts++;
      if (attempts >= maxAttempts) rethrow;
      await Future.delayed(delay * attempts);
    }
  }
}
```
