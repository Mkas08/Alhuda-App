import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/onboarding/presentation/providers/onboarding_provider.dart';

class GoalTypeStep extends ConsumerWidget {
  const GoalTypeStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(onboardingProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'WHAT IS YOUR GOAL?',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: AppColors.emeraldPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Choose how you want to measure your daily spiritual progress.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
        const SizedBox(height: 48),
        _buildOption(context, ref, GoalType.verse, 'Verse-based', 'Read a specific number of ayahs', data.goalType),
        const SizedBox(height: 16),
        _buildOption(context, ref, GoalType.time, 'Time-based', 'Dedicate focused reading time', data.goalType),
        const SizedBox(height: 16),
        _buildOption(context, ref, GoalType.page, 'Page-based', 'Read a fixed number of pages', data.goalType),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context,
    WidgetRef ref,
    GoalType type,
    String title,
    String subtitle,
    GoalType selected,
  ) {
    final isSelected = type == selected;

    return GestureDetector(
      onTap: () => ref.read(onboardingProvider.notifier).updateGoalType(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceElevated : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.emeraldPrimary : AppColors.borderDark,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.emeraldPrimary : AppColors.surfaceDark,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(type),
                color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isSelected ? AppColors.emeraldPrimary : AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(GoalType type) {
    switch (type) {
      case GoalType.verse: return Icons.menu_book_rounded;
      case GoalType.time: return Icons.timer_rounded;
      case GoalType.page: return Icons.auto_stories_rounded;
    }
  }
}
