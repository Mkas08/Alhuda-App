import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile/features/auth/presentation/widgets/auth_field.dart';
import 'package:mobile/shared/widgets/emerald_button.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(authProvider.notifier).forgotPassword(_emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthState authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (AuthState? previous, AuthState next) {
      if (next.status == AuthStatus.codeSent) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: <Widget>[
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Expanded(child: Text('Reset code sent! Please check your email.')),
              ],
            ),
            backgroundColor: AppColors.emeraldPrimary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.all(16),
          ),
        );
        context.push(RouteConstants.verifyCode);
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'FORGOT PASSWORD?',
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
                'Enter your email address and we\'ll send you a verification code to reset your password.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              const SizedBox(height: 48),
              AuthField(
                controller: _emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (String? v) =>
                    !v!.contains('@') ? 'Enter a valid email' : null,
              ),
              const SizedBox(height: 48),
              EmeraldButton(
                label: 'Send Code',
                isLoading: authState.status == AuthStatus.loading,
                onPressed: () => unawaited(_handleSubmit()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
