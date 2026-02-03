import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/quran/data/models/quran_models.dart';

class VerseCard extends StatelessWidget {
  final QuranVerse verse;
  final VoidCallback onBookmark;
  final VoidCallback onShare;

  const VerseCard({
    super.key,
    required this.verse,
    required this.onBookmark,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.borderDark),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    verse.verseNumber.toString(),
                    style: GoogleFonts.lexend(
                      color: AppColors.emeraldPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.bookmark_border, color: AppColors.textSecondary, size: 22),
                    onPressed: onBookmark,
                  ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined, color: AppColors.textSecondary, size: 22),
                    onPressed: onShare,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            verse.textUthmanic,
            textAlign: TextAlign.center,
            style: GoogleFonts.amiri(
              color: AppColors.textPrimary,
              fontSize: 28,
              height: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.borderDark),
          const SizedBox(height: 24),
          Text(
            verse.translations.isNotEmpty ? verse.translations.first.text : 'No translation available',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
