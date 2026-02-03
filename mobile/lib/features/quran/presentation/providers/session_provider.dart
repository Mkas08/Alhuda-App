import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/session_repository.dart';

part 'session_provider.freezed.dart';
part 'session_provider.g.dart';

@freezed
class SessionState with _$SessionState {
  const factory SessionState({
    String? sessionId,
    @Default(false) bool isFocusMode,
    @Default(false) bool isActive,
    @Default(0) int elapsedSeconds,
    @Default(0) int versesReadSession,
    @Default(0) int hasanatEarned,
  }) = _SessionState;
}

@riverpod
class SessionNotifier extends _$SessionNotifier {
  Timer? _timer;

  @override
  SessionState build() {
    // Check for focus mode trigger on initialization
    _checkFocusTrigger();
    return const SessionState();
  }

  void _checkFocusTrigger() {
    // TODO: Fetch user goals and check preferred times
    // For now, we simulate check or default to false
    // Logic: If user has a goal scheduled within +/- 30 mins, set isFocusMode = true
  }

  Future<void> startSession({bool forceFocus = false}) async {
    try {
      final repository = ref.read(sessionRepositoryProvider);
      final sessionId = await repository.startSession();
      
      state = state.copyWith(
        sessionId: sessionId,
        isActive: true, 
        isFocusMode: forceFocus || state.isFocusMode,
      );
      _startTimer();
    } catch (e) {
      // TODO: Handle session start error (e.g. show dialog)
    }
  }

  void pauseSession() {
    state = state.copyWith(isActive: false);
    _timer?.cancel();
  }

  void resumeSession() {
    state = state.copyWith(isActive: true);
    _startTimer();
  }

  Future<void> endSession() async {
    _timer?.cancel();
    final sessionId = state.sessionId;
    if (sessionId != null) {
      try {
        final repository = ref.read(sessionRepositoryProvider);
        await repository.endSession(sessionId, state.versesReadSession);
      } catch (_) {
        // TODO: Handle sync error (retry or local log)
      }
    }
    state = const SessionState(); // Reset
  }

  void incrementVersesRead({int? verseId, int letterCount = 0}) {
    if (state.isActive) {
      state = state.copyWith(
        versesReadSession: state.versesReadSession + 1,
        hasanatEarned: state.hasanatEarned + (letterCount * 10),
      );
      
      // Optionally log verse read immediately
      final sessionId = state.sessionId;
      if (sessionId != null && verseId != null) {
        ref.read(sessionRepositoryProvider).logVerseRead(sessionId, verseId);
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    });
  }
}
