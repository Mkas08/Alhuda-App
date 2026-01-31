import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/onboarding/presentation/widgets/goal_type_step.dart';
import 'package:mobile/features/onboarding/presentation/widgets/goal_value_step.dart';
import 'package:mobile/features/onboarding/presentation/widgets/language_step.dart';
import 'package:mobile/features/onboarding/presentation/widgets/prayer_times_step.dart';
import 'package:mobile/features/onboarding/presentation/widgets/welcome_step.dart';
import 'package:mobile/shared/widgets/emerald_button.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalSteps = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    context.go(RouteConstants.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            // Progress Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: List<Widget>.generate(_totalSteps, (int index) {
                  final bool isActive = index <= _currentPage;
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.emeraldPrimary
                            : AppColors.surfaceDark,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: isActive
                            ? const <BoxShadow>[
                                BoxShadow(
                                  color: AppColors.emeraldGlow,
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int page) =>
                    setState(() => _currentPage = page),
                children: const <Widget>[
                  WelcomeStep(),
                  LanguageStep(),
                  GoalTypeStep(),
                  GoalValueStep(),
                  PrayerTimesStep(),
                  _BlockingStep(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: EmeraldButton(
                label: _currentPage == _totalSteps - 1
                    ? 'GET STARTED'
                    : 'CONTINUE',
                onPressed: _nextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlockingStep extends StatelessWidget {
  const _BlockingStep();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.block_rounded, size: 80, color: AppColors.orange),
        const SizedBox(height: 40),
        const Text(
          'STAY FOCUSED',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: AppColors.emeraldPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Al-Huda can block distracting apps while you read to ensure your spiritual focus remains unbroken.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderDark),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.info_outline_rounded, color: AppColors.gold, size: 20),
              SizedBox(width: 12),
              Text(
                'Available now on Android',
                style: TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
