import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/goals/presentation/providers/challenges_provider.dart';
import 'package:mobile/features/goals/data/models/challenge.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final challengesState = ref.watch(challengesNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: const Text('Challenges'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: challengesState.when(
        data: (state) => RefreshIndicator(
          onRefresh: () => ref.read(challengesNotifierProvider.notifier).refresh(),
          color: AppColors.emeraldPrimary,
          backgroundColor: AppColors.surfaceDark,
          child: _buildBody(state.challenges),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildBody(List<AppChallenge> challenges) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLeaderboardPreview(),
          const SizedBox(height: 32),
          Text(
            'Active Challenges',
            style: AppTextStyles.h2.copyWith(color: AppColors.emeraldPrimary, fontSize: 18),
          ),
          const SizedBox(height: 16),
          _buildChallengesList(challenges),
        ],
      ),
    );
  }

  Widget _buildLeaderboardPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceElevated, AppColors.surfaceDark],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.emeraldPrimary.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR RANK',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '#12',
                style: AppTextStyles.h1.copyWith(color: AppColors.emeraldPrimary, fontSize: 32),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'POINTS',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '2,450',
                style: AppTextStyles.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChallengesList(List<AppChallenge> challenges) {
    if (challenges.isEmpty) {
      return const Center(
        child: Text('No active challenges found.', style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: challenges.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return _ChallengeCard(challenge: challenge);
      },
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final AppChallenge challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    // Assuming target is 100 for now or adding target to model later
    const int target = 100; 
    final progressValue = challenge.progress / target;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.stars_rounded, color: AppColors.gold, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      challenge.title,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      challenge.description,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              Text(
                '${challenge.progress}/$target ${challenge.participants} members',
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 6,
              backgroundColor: AppColors.surfaceDark,
              color: AppColors.emeraldPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
