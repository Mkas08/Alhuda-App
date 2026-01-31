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
  codeSent,
  codeVerified,
  passwordReset,
}

class AuthState {
  final AuthStatus status;
  final String? errorMessage;
  final String? email;
  final String? resetToken;

  AuthState({
    required this.status,
    this.errorMessage,
    this.email,
    this.resetToken,
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
    String? email,
    String? resetToken,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      resetToken: resetToken ?? this.resetToken,
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

  Future<void> forgotPassword(String email) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await _repository.forgotPassword(email);
      state = state.copyWith(status: AuthStatus.codeSent, email: email);
    } catch (e) {
      state = AuthState.unauthenticated(message: NetworkExceptions.getErrorMessage(e));
    }
  }

  Future<void> verifyCode(String code) async {
    final String? email = state.email;
    if (email == null) {
      state = AuthState.unauthenticated(message: "Email not found in state");
      return;
    }
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final String token = await _repository.verifyCode(email, code);
      state = state.copyWith(status: AuthStatus.codeVerified, resetToken: token);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated, // Or keep previous state? 
        // Better to go back to 'codeSent' concept or just show error.
        // If I switch to unauthenticated, I lose 'email'.
        errorMessage: NetworkExceptions.getErrorMessage(e),
        // Important: Preserve email so user can retry entering code!
        // But 'unauthenticated' factory recreates state.
        // I should use copyWith for error usually.
        // But existing code uses Maybe factory.
        // Let's use copyWith for error to preserve email.
      );
      // Wait, if I use copyWith(status: unauthenticated), I preserve email.
       state = state.copyWith(
        status: AuthStatus.codeSent, // Stay on verify screen?
        errorMessage: NetworkExceptions.getErrorMessage(e)
      );
    }
  }

  Future<void> resetPassword(String newPassword) async {
    final String? token = state.resetToken;
    if (token == null) {
      state = AuthState.unauthenticated(message: "Reset token not found");
      return;
    }
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);
    try {
      await _repository.resetPassword(token, newPassword);
      state = state.copyWith(status: AuthStatus.passwordReset);
    } catch (e) {
       state = state.copyWith(
        status: AuthStatus.codeVerified, // Stay on reset screen?
        errorMessage: NetworkExceptions.getErrorMessage(e)
      );
    }
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
