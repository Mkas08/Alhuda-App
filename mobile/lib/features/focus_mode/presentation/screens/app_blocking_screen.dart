import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/focus_mode/presentation/providers/focus_mode_provider.dart';
import 'package:mobile/features/focus_mode/data/models/app_block_info.dart';

class AppBlockingScreen extends ConsumerWidget {
  const AppBlockingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusState = ref.watch(focusModeNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: const Text('App Blocking'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: focusState.when(
        data: (state) => _buildBody(context, ref, state),
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, FocusModeState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusCard(ref, state),
          const SizedBox(height: 32),
          _buildSectionHeader(
            title: 'Blocked Apps',
            description: 'These apps will be restricted during your reading sessions.',
          ),
          _buildAppsList(ref, state.apps),
          const SizedBox(height: 32),
          _buildSectionHeader(
            title: 'Focus Schedule',
            description: 'Automatically enable focus mode during these times.',
          ),
          _buildScheduleOptions(),
        ],
      ),
    );
  }

  Widget _buildStatusCard(WidgetRef ref, FocusModeState state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: state.isEnabled ? AppColors.emeraldPrimary : AppColors.borderDark,
          width: 2,
        ),
        boxShadow: state.isEnabled ? [
          BoxShadow(
            color: AppColors.emeraldPrimary.withValues(alpha: 0.1),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ] : null,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: state.isEnabled ? AppColors.emeraldPrimary : AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.do_not_disturb_on_rounded,
              color: state.isEnabled ? Colors.black : AppColors.textSecondary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Focus Mode',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.isEnabled ? 'Active' : 'Inactive',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: state.isEnabled ? AppColors.emeraldPrimary : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: state.isEnabled,
            onChanged: (value) => ref.read(focusModeNotifierProvider.notifier).toggleFocus(),
            activeTrackColor: AppColors.emeraldPrimary.withValues(alpha: 0.5),
            activeThumbColor: AppColors.emeraldPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h2.copyWith(color: AppColors.emeraldPrimary, fontSize: 18),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAppsList(WidgetRef ref, List<AppBlockInfo> apps) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: apps.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final app = apps[index];
        return _buildAppItem(ref, app);
      },
    );
  }

  Widget _buildAppItem(WidgetRef ref, AppBlockInfo app) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: app.blocked ? AppColors.orange.withValues(alpha: 0.5) : AppColors.borderDark,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _getAppIconBg(app.icon),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                _getAppIcon(app.icon),
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  app.category,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          if (app.blocked)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'BLOCKED',
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(width: 8),
          Checkbox(
            value: app.blocked,
            onChanged: (value) => ref.read(focusModeNotifierProvider.notifier).toggleAppBlock(app.id),
            activeColor: AppColors.emeraldPrimary,
            side: const BorderSide(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleOptions() {
    return Column(
      children: [
        _buildScheduleItem(
          icon: Icons.wb_twilight_rounded,
          title: 'Morning Prayer (Fajr)',
          time: '5:00 AM - 6:30 AM',
        ),
        const SizedBox(height: 12),
        _buildScheduleItem(
          icon: Icons.nightlight_round_rounded,
          title: 'Nightly Reflection',
          time: '9:00 PM - 10:00 PM',
        ),
      ],
    );
  }

  Widget _buildScheduleItem({required IconData icon, required String title, required String time}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderDark),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.gold, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  IconData _getAppIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'instagram': return Icons.camera_alt_outlined;
      case 'tiktok': return Icons.music_note_outlined;
      case 'youtube': return Icons.play_circle_outline;
      case 'social': return Icons.people_outline;
      case 'games': return Icons.videogame_asset_outlined;
      default: return Icons.apps;
    }
  }

  Color _getAppIconBg(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'instagram': return const Color(0xFFE1306C);
      case 'tiktok': return Colors.black;
      case 'youtube': return const Color(0xFFFF0000);
      case 'social': return const Color(0xFF1DA1F2);
      case 'games': return const Color(0xFF9146FF);
      default: return AppColors.surfaceElevated;
    }
  }
}
