import 'package:flutter/material.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';

class SajdahOverlay extends StatelessWidget {
  final VoidCallback onDismiss;

  const SajdahOverlay({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.emeraldPrimary),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               const Icon(Icons.mosque, color: AppColors.emeraldPrimary, size: 48),
               const SizedBox(height: 16),
               Text('Sajdah Tilawah', style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary)),
               const SizedBox(height: 8),
               Text(
                 'You have recited a verse of prostration.', 
                 style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                 textAlign: TextAlign.center,
               ),
               const SizedBox(height: 24),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   TextButton(
                     onPressed: onDismiss,
                     child: const Text('Skip', style: TextStyle(color: AppColors.textSecondary)),
                   ),
                   ElevatedButton(
                     onPressed: onDismiss,
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppColors.emeraldPrimary,
                       foregroundColor: Colors.black,
                     ),
                     child: const Text('Performed'),
                   ),
                 ],
               ),
            ],
          ),
        ),
      ),
    );
  }
}
