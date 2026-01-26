import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:mobile/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:mobile/features/onboarding/presentation/screens/splash_page.dart';

final appRouter = GoRouter(
  initialLocation: RouteConstants.splash,
  routes: [
    GoRoute(
      path: RouteConstants.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RouteConstants.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteConstants.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteConstants.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: RouteConstants.resetPassword,
      builder: (context, state) => const _PlaceholderScreen(title: 'Reset Password'),
    ),
    GoRoute(
      path: RouteConstants.home,
      builder: (context, state) => const _PlaceholderScreen(title: 'Home'),
    ),
    GoRoute(
      path: RouteConstants.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(title)),
    );
  }
}
