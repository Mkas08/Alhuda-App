import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/error/network_exceptions.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';

enum ResetPasswordStatus { initial, loading, codeSent, codeVerified, success, error }

class ResetPasswordState {
  final ResetPasswordStatus status;
  final String? email;
  final String? resetToken;
  final String? errorMessage;

  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    this.email,
    this.resetToken,
    this.errorMessage,
  });

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? email,
    String? resetToken,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      resetToken: resetToken ?? this.resetToken,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ResetPasswordNotifier extends StateNotifier<ResetPasswordState> {
  final AuthRepository _repository;

  ResetPasswordNotifier(this._repository) : super(const ResetPasswordState());

  Future<void> requestPasswordReset(String email) async {
    state = state.copyWith(status: ResetPasswordStatus.loading, errorMessage: null);
    try {
      await _repository.forgotPassword(email);
      state = state.copyWith(status: ResetPasswordStatus.codeSent, email: email);
    } catch (e) {
      state = state.copyWith(
        status: ResetPasswordStatus.error,
        errorMessage: NetworkExceptions.getErrorMessage(e),
      );
    }
  }

  Future<void> verifyCode(String code) async {
    if (state.email == null) return;
    state = state.copyWith(status: ResetPasswordStatus.loading, errorMessage: null);
    try {
      final token = await _repository.verifyCode(state.email!, code);
      state = state.copyWith(status: ResetPasswordStatus.codeVerified, resetToken: token);
    } catch (e) {
      state = state.copyWith(
        status: ResetPasswordStatus.error,
        errorMessage: NetworkExceptions.getErrorMessage(e),
      );
    }
  }

  Future<void> resetPassword(String newPassword) async {
    if (state.resetToken == null) return;
    state = state.copyWith(status: ResetPasswordStatus.loading, errorMessage: null);
    try {
      await _repository.resetPassword(state.resetToken!, newPassword);
      state = state.copyWith(status: ResetPasswordStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: ResetPasswordStatus.error,
        errorMessage: NetworkExceptions.getErrorMessage(e),
      );
    }
  }
}

final resetPasswordProvider = StateNotifierProvider.autoDispose<ResetPasswordNotifier, ResetPasswordState>((ref) {
  return ResetPasswordNotifier(ref.watch(authRepositoryProvider));
});
