import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';
import 'package:mobile/features/auth/presentation/widgets/auth_field.dart';
import 'package:mobile/shared/widgets/emerald_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      await ref
          .read(authProvider.notifier)
          .login(_usernameController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthState authState = ref.watch(authProvider);

    // Listen for auth success to navigate
    ref.listen<AuthState>(authProvider, (AuthState? previous, AuthState next) {
      if (next.status == AuthStatus.authenticated) {
        context.go(RouteConstants.onboarding);
      } else if (next.status == AuthStatus.unauthenticated &&
          next.errorMessage != null &&
          next.errorMessage!.isNotEmpty) {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60),
                // Logo placeholder
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.emeraldPrimary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: AppColors.emeraldGlow,
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.shield_rounded,
                    size: 40,
                    color: AppColors.onPrimary,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'WELCOME BACK',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                    color: AppColors.emeraldPrimary,
                  ),
                ),
                const Text(
                  'Login to continue your spiritual journey',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 48),
                AuthField(
                  controller: _usernameController,
                  label: 'Username',
                  validator: (String? v) =>
                      v!.isEmpty ? 'Please enter your username' : null,
                ),
                const SizedBox(height: 24),
                AuthField(
                  controller: _passwordController,
                  label: 'Password',
                  obscureText: _obscurePassword,
                  validator: (String? v) =>
                      v!.isEmpty ? 'Please enter your password' : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(
                      RouteConstants.forgotPassword,
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.emeraldLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                EmeraldButton(
                  label: 'Sign In',
                  isLoading: authState.status == AuthStatus.loading,
                  onPressed: () => unawaited(_handleLogin()),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () =>
                          unawaited(context.push(RouteConstants.register)),
                      child: const Text(
                        'Create Now',
                        style: TextStyle(
                          color: AppColors.emeraldPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
