import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/quran/presentation/providers/reading_provider.dart';
import 'package:mobile/features/quran/presentation/widgets/verse_card.dart';
import 'package:mobile/features/quran/presentation/providers/session_provider.dart';
import 'package:mobile/features/quran/presentation/widgets/sajdah_overlay.dart';

class AyahReadingScreen extends ConsumerWidget {
  final PageController pageController;

  const AyahReadingScreen({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readingState = ref.watch(readingNotifierProvider);

    if (readingState.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF13EC5B)));
    }

    if (readingState.isError) {
      return Center(
        child: Text(
          'Error: ${readingState.errorMessage}',
          style: const TextStyle(color: Colors.white),
        ),
      );
    }

    return PageView.builder(
      controller: pageController,
      itemCount: readingState.verses.length,
      onPageChanged: (index) {
        final verse = readingState.verses[index];
        ref.read(sessionNotifierProvider.notifier).incrementVersesRead(
          verseId: verse.id,
          letterCount: verse.letterCount,
        );
        
        if (verse.hasSajdah) {
           _showSajdahOverlay(context);
        }
      },
      itemBuilder: (context, index) {
        final verse = readingState.verses[index];
        return VerseCard(
          verse: verse,
          onBookmark: () {
            // TODO: Implement bookmark
          },
          onShare: () {
            // TODO: Implement share
          },
        );
      },
    );
  }

  void _showSajdahOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => SajdahOverlay(
        onDismiss: () => Navigator.of(context).pop(),
      ),
    );
  }
}
