import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import '../providers/reading_provider.dart';
import '../providers/session_provider.dart';
import '../widgets/session_timer_overlay.dart';
import '../widgets/reading_settings_bottom_sheet.dart';
import 'ayah_reading_screen.dart';
import 'mushaf_reading_screen.dart';
import '../providers/reading_mode_provider.dart';

class ReadingScreen extends ConsumerStatefulWidget {
  final int surahNumber;
  final int verseNumber;

  const ReadingScreen({
    super.key,
    required this.surahNumber,
    required this.verseNumber,
  });

  @override
  ConsumerState<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends ConsumerState<ReadingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(readingNotifierProvider.notifier).loadSurah(widget.surahNumber);
      ref.read(sessionNotifierProvider.notifier).startSession();
      
      // Auto-resume to requested verse
      if (widget.verseNumber > 1) {
         // Tiny delay to ensure controller is attached and state loaded
         Future.delayed(const Duration(milliseconds: 100), () {
           if (mounted) {
             _pageController.jumpToPage(widget.verseNumber - 1);
             ref.read(readingNotifierProvider.notifier).setVerse(widget.verseNumber - 1);
           }
         });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readingState = ref.watch(readingNotifierProvider);
    final readingMode = ref.watch(readingModeNotifierProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFF102216), // Deep Forest
      body: Stack(
        children: [
          Column(
            children: [
              // Custom App Bar
              SafeArea(
                bottom: false,
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () async {
                          final sessionState = ref.read(sessionNotifierProvider);
                          if (sessionState.versesReadSession > 0) {
                            final stats = {
                              'versesRead': sessionState.versesReadSession,
                              'hasanatEarned': sessionState.hasanatEarned,
                              'durationSeconds': sessionState.elapsedSeconds,
                            };
                            await ref.read(sessionNotifierProvider.notifier).endSession();
                            if (context.mounted) {
                              context.pushReplacement(RouteConstants.sessionCompletion, extra: stats);
                            }
                          } else {
                            await ref.read(sessionNotifierProvider.notifier).endSession();
                            if (context.mounted) context.pop();
                          }
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Surah ${widget.surahNumber}',
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF13EC5B), // Emerald Primary
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            readingMode == ReadingMode.ayah 
                                ? 'Verse ${readingState.currentVerseIndex + 1}'
                                : 'Page View',
                            style: GoogleFonts.manrope(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            tooltip: readingMode == ReadingMode.ayah ? 'Switch to Mushaf' : 'Switch to Ayah View',
                            icon: Icon(
                              readingMode == ReadingMode.ayah ? Icons.auto_stories : Icons.menu_book, 
                              color: Colors.white
                            ),
                            onPressed: () {
                              ref.read(readingModeNotifierProvider.notifier).toggle();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.settings_outlined, color: Colors.white),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) => const ReadingSettingsBottomSheet(),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Content
              Expanded(
                child: readingMode == ReadingMode.ayah
                    ? AyahReadingScreen(pageController: _pageController)
                    : const MushafReadingScreen(),
              ),

              // Bottom Controls (Only for Ayah mode for now)
              if (readingMode == ReadingMode.ayah)
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black87, Colors.transparent],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _NavButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          ref.read(readingNotifierProvider.notifier).prevVerse();
                        },
                      ),
                      
                      // Progress Text in middle instead of Play Button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C271F),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Verse ${readingState.currentVerseIndex + 1} of ${readingState.verses.isEmpty ? '...' : readingState.verses.length}',
                          style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),

                      _NavButton(
                        icon: Icons.arrow_forward_ios,
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          ref.read(readingNotifierProvider.notifier).nextVerse();
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // Overlays
          const SessionTimerOverlay(),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xFF1C271F), // Surface Dark
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20),
        onPressed: onTap,
      ),
    );
  }
}

