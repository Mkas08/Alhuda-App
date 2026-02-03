import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/error/network_exceptions.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/shared/services/secure_storage_service.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
  initial,
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;

  AuthState({
    required this.status,
    this.errorMessage,
  });

  factory AuthState.initial() => AuthState(status: AuthStatus.initial);
  factory AuthState.loading() => AuthState(status: AuthStatus.loading);
  factory AuthState.authenticated() =>
      AuthState(status: AuthStatus.authenticated);
  factory AuthState.unauthenticated({String? message}) =>
      AuthState(status: AuthStatus.unauthenticated, errorMessage: message);

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  final SecureStorageService _secureStorage;

  AuthNotifier(this._repository, this._secureStorage)
    : super(AuthState.initial()) {
    unawaited(checkAuthStatus());
  }

  Future<void> checkAuthStatus() async {
    state = AuthState.loading();
    final String? token = await _secureStorage.getAccessToken();
    if (token != null) {
      state = AuthState.authenticated();
    } else {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final AuthResponse response = await _repository.login(username, password);
      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      state = AuthState.authenticated();
    } catch (e) {
      state = AuthState.unauthenticated(message: NetworkExceptions.getErrorMessage(e));
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      final AuthResponse response = await _repository.register(
        email: email,
        username: username,
        password: password,
      );
      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      state = AuthState.authenticated();
    } catch (e) {
      state = AuthState.unauthenticated(message: NetworkExceptions.getErrorMessage(e));
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearAuthData();
    state = AuthState.unauthenticated();
  }
}

// Providers
final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>(
      (Ref ref) => AuthRepository(ref.watch(dioProvider)),
    );
final Provider<SecureStorageService> secureStorageProvider =
    Provider<SecureStorageService>((Ref ref) => SecureStorageService());

final StateNotifierProvider<AuthNotifier, AuthState> authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((Ref ref) {
      return AuthNotifier(
        ref.watch(authRepositoryProvider),
        ref.watch(secureStorageProvider),
      );
    });
