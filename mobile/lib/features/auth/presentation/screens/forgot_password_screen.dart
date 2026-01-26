import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/auth/presentation/widgets/auth_field.dart';
import 'package:mobile/shared/widgets/emerald_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    setState(() => _isLoading = true);
    // TODO: Implement password reset API call
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Recovery instructions sent to your email.'),
          backgroundColor: AppColors.emeraldDark,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'Enter your email address and we\'ll send you instructions to reset your password.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 48),
            AuthField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
              validator: (v) => !v!.contains('@') ? 'Enter a valid email' : null,
            ),
            const SizedBox(height: 48),
            EmeraldButton(
              label: 'Send Instructions',
              isLoading: _isLoading,
              onPressed: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
