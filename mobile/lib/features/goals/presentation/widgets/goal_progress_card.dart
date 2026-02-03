import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/goals/domain/entities/goal.dart';
import 'package:mobile/features/goals/domain/entities/user_stats.dart';
import 'package:mobile/features/goals/presentation/providers/goal_provider.dart';

class GoalProgressCard extends ConsumerWidget {
  const GoalProgressCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoalState state = ref.watch(goalProvider);

    if (state.isLoading && state.stats == null) {
      return const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary));
    }

    final UserStats? stats = state.stats;
    if (stats == null) {
      return _buildNoStatsCard(context);
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderDark),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildStatItem(
                context,
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.orange,
                value: '${stats.currentStreak}',
                label: 'Day Streak',
              ),
              _buildStatItem(
                context,
                icon: Icons.auto_awesome,
                iconColor: AppColors.gold,
                value: '${stats.totalHasanat}',
                label: 'Hasanat',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.borderDark),
          const SizedBox(height: 24),
          _buildGoalSection(context, state),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 8),
            Text(
              value,
              style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
            ),
          ],
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildGoalSection(BuildContext context, GoalState state) {
    final Goal? goal = state.activeGoal;
    
    if (goal == null) {
      return Column(
        children: <Widget>[
          Text(
            'No active goal set',
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.push(RouteConstants.goalSetup),
            child: const Text('Set Daily Goal', style: TextStyle(color: AppColors.emeraldPrimary)),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Daily Goal: ${goal.goalValue} ${goal.goalType}s',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
            ),
            Text(
              '${state.completionPercentage.toInt()}%',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.emeraldPrimary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: state.completionPercentage / 100,
            backgroundColor: AppColors.borderDark,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.emeraldPrimary),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () => context.push(RouteConstants.goalSetup),
          child: Text(
            'EDIT GOAL',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.emeraldPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoStatsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          const Icon(Icons.auto_stories_outlined, color: AppColors.textSecondary, size: 48),
          const SizedBox(height: 16),
          Text(
            'Start your journey today',
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.push(RouteConstants.goalSetup),
            child: const Text('SET DAILY GOAL'),
          ),
        ],
      ),
    );
  }
}
