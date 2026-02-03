import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/reading_session/presentation/providers/session_provider.dart';

class SessionControlsWidget extends ConsumerWidget {
  const SessionControlsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SessionNotifier notifier = ref.read(sessionProvider.notifier);
    final bool isPaused = ref.watch(sessionProvider.notifier).isPaused;
    final bool isLoading = ref.watch(sessionProvider).isLoading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Stop/End Button
        _buildCircleButton(
          onTap: () => notifier.endSession(),
          icon: Icons.stop_rounded,
          color: const Color(0xFFEF4444), // semantic.error
          label: 'End',
        ),
        const SizedBox(width: 32),
        
        // Play/Pause Button (Main)
        if (isLoading)
          const CircularProgressIndicator(color: Color(0xFF13EC5B))
        else
          GestureDetector(
            onTap: isPaused ? notifier.resumeSession : notifier.pauseSession,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF13EC5B), // primary.main
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: const Color(0xFF13EC5B).withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Icon(
                isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                color: const Color(0xFF102216), // text.onPrimary
                size: 36,
              ),
            ),
          ),
          
        const SizedBox(width: 32),
        
        // Placeholder for Settings or Verse Mode (Future)
        _buildCircleButton(
          onTap: () {}, // Future feature
          icon: Icons.settings_voice_rounded,
          color: const Color(0xFF9DB9A6).withValues(alpha: 0.2), // text.secondary dim
          iconColor: const Color(0xFF9DB9A6),
          label: 'Mode',
        ),
      ],
    );
  }

  Widget _buildCircleButton({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    Color? iconColor,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
            ),
            child: Icon(
              icon,
              color: iconColor ?? color,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.manrope(
            color: const Color(0xFF9DB9A6),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
