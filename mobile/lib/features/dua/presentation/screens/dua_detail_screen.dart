import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import '../../data/models/dua.dart';

class DuaDetailScreen extends StatelessWidget {
  final Dua dua;

  const DuaDetailScreen({super.key, required this.dua});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: Text(dua.title, style: AppTextStyles.h3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, color: Colors.white)),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
             Container(
               padding: const EdgeInsets.all(24),
               decoration: BoxDecoration(
                 color: AppColors.surfaceDark,
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(color: AppColors.borderDark),
               ),
               child: Column(
                 children: [
                   Text(
                     dua.arabic,
                     textAlign: TextAlign.center,
                     style: GoogleFonts.amiri(
                       fontSize: 28,
                       color: AppColors.textPrimary,
                       height: 1.8,
                     ),
                   ),
                   const SizedBox(height: 24),
                   const Divider(color: AppColors.borderDark),
                   const SizedBox(height: 24),
                   Text(
                     dua.transliteration,
                     textAlign: TextAlign.center,
                     style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                   ),
                   const SizedBox(height: 16),
                   Text(
                     dua.translation,
                     textAlign: TextAlign.center,
                     style: AppTextStyles.bodyLarge.copyWith(height: 1.5),
                   ),
                   const SizedBox(height: 24),
                   Text(
                     'Ref: ${dua.reference}',
                     style: AppTextStyles.bodySmall.copyWith(color: AppColors.emeraldPrimary),
                   )
                 ],
               ),
             )
          ],
        ),
      ),
    );
  }
}
