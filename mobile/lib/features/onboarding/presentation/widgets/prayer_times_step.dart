import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/onboarding/presentation/providers/onboarding_provider.dart';

class PrayerTimesStep extends ConsumerWidget {
  const PrayerTimesStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingData data = ref.watch(onboardingProvider);
    final List<String> prayerTimes = <String>[
      'After Fajr',
      'After Dhuhr',
      'After Asr',
      'After Maghrib',
      'After Isha',
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'BEST TIMES TO READ',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
            color: AppColors.emeraldPrimary,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Select your preferred reading slots. We\'ll remind you at these times.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 12,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: prayerTimes.map((String time) {
            final bool isSelected = data.preferredTimes.contains(time);
            return GestureDetector(
              onTap: () => ref
                  .read(onboardingProvider.notifier)
                  .togglePreferredTime(time),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.emeraldPrimary
                      : AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.emeraldPrimary
                        : AppColors.borderDark,
                    width: 2,
                  ),
                ),
                child: Text(
                  time,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.onPrimary
                        : AppColors.textPrimary,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 40),
        const Text(
          'We will use your location for accurate prayer times.',
          style: TextStyle(color: AppColors.textMuted, fontSize: 12),
        ),
      ],
    );
  }
}
