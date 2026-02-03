import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/auth/presentation/providers/reset_password_provider.dart';
import 'package:mobile/features/auth/presentation/widgets/auth_field.dart';
import 'package:mobile/shared/widgets/emerald_button.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(resetPasswordProvider.notifier).resetPassword(_passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ResetPasswordState resetState = ref.watch(resetPasswordProvider);

    ref.listen<ResetPasswordState>(resetPasswordProvider, (ResetPasswordState? previous, ResetPasswordState next) {
      if (next.status == ResetPasswordStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Expanded(child: Text('Password reset successfully! Please login.')),
              ],
            ),
            backgroundColor: AppColors.emeraldPrimary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(16),
          ),
        );
        // Navigate to login and clear stack
        context.go(RouteConstants.login);
      } else if (next.status == ResetPasswordStatus.error && next.errorMessage != null && next.errorMessage!.isNotEmpty) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'RESET PASSWORD',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: AppColors.emeraldPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enter your new password below.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 48),
              AuthField(
                controller: _passwordController,
                label: 'New Password',
                obscureText: _obscurePassword,
                validator: (String? v) =>
                    v!.length < 8 ? 'Password must be 8+ chars' : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
              const SizedBox(height: 24),
              AuthField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                obscureText: _obscurePassword,
                validator: (String? v) => v != _passwordController.text
                    ? 'Passwords do not match'
                    : null,
              ),
              const SizedBox(height: 48),
              EmeraldButton(
                label: 'Reset Password',
                isLoading: resetState.status == ResetPasswordStatus.loading,
                onPressed: () => unawaited(_handleSubmit()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
