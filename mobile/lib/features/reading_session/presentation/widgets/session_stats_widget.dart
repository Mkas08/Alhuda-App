import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/features/reading_session/presentation/providers/session_provider.dart';

class SessionStatsWidget extends ConsumerWidget {
  const SessionStatsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SessionState sessionState = ref.watch(sessionProvider);
    // Rough estimate for hasanat if not fetched live: verses * 50 letters * 10 hasanat
    // Ideally we fetch from backend or just show verses for now locally.
    // Let's show Verses Read.
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildStatItem(
          label: 'Verses',
          value: '${sessionState.versesReadInCurrentSession}',
          icon: Icons.menu_book_rounded,
        ),
        const SizedBox(width: 24),
        Container(width: 1, height: 30, color: const Color(0xFFFFFFFF).withValues(alpha: 0.1)),
        const SizedBox(width: 24),
        _buildStatItem(
          label: 'Hasanat',
          value: '${sessionState.versesReadInCurrentSession * 500}', // Approx placeholder
          icon: Icons.auto_awesome_rounded,
          isGold: true,
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    bool isGold = false,
  }) {
    final Color color = isGold ? const Color(0xFFD4AF37) : const Color(0xFF13EC5B); // accent.gold or primary.main
    
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              value,
              style: GoogleFonts.lexend(
                color: const Color(0xFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.manrope(
            color: const Color(0xFF9DB9A6), // text.secondary
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
