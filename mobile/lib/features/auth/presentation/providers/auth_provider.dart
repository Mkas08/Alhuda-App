import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/shared/services/secure_storage_service.dart';

enum AuthStatus { authenticated, unauthenticated, loading, initial }

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  AuthState({required this.status, this.errorMessage});

  factory AuthState.initial() => AuthState(status: AuthStatus.initial);
  factory AuthState.loading() => AuthState(status: AuthStatus.loading);
  factory AuthState.authenticated() => AuthState(status: AuthStatus.authenticated);
  factory AuthState.unauthenticated({String? message}) => 
      AuthState(status: AuthStatus.unauthenticated, errorMessage: message);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final SecureStorageService _secureStorage;

  AuthNotifier(this._repository, this._secureStorage) : super(AuthState.initial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = AuthState.loading();
    final token = await _secureStorage.getAccessToken();
    if (token != null) {
      state = AuthState.authenticated();
    } else {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> login(String username, String password) async {
    state = AuthState.loading();
    try {
      final response = await _repository.login(username, password);
      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      state = AuthState.authenticated();
    } catch (e) {
      state = AuthState.unauthenticated(message: e.toString());
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    state = AuthState.loading();
    try {
      final response = await _repository.register(
        email: email,
        username: username,
        password: password,
      );
      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      state = AuthState.authenticated();
    } catch (e) {
      state = AuthState.unauthenticated(message: e.toString());
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearAuthData();
    state = AuthState.unauthenticated();
  }
}

// Providers
final authRepositoryProvider = Provider((ref) => AuthRepository(ref.watch(dioProvider))); // Need to define dioProvider
final secureStorageProvider = Provider((ref) => SecureStorageService());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(authRepositoryProvider),
    ref.watch(secureStorageProvider),
  );
});
