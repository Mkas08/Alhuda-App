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
import 'package:mobile/features/goals/presentation/screens/goal_setup_screen.dart';
import 'package:mobile/features/home/presentation/screens/home_screen.dart';
import 'package:mobile/features/settings/presentation/screens/settings_screen.dart';
import 'package:mobile/features/quran/presentation/screens/reading_screen.dart';
import 'package:mobile/features/quran/presentation/screens/surah_list_screen.dart';
import 'package:mobile/features/main/presentation/screens/main_shell_screen.dart';
import 'package:mobile/features/social/presentation/screens/social_screen.dart';
import 'package:mobile/features/goals/presentation/screens/challenges_screen.dart';
import 'package:mobile/features/focus_mode/presentation/screens/app_blocking_screen.dart';
import 'package:mobile/features/chat/presentation/screens/chat_list_screen.dart';
import 'package:mobile/features/chat/presentation/screens/conversation_screen.dart';
import 'package:mobile/features/prayer/presentation/screens/prayer_times_screen.dart';
import 'package:mobile/features/dua/presentation/screens/dua_library_screen.dart';
import 'package:mobile/features/dua/presentation/screens/dua_category_screen.dart';
import 'package:mobile/features/dua/presentation/screens/dua_detail_screen.dart';
import 'package:mobile/features/dua/data/models/dua.dart';
import 'package:mobile/features/quran/presentation/screens/session_completion_screen.dart';

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
      path: RouteConstants.onboarding,
      builder: (BuildContext context, GoRouterState state) =>
          const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteConstants.goalSetup,
      builder: (BuildContext context, GoRouterState state) =>
          const GoalSetupScreen(),
    ),
    // Main Shell with Bottom Navigation
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MainShellScreen(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteConstants.home,
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
        GoRoute(
          path: RouteConstants.surahs,
          builder: (BuildContext context, GoRouterState state) =>
              const SurahListScreen(),
        ),
        GoRoute(
          path: '${RouteConstants.reading}/:surahId/:verseId',
          builder: (BuildContext context, GoRouterState state) {
            final surahId = int.parse(state.pathParameters['surahId'] ?? '1');
            final verseId = int.parse(state.pathParameters['verseId'] ?? '1');
            return ReadingScreen(surahNumber: surahId, verseNumber: verseId);
          },
        ),
        GoRoute(
          path: RouteConstants.chat,
          builder: (BuildContext context, GoRouterState state) =>
              const ChatListScreen(),
        ),
        GoRoute(
          path: RouteConstants.social,
          builder: (BuildContext context, GoRouterState state) =>
              const SocialScreen(),
        ),
        GoRoute(
          path: RouteConstants.settings,
          builder: (BuildContext context, GoRouterState state) =>
              const SettingsScreen(),
        ),
        GoRoute(
          path: RouteConstants.challenges,
          builder: (BuildContext context, GoRouterState state) =>
              const ChallengesScreen(),
        ),
        GoRoute(
          path: RouteConstants.blocking,
          builder: (BuildContext context, GoRouterState state) =>
              const AppBlockingScreen(),
        ),
      ],
    ),
    // Conversation screen outside shell to hide bottom bar
    GoRoute(
      path: RouteConstants.conversation,
      builder: (BuildContext context, GoRouterState state) =>
          const ConversationScreen(),
    ),
    GoRoute(
      path: RouteConstants.prayerTimes,
      builder: (BuildContext context, GoRouterState state) =>
          const PrayerTimesScreen(),
    ),
    GoRoute(
      path: RouteConstants.duaLibrary,
      builder: (BuildContext context, GoRouterState state) =>
          const DuaLibraryScreen(),
    ),
    GoRoute(
      name: RouteConstants.duaCategory,
      path: RouteConstants.duaCategory,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'] ?? '';
        final name = state.pathParameters['name'] ?? '';
        return DuaCategoryScreen(categoryId: id, categoryName: name);
      },
    ),
    GoRoute(
      name: RouteConstants.duaDetail,
      path: RouteConstants.duaDetail,
      builder: (BuildContext context, GoRouterState state) {
        final dua = state.extra as Dua;
        return DuaDetailScreen(dua: dua);
      },
    ),
    GoRoute(
      path: RouteConstants.sessionCompletion,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>;
        return SessionCompletionScreen(
          versesRead: extra['versesRead'] as int,
          hasanatEarned: extra['hasanatEarned'] as int,
          durationSeconds: extra['durationSeconds'] as int,
        );
      },
    ),
  ],
);
