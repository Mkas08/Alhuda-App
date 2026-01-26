import 'package:dio/dio.dart';

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
    );
  }
}

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponse> login(String username, String password) async {
    final response = await _dio.post(
      '/auth/login',
      data: FormData.fromMap({
        'username': username,
        'password': password,
      }),
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> register({
    required String email,
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/register',
      data: {
        'email': email,
        'username': username,
        'password': password,
      },
    );
    // After registration, we usually login or return the user. 
    // Backend register returns UserSchema, not tokens.
    // So we might need a separate login call or update backend.
    // For now, let's assume we login immediately after register if needed, 
    // or just return success.
    return login(username, password);
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _dio.post(
      '/auth/refresh',
      data: {'refresh_token': refreshToken},
    );
    return AuthResponse.fromJson(response.data);
  }
}
