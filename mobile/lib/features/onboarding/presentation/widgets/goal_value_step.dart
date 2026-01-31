import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/onboarding/presentation/providers/onboarding_provider.dart';

class GoalValueStep extends ConsumerWidget {
  const GoalValueStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingData data = ref.watch(onboardingProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'SET YOUR TARGET',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: AppColors.emeraldPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'How many ${_getUnitLabel(data.goalType)} per day?',
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
        const SizedBox(height: 60),
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.emeraldPrimary, width: 4),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: AppColors.emeraldGlow,
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${data.goalValue}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Lexend',
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.emeraldPrimary,
            inactiveTrackColor: AppColors.surfaceDark,
            thumbColor: AppColors.emeraldPrimary,
            overlayColor: AppColors.emeraldGlow,
            trackHeight: 8,
          ),
          child: Slider(
            value: data.goalValue.toDouble(),
            min: 1,
            max: _getMaxValue(data.goalType).toDouble(),
            divisions: _getDivisions(data.goalType),
            onChanged: (double val) => ref
                .read(onboardingProvider.notifier)
                .updateGoalValue(val.round()),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          _getDescription(data.goalType, data.goalValue),
          style: const TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  String _getUnitLabel(GoalType type) {
    switch (type) {
      case GoalType.verse:
        return 'verses';
      case GoalType.time:
        return 'minutes';
      case GoalType.page:
        return 'pages';
    }
  }

  int _getMaxValue(GoalType type) {
    switch (type) {
      case GoalType.verse:
        return 100;
      case GoalType.time:
        return 120;
      case GoalType.page:
        return 30;
    }
  }

  int _getDivisions(GoalType type) {
    switch (type) {
      case GoalType.verse:
        return 99;
      case GoalType.time:
        return 119;
      case GoalType.page:
        return 29;
    }
  }

  String _getDescription(GoalType type, int value) {
    if (type == GoalType.time) {
      return 'Approximately ${value ~/ 2} verses at a moderate pace.';
    }
    if (type == GoalType.page) {
      return 'About ${value * 15} verses depending on the surah.';
    }
    return 'Consistent reading builds a strong spiritual habit.';
  }
}
