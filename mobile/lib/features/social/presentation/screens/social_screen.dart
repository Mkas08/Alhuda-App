import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/social/presentation/providers/social_provider.dart';
import 'package:mobile/features/social/data/models/post.dart';

class SocialScreen extends ConsumerWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialState = ref.watch(socialNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: const Text('Community'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: AppColors.emeraldPrimary),
            onPressed: () {
              // TODO: Implement create post
            },
          ),
        ],
      ),
      body: socialState.when(
        data: (state) => RefreshIndicator(
          onRefresh: () => ref.read(socialNotifierProvider.notifier).refresh(),
          color: AppColors.emeraldPrimary,
          backgroundColor: AppColors.surfaceDark,
          child: _buildFeed(state.posts),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildFeed(List<SocialPost> posts) {
    if (posts.isEmpty) {
      return const Center(
        child: Text('No posts yet. Start the conversation!', style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: posts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final post = posts[index];
        return _SocialPostCard(post: post);
      },
    );
  }
}

class _SocialPostCard extends StatelessWidget {
  final SocialPost post;

  const _SocialPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.emeraldPrimary,
                child: Text(
                  post.avatar,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${post.username} • ${post.time}',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            post.content,
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary, height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildAction(Icons.favorite_border, '${post.likes}'),
              const SizedBox(width: 24),
              _buildAction(Icons.chat_bubble_outline_rounded, '${post.comments}'),
              const SizedBox(width: 24),
              _buildAction(Icons.share_outlined, ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        if (label.isNotEmpty) ...[
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}
