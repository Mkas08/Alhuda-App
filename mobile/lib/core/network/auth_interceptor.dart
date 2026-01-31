import 'package:dio/dio.dart';
import 'package:mobile/shared/services/secure_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;
  final Dio
  _refreshDio; // Use a separate Dio instance for refreshing to avoid infinite loops

  AuthInterceptor(this._secureStorage, this._refreshDio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await _secureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final String? refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken != null) {
        try {
          // Attempt to refresh token
          final Response<dynamic> response = await _refreshDio.post<dynamic>(
            '/auth/refresh',
            data: <String, dynamic>{'refresh_token': refreshToken},
          );

          final String newAccessToken = response.data['access_token'];
          final String newRefreshToken = response.data['refresh_token'];

          await _secureStorage.saveAccessToken(newAccessToken);
          await _secureStorage.saveRefreshToken(newRefreshToken);

          // Retry the original request
          final RequestOptions options = err.response!.requestOptions;
          options.headers['Authorization'] = 'Bearer $newAccessToken';

          final Response<dynamic> retryResponse = await _refreshDio
              .fetch<dynamic>(options);
          return handler.resolve(retryResponse);
        } catch (e) {
          // Refresh failed, logout user
          await _secureStorage.clearAuthData();
        }
      }
    }
    return handler.next(err);
  }
}
