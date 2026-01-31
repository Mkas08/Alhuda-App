import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:mobile/features/auth/presentation/screens/verify_code_screen.dart';
import 'package:mobile/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:mobile/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:mobile/features/onboarding/presentation/screens/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteConstants.splash,
  routes: <RouteBase>[
    GoRoute(
      path: RouteConstants.splash,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashPage(),
    ),
    GoRoute(
      path: RouteConstants.login,
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: RouteConstants.register,
      builder: (BuildContext context, GoRouterState state) =>
          const RegisterScreen(),
    ),
    GoRoute(
      path: RouteConstants.forgotPassword,
      builder: (BuildContext context, GoRouterState state) =>
          const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: RouteConstants.verifyCode,
      builder: (BuildContext context, GoRouterState state) =>
          const VerifyCodeScreen(),
    ),
    GoRoute(
      path: RouteConstants.resetPassword,
      builder: (BuildContext context, GoRouterState state) =>
          const ResetPasswordScreen(),
    ),
    GoRoute(
      path: RouteConstants.home,
      builder: (BuildContext context, GoRouterState state) =>
          const _PlaceholderScreen(title: 'Home'),
    ),
    GoRoute(
      path: RouteConstants.onboarding,
      builder: (BuildContext context, GoRouterState state) =>
          const OnboardingScreen(),
    ),
  ],
);

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(title)));
  }
}
