import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile/shared/widgets/emerald_button.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeScreen extends ConsumerStatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  ConsumerState<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends ConsumerState<VerifyCodeScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_pinController.text.length == 6) {
      await ref.read(authProvider.notifier).verifyCode(_pinController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthState authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (AuthState? previous, AuthState next) {
      if (next.status == AuthStatus.codeVerified) {
        context.push(RouteConstants.resetPassword);
      } else if (next.errorMessage != null && next.errorMessage!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: <Widget>[
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text(next.errorMessage!)),
              ],
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(16),
          ),
        );
      }
    });

    final PinTheme defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.textSecondary.withValues(alpha: 0.3)),
      ),
    );

    final PinTheme focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.emeraldPrimary),
      boxShadow: const <BoxShadow>[
         BoxShadow(
          color: AppColors.emeraldGlow,
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'VERIFY CODE',
              style: TextStyle(
                fontFamily: 'Lexend',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
                color: AppColors.emeraldPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Enter the 6-digit code sent to ${authState.email ?? "your email"}',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 48),
            Center(
              child: Pinput(
                length: 6,
                controller: _pinController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                onCompleted: (String pin) => unawaited(_handleSubmit()),
              ),
            ),
            const SizedBox(height: 48),
            EmeraldButton(
              label: 'Verify',
              isLoading: authState.status == AuthStatus.loading,
              onPressed: () => unawaited(_handleSubmit()),
            ),
          ],
        ),
      ),
    );
  }
}
