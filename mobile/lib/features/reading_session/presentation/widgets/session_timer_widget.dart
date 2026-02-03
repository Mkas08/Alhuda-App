import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/reading_session/presentation/providers/session_provider.dart';

class SessionTimerWidget extends ConsumerWidget {
  const SessionTimerWidget({super.key});

  String _formatTime(int totalSeconds) {
    final int minutes = totalSeconds ~/ 60;
    final int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SessionState sessionState = ref.watch(sessionProvider);
    final bool isPaused = ref.watch(sessionProvider.notifier).isPaused;
    
    // Brand Colors (Emerald Night)
    // primary: #13ec5b
    // text: #ffffff
    // background: #102216
    // surface: #1c271f
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C271F), // surface.dark
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPaused 
            ? const Color(0xFFF59E0B) // warning for pause
            : const Color(0xFF13EC5B).withValues(alpha: 0.3), // primary.glow
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF13EC5B).withValues(alpha: 0.05),
            blurRadius: 15,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Session Duration',
            style: GoogleFonts.manrope(
              color: const Color(0xFF9DB9A6), // text.secondary
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _formatTime(sessionState.elapsedTimeSeconds),
            style: GoogleFonts.lexend( // Display font
              color: isPaused ? const Color(0xFFF59E0B) : const Color(0xFFFFFFFF),
              fontSize: 36,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          if (isPaused)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'PAUSED',
                style: GoogleFonts.manrope(
                  color: const Color(0xFFF59E0B),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
