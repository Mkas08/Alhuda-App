import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary (Emerald)
  static const Color emeraldPrimary = Color(0xFF13ec5b);
  static const Color emeraldLight = Color(0xFF4ff285);
  static const Color emeraldDark = Color(0xFF0bc948);
  static const Color emeraldGlow = Color(0x4D13EC5B); // 30% opacity
  static const Color emeraldGlowStrong = Color(0x8013EC5B); // 50% opacity
  static const Color emeraldSecondary = Color(0xFF326744);

  // Accents
  static const Color gold = Color(0xFFd4af37);
  static const Color goldLight = Color(0xFFe8c963);
  static const Color orange = Color(0xFFf97316);

  // Backgrounds
  static const Color deepForest = Color(0xFF102216);
  static const Color surfaceDark = Color(0xFF1c271f);
  static const Color surfaceElevated = Color(0xFF23482f);

  // Light Backgrounds (for future use or light mode)
  static const Color backgroundLight = Color(0xFFf6f8f6);
  static const Color surfaceLight = Color(0xFFffffff);

  // Text
  static const Color textPrimary = Color(0xFFffffff);
  static const Color textSecondary = Color(0xFF9db9a6);
  static const Color textTertiary = Color(0xFF92c9a4);
  static const Color textMuted = Color(0x66FFFFFF); // 40% opacity
  static const Color onPrimary = Color(0xFF102216);

  // Semantic
  static const Color success = emeraldPrimary;
  static const Color warning = Color(0xFFf59e0b);
  static const Color error = Color(0xFFef4444);
  static const Color info = Color(0xFF3b82f6);

  // Borders
  static const Color borderDark = Color(0x0DFFFFFF); // 5% opacity
  static const Color borderAccent = Color(0xFF326744);
}
