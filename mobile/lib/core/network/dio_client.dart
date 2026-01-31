import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/constants/api_constants.dart';
import 'package:mobile/core/network/auth_interceptor.dart';
import 'package:mobile/shared/services/secure_storage_service.dart';

final Provider<Dio> dioProvider = Provider<Dio>((Ref ref) {
  final Dio baseDio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  final SecureStorageService secureStorage = SecureStorageService();

  // Create a separate dio for refresh to avoid cycles
  final Dio refreshDio = Dio(baseDio.options);
  refreshDio.interceptors.add(
    LogInterceptor(responseBody: true, requestBody: true),
  );

  baseDio.interceptors.addAll(<Interceptor>[
    LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ),
    AuthInterceptor(secureStorage, refreshDio),
  ]);

  return baseDio;
});

class DioClient {
  final Dio dio;
  DioClient(this.dio);
}
