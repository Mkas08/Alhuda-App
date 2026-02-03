import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import '../providers/prayer_provider.dart';

class PrayerTimesScreen extends ConsumerWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimesAsync = ref.watch(prayerTimesProvider);

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: Text('Prayer Times', style: AppTextStyles.h3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: prayerTimesAsync.when(
        data: (prayers) {
           final nextPrayer = prayers.firstWhere((p) => p.isNext, orElse: () => prayers.first);
           return SingleChildScrollView(
             child: Padding(
               padding: const EdgeInsets.all(24.0),
               child: Column(
                 children: [
                   // Header
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               const Icon(Icons.location_on, color: AppColors.emeraldPrimary, size: 16),
                               const SizedBox(width: 4),
                               Text('London, UK', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                             ],
                           ),
                           const SizedBox(height: 4),
                           Text('2 Sha\'ban 1447', style: AppTextStyles.h3),
                         ],
                       ),
                       // Qibla Widget
                       Container(
                         padding: const EdgeInsets.all(12),
                         decoration: BoxDecoration(
                           color: AppColors.surfaceDark,
                           borderRadius: BorderRadius.circular(16),
                           border: Border.all(color: AppColors.borderDark),
                         ),
                         child: Column(
                           children: [
                             const Icon(Icons.explore, color: AppColors.gold, size: 24),
                             const SizedBox(height: 4),
                              Text('Qibla', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                           ],
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 32),
                   
                   // Countdown / Next Prayer Highlight
                   Container(
                     padding: const EdgeInsets.all(24),
                     decoration: BoxDecoration(
                       gradient: const LinearGradient(
                         colors: [AppColors.emeraldPrimary, AppColors.emeraldSecondary],
                         begin: Alignment.topLeft,
                         end: Alignment.bottomRight,
                       ),
                       borderRadius: BorderRadius.circular(24),
                       boxShadow: [
                         BoxShadow(
                           color: AppColors.emeraldPrimary.withValues(alpha: 0.3),
                           blurRadius: 20,
                           offset: const Offset(0, 10),
                         )
                       ],
                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Next Prayer', style: AppTextStyles.bodySmall.copyWith(color: Colors.black54)),
                             Text(nextPrayer.name, style: AppTextStyles.h1.copyWith(color: Colors.black)),
                           ],
                         ),
                         Text(
                           _formatTime(nextPrayer.time), 
                           style: AppTextStyles.h1.copyWith(color: Colors.black),
                         ),
                       ],
                     ),
                   ),

                   const SizedBox(height: 32),

                   // List of Prayers
                   ListView.separated(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     itemCount: prayers.length,
                     separatorBuilder: (_, __) => const SizedBox(height: 12),
                     itemBuilder: (context, index) {
                       final prayer = prayers[index];
                       final isNext = prayer.isNext;
                       return Container(
                         padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isNext ? AppColors.surfaceDark.withValues(alpha: 0.8) : Colors.transparent,
                           borderRadius: BorderRadius.circular(16),
                           border: isNext ? Border.all(color: AppColors.emeraldPrimary) : Border.all(color: AppColors.borderDark),
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               prayer.name,
                               style: isNext 
                                   ? AppTextStyles.h3.copyWith(color: AppColors.emeraldPrimary)
                                   : AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
                             ),
                             Text(
                               _formatTime(prayer.time),
                               style: isNext
                                   ? AppTextStyles.h3.copyWith(color: AppColors.emeraldPrimary)
                                   : AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
                             ),
                           ],
                         ),
                       );
                     },
                   ),
                 ],
               ),
             ),
           );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
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
