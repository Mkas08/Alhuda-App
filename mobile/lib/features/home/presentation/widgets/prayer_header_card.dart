import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/prayer/presentation/providers/prayer_provider.dart';

class PrayerHeaderCard extends ConsumerWidget {
  const PrayerHeaderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch prayer times to get the next prayer
    final prayerTimesAsync = ref.watch(prayerTimesProvider);

    return GestureDetector(
      onTap: () => context.push(RouteConstants.prayerTimes),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: NetworkImage(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuDEm4C-ecyoVI2KndhWBblRKb8gOFTGpLEbb28KRMrvIT4em5bY6SPC6O_DvZbm1eYuAlfpLc2Ya4K9gG_PweQV4T2pqksB-VEXA5HZsdbudym2Xa7jLvAnxInWZDdXjTWsVMPuujql3iZ4gcfi9_vrNMdPfo6OHJb8l7DWd5EX3pVpB9qhJFJrzjCO4grSNlCUoHIE7opEy5d--2qHfo1Bz7m6XiAwyFuWiN1HbD4ftxkw919bUHct2LA5SHLfra9882YjFyWm_Lca',
            ),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.2),
                AppColors.surfaceDark.withValues(alpha: 0.9),
              ],
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: prayerTimesAsync.when(
            data: (prayers) {
              final nextPrayer = prayers.firstWhere((p) => p.isNext, orElse: () => prayers.first);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Next Prayer', style: AppTextStyles.bodySmall.copyWith(color: AppColors.emeraldPrimary)),
                          Text(nextPrayer.name, style: AppTextStyles.h2.copyWith(color: Colors.white, height: 1.1)),
                        ],
                      ),
                      
                      // Qibla Indicator Mini
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.explore, color: AppColors.gold, size: 16),
                            const SizedBox(width: 4),
                            Text('QIBLA', style: AppTextStyles.labelSmall.copyWith(color: AppColors.gold)),
                          ],
                        ),
                      ),
                    ],
                   ),

                   // Bottom Row
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: AppColors.gold, size: 16),
                          const SizedBox(width: 4),
                          Text('London, UK', style: AppTextStyles.bodySmall.copyWith(color: const Color(0xFF9DB9A6))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.emeraldPrimary,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.emeraldPrimary.withValues(alpha: 0.3),
                              blurRadius: 10,
                            )
                          ]
                        ),
                        child: Text(
                          _formatTime(nextPrayer.time),
                          style: AppTextStyles.labelLarge.copyWith(color: AppColors.deepForest),
                        ),
                      )
                    ],
                   )
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary)),
            error: (_, __) => const Center(child: Text('Error loading prayers', style: TextStyle(color: Colors.white))),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
