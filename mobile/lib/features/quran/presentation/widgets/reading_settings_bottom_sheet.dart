import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/quran/presentation/providers/reading_mode_provider.dart';

class ReadingSettingsBottomSheet extends ConsumerWidget {
  const ReadingSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingMode = ref.watch(readingModeNotifierProvider);
    const double arabicFontSize = 32.0;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1C271F), // Surface Dark
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          top: BorderSide(color: const Color(0xFF13EC5B).withValues(alpha: 0.2)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Reading Settings',
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          
          // Reading Mode Segmented Button
          Text(
            'Display Mode',
            style: GoogleFonts.manrope(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ReadingMode>(
              segments: const [
                ButtonSegment<ReadingMode>(
                  value: ReadingMode.ayah,
                  label: Text('Ayah by Ayah'),
                  icon: Icon(Icons.format_list_bulleted_rounded),
                ),
                ButtonSegment<ReadingMode>(
                  value: ReadingMode.mushaf,
                  label: Text('Mushaf'),
                  icon: Icon(Icons.auto_stories_rounded),
                ),
              ],
              selected: {readingMode},
              onSelectionChanged: (Set<ReadingMode> newSelection) {
                ref.read(readingModeNotifierProvider.notifier).setMode(newSelection.first);
              },
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: const Color(0xFF13EC5B),
                selectedForegroundColor: Colors.black,
                foregroundColor: Colors.white70,
                side: const BorderSide(color: Colors.white10),
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          // Font Size Slider
          Text(
            'Arabic Font Size',
            style: GoogleFonts.manrope(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text('A', style: GoogleFonts.amiri(color: Colors.white, fontSize: 20)),
              Expanded(
                child: Slider(
                  value: arabicFontSize,
                  min: 20,
                  max: 60,
                  activeColor: const Color(0xFF13EC5B),
                  inactiveColor: Colors.white10,
                  onChanged: (value) {
                    // TODO: Update provider state
                  },
                ),
              ),
              Text('A', style: GoogleFonts.amiri(color: Colors.white, fontSize: 40)),
            ],
          ),

          const SizedBox(height: 30),

          // Translation Selection
          Text(
            'Translation',
            style: GoogleFonts.manrope(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: 'Sahih International',
                isExpanded: true,
                dropdownColor: const Color(0xFF1C271F),
                style: GoogleFonts.manrope(color: Colors.white),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                items: ['Sahih International', 'Dr. Mustafa Khattab', 'Clear Quran']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  // TODO: Update translation provider
                },
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
