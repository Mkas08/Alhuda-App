import 'package:flutter/material.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/core/theme/theme_extensions.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.deepForest,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.emeraldPrimary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.gold,
          onSecondary: AppColors.onPrimary,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.textPrimary,
          error: AppColors.error,
        ),
        textTheme: AppTextStyles.textTheme,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.deepForest,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        extensions: [
          DesignSystemExtension.dark,
        ],
        cardTheme: CardTheme(
          color: AppColors.surfaceDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.borderDark),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.emeraldPrimary,
            foregroundColor: AppColors.onPrimary,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
        ),
      );

  // Light theme stub (Emerald Night is primarily dark-mode)
  static ThemeData get light => dark.copyWith(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        // TODO: Finalize light mode color scheme if needed
      );
}
