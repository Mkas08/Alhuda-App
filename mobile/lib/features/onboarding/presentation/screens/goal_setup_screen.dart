import 'package:flutter/material.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';

class GoalSetupScreen extends StatelessWidget {
  const GoalSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: const Text('Goal Setup'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flag_rounded, size: 64, color: AppColors.emeraldPrimary),
            const SizedBox(height: 16),
            Text('Daily Goals', style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text('Customize your reading habits', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
