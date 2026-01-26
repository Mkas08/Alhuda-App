import 'package:flutter/material.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/theme_extensions.dart';

class EmeraldButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSecondary;

  const EmeraldButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: !isSecondary && onPressed != null
            ? [ds.primaryGlow]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.transparent : AppColors.emeraldPrimary,
          foregroundColor: isSecondary ? AppColors.emeraldPrimary : AppColors.onPrimary,
          elevation: 0,
          side: isSecondary ? const BorderSide(color: AppColors.emeraldPrimary, width: 2) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isSecondary ? AppColors.emeraldPrimary : AppColors.onPrimary,
                ),
              )
            : Text(
                label.toUpperCase(),
                style: const TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}
