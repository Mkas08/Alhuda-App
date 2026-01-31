import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/shared/services/language_provider.dart';

class LanguageStep extends ConsumerWidget {
  const LanguageStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLanguage currentLang = ref.watch(languageProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'CHOOSE LANGUAGE',
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
          'Select your preferred language for the app interface and translations.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
        ),
        const SizedBox(height: 48),
        _buildLanguageOption(context, ref, AppLanguage.english, currentLang),
        const SizedBox(height: 20),
        _buildLanguageOption(context, ref, AppLanguage.arabic, currentLang),
      ],
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref,
    AppLanguage language,
    AppLanguage selected,
  ) {
    final bool isSelected = language == selected;

    return GestureDetector(
      onTap: () => ref.read(languageProvider.notifier).setLanguage(language),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceElevated : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.emeraldPrimary : AppColors.borderDark,
            width: 2,
          ),
          boxShadow: isSelected
              ? <BoxShadow>[
                  const BoxShadow(
                    color: AppColors.emeraldGlow,
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              language.label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                color: isSelected
                    ? AppColors.emeraldPrimary
                    : AppColors.textPrimary,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.emeraldPrimary,
              ),
          ],
        ),
      ),
    );
  }
}
