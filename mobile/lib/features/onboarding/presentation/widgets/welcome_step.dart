import 'package:flutter/material.dart';
import 'package:mobile/core/theme/colors.dart';

class WelcomeStep extends StatelessWidget {
  const WelcomeStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.emeraldPrimary,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: AppColors.emeraldGlow,
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Icon(
            Icons.star_rounded,
            size: 80,
            color: AppColors.onPrimary,
          ),
        ),
        const SizedBox(height: 48),
        const Text(
          'MARHABAN',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 32,
            fontWeight: FontWeight.w800,
            letterSpacing: 4,
            color: AppColors.emeraldPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Your consistent journey with the\nNoble Quran begins now.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Experience a focused, personalized, and rewarding way to read.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}
