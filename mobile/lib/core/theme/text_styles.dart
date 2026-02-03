import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/theme/colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Font Families
  static String? get displayFont => GoogleFonts.lexend().fontFamily;
  static String? get bodyFont => GoogleFonts.manrope().fontFamily;
  static String? get arabicFont => GoogleFonts.notoSansArabic().fontFamily;

  // Light/Dark Theme specific adjustments can be made here
  static TextStyle get h1 => textTheme.displayLarge!;
  static TextStyle get h2 => textTheme.displayMedium!;
  static TextStyle get h3 => textTheme.displaySmall!;
  static TextStyle get bodyLarge => textTheme.bodyLarge!;
  static TextStyle get bodyMedium => textTheme.bodyMedium!;
  static TextStyle get bodySmall => textTheme.bodySmall!;
  static TextStyle get labelLarge => textTheme.labelLarge!;
  static TextStyle get labelMedium => textTheme.labelMedium!;
  static TextStyle get labelSmall => textTheme.labelSmall!;

  // Arabic Ayah Style
  static TextStyle get arabicAyah => GoogleFonts.notoSansArabic(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.8,
    color: AppColors.textPrimary,
  );

  static TextTheme get textTheme => TextTheme(
    displayLarge: GoogleFonts.lexend(fontSize: 48, fontWeight: FontWeight.w800),
    displayMedium: GoogleFonts.lexend(
      fontSize: 36,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.lexend(fontSize: 24, fontWeight: FontWeight.w600),
    headlineLarge: GoogleFonts.lexend(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.lexend(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.lexend(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.w600),
    titleMedium: GoogleFonts.lexend(fontSize: 16, fontWeight: FontWeight.w500),
    titleSmall: GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
    labelMedium: GoogleFonts.manrope(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: GoogleFonts.manrope(fontSize: 10, fontWeight: FontWeight.w500),
  );
}
