import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';

class SessionCompletionScreen extends StatelessWidget {
  final int versesRead;
  final int hasanatEarned;
  final int durationSeconds;

  const SessionCompletionScreen({
    super.key, 
    required this.versesRead, 
    required this.hasanatEarned, 
    required this.durationSeconds
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Icon(Icons.check_circle_outline, color: AppColors.emeraldPrimary, size: 80),
               const SizedBox(height: 24),
               Text('Alhamdulillah!', style: AppTextStyles.h1),
               const SizedBox(height: 8),
               Text('You have completed your session.', style: AppTextStyles.bodyLarge),
               const SizedBox(height: 48),
               
               // Stats Card
               Container(
                 padding: const EdgeInsets.all(24),
                 decoration: BoxDecoration(
                   color: AppColors.surfaceDark,
                   borderRadius: BorderRadius.circular(20),
                   border: Border.all(color: AppColors.borderDark),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     _StatItem(label: 'Verses', value: '$versesRead'),
                     _StatItem(label: 'Hasanat', value: '$hasanatEarned', color: AppColors.gold),
                     _StatItem(label: 'Time', value: '${(durationSeconds / 60).ceil()}m'),
                   ],
                 ),
               ),
               
               const Spacer(),
               
               SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: () {
                     // Go back to home
                     context.go(RouteConstants.home); 
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: AppColors.emeraldPrimary,
                     foregroundColor: Colors.black,
                     padding: const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                   ),
                   child: const Text('Back to Home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;

  const _StatItem({required this.label, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h2.copyWith(color: color ?? Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}
