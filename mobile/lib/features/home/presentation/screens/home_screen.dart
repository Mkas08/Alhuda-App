import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import '../widgets/prayer_header_card.dart';
import '../widgets/daily_goal_card.dart';
import '../widgets/home_stats_row.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(
                     width: 48,
                     height: 48,
                     alignment: Alignment.center,
                     child: const Icon(Icons.auto_awesome, color: AppColors.emeraldPrimary, size: 32),
                   ),
                   Text('Assalamu Alaikum', style: AppTextStyles.h3.copyWith(color: Colors.white)),
                   Container(
                     width: 48,
                     height: 48,
                     decoration: const BoxDecoration(
                       color: AppColors.surfaceDark,
                       shape: BoxShape.circle,
                     ),
                     child: IconButton(
                       icon: const Icon(Icons.notifications, color: Colors.white, size: 24),
                       onPressed: () {}, // TODO: Notifications
                     ),
                   )
                ],
              ),
            ),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const PrayerHeaderCard(),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => context.push(RouteConstants.goalSetup),
                      child: const DailyGoalCard(),
                    ),
                    const SizedBox(height: 16),
                    const HomeStatsRow(),
                    const SizedBox(height: 24),
                    
                    // Main CTA - Start Reading
                    // Quick Links
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildQuickLink(
                              context,
                              title: 'Dua Library',
                              icon: Icons.auto_stories_rounded,
                              color: AppColors.emeraldLight,
                              onTap: () => context.push(RouteConstants.duaLibrary),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildQuickLink(
                              context,
                              title: 'Challenges',
                              icon: Icons.track_changes_rounded,
                              color: AppColors.gold,
                              onTap: () => context.push(RouteConstants.challenges),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildQuickLink(
                              context,
                              title: 'Reminders',
                              icon: Icons.notifications_active_rounded,
                              color: AppColors.orange,
                              onTap: () {}, // TODO: Reminders
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Footer Quote
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        '"And keep the soul content with the remembrance of Allah."',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: const Color(0xFF9DB9A6),
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 100), // Bottom padding for content
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLink(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
