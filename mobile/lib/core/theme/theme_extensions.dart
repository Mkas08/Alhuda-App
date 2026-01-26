import 'package:flutter/material.dart';
import 'package:mobile/core/theme/colors.dart';

class DesignSystemExtension extends ThemeExtension<DesignSystemExtension> {
  final Color emeraldGlow;
  final Color emeraldGlowStrong;
  final Color surfaceElevated;
  final BoxShadow primaryShadow;
  final BoxShadow primaryGlow;

  const DesignSystemExtension({
    required this.emeraldGlow,
    required this.emeraldGlowStrong,
    required this.surfaceElevated,
    required this.primaryShadow,
    required this.primaryGlow,
  });

  @override
  DesignSystemExtension copyWith({
    Color? emeraldGlow,
    Color? emeraldGlowStrong,
    Color? surfaceElevated,
    BoxShadow? primaryShadow,
    BoxShadow? primaryGlow,
  }) {
    return DesignSystemExtension(
      emeraldGlow: emeraldGlow ?? this.emeraldGlow,
      emeraldGlowStrong: emeraldGlowStrong ?? this.emeraldGlowStrong,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      primaryShadow: primaryShadow ?? this.primaryShadow,
      primaryGlow: primaryGlow ?? this.primaryGlow,
    );
  }

  @override
  DesignSystemExtension lerp(ThemeExtension<DesignSystemExtension>? other, double t) {
    if (other is! DesignSystemExtension) return this;
    return DesignSystemExtension(
      emeraldGlow: Color.lerp(emeraldGlow, other.emeraldGlow, t)!,
      emeraldGlowStrong: Color.lerp(emeraldGlowStrong, other.emeraldGlowStrong, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      primaryShadow: BoxShadow.lerp(primaryShadow, other.primaryShadow, t)!,
      primaryGlow: BoxShadow.lerp(primaryGlow, other.primaryGlow, t)!,
    );
  }

  static const dark = DesignSystemExtension(
    emeraldGlow: AppColors.emeraldGlow,
    emeraldGlowStrong: AppColors.emeraldGlowStrong,
    surfaceElevated: AppColors.surfaceElevated,
    primaryShadow: BoxShadow(
      color: Colors.black26,
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
    primaryGlow: BoxShadow(
      color: AppColors.emeraldGlow,
      blurRadius: 15,
      spreadRadius: 2,
    ),
  );
}

extension DesignSystemContext on BuildContext {
  DesignSystemExtension get designSystem => Theme.of(this).extension<DesignSystemExtension>()!;
}
