import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';

class DailyGoalCard extends StatelessWidget {
  const DailyGoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/reading/1/1'), // Proceed to Ayah-by-Ayah mock
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.menu_book, color: AppColors.emeraldPrimary, size: 24),
                    const SizedBox(width: 8),
                    Text('Daily Goal', style: AppTextStyles.h3),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.emeraldPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.emeraldPrimary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.local_fire_department, color: AppColors.emeraldPrimary, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '12 DAY STREAK', 
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.emeraldPrimary, 
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            
            // Progress Text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Progress', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '7', style: AppTextStyles.h3),
                      TextSpan(text: '/10 Verses', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                    ]
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: const LinearProgressIndicator(
                value: 0.7,
                backgroundColor: Color(0xFF3B5443),
                color: AppColors.emeraldPrimary,
                minHeight: 12,
              ),
            ),
            
            const SizedBox(height: 16),

             // Continue Reading CTA
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Continue Reading',
                  style: AppTextStyles.labelSmall.copyWith(color: AppColors.emeraldLight),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, color: AppColors.emeraldLight, size: 16),
              ],
            ),
            
            const SizedBox(height: 8),

            Text(
              '“The best of deeds are those done consistently.”',
              style: AppTextStyles.bodySmall.copyWith(
                color: const Color(0xFF9DB9A6),
                fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
      ),
    );
  }
}
