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
    final Response<dynamic> response = await _dio.post<dynamic>(
      '/auth/login',
      data: FormData.fromMap(<String, dynamic>{
        'username': username,
        'password': password,
      }),
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<AuthResponse> register({
    required String email,
    required String username,
    required String password,
  }) async {
    await _dio.post<dynamic>(
      '/auth/register',
      data: <String, dynamic>{
        'email': email,
        'username': username,
        'password': password,
      },
    );
    // After registration, we usually login or return the user.
    return login(username, password);
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      '/auth/refresh',
      data: <String, dynamic>{'refresh_token': refreshToken},
    );
    return AuthResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post<dynamic>(
      '/auth/forgot-password',
      data: <String, String>{'email': email},
    );
  }

  Future<String> verifyCode(String email, String code) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      '/auth/verify-code',
      data: <String, String>{'email': email, 'code': code},
    );
    return (response.data as Map<String, dynamic>)['reset_token'] as String;
  }

  Future<void> resetPassword(String resetToken, String newPassword) async {
    await _dio.post<dynamic>(
      '/auth/reset-password',
      data: <String, String>{
        'reset_token': resetToken,
        'new_password': newPassword,
      },
    );
  }
}
