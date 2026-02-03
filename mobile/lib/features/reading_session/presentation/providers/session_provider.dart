import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/reading_session/data/models/reading_session.dart';
import 'package:mobile/features/reading_session/data/repositories/session_repository.dart';

// State class for the session
class SessionState {
  final ReadingSession? currentSession;
  final bool isLoading;
  final String? error;
  final int elapsedTimeSeconds;
  final int versesReadInCurrentSession;

  const SessionState({
    this.currentSession,
    this.isLoading = false,
    this.error,
    this.elapsedTimeSeconds = 0,
    this.versesReadInCurrentSession = 0,
  });

  SessionState copyWith({
    ReadingSession? currentSession,
    bool? isLoading,
    String? error,
    int? elapsedTimeSeconds,
    int? versesReadInCurrentSession,
  }) {
    return SessionState(
      currentSession: currentSession ?? this.currentSession,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      elapsedTimeSeconds: elapsedTimeSeconds ?? this.elapsedTimeSeconds,
      versesReadInCurrentSession: versesReadInCurrentSession ?? this.versesReadInCurrentSession,
    );
  }
}

final StateNotifierProvider<SessionNotifier, SessionState> sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((Ref ref) {
  final SessionRepository repository = ref.watch(sessionRepositoryProvider);
  return SessionNotifier(repository);
});

class SessionNotifier extends StateNotifier<SessionState> {
  final SessionRepository _repository;
  Timer? _timer;

  SessionNotifier(this._repository) : super(const SessionState());

  bool get isActive => state.currentSession?.status == 'active';
  bool get isPaused => state.currentSession?.status == 'paused';

  Future<void> startSession() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final ReadingSession session = await _repository.startSession();
      state = state.copyWith(
        currentSession: session,
        isLoading: false,
        elapsedTimeSeconds: 0,
        versesReadInCurrentSession: 0,
      );
      _startTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> pauseSession() async {
    if (state.currentSession == null) return;
    
    _stopTimer();
    state = state.copyWith(isLoading: true, error: null);
    try {
      final ReadingSession session = await _repository.pauseSession(state.currentSession!.sessionId);
      state = state.copyWith(
        currentSession: session,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      // Resume timer if api failed? Or keep stopped?
    }
  }

  Future<void> resumeSession() async {
    if (state.currentSession == null) return;

    state = state.copyWith(isLoading: true, error: null);
    try {
      final ReadingSession session = await _repository.resumeSession(state.currentSession!.sessionId);
      state = state.copyWith(
        currentSession: session,
        isLoading: false,
      );
      _startTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> endSession() async {
    if (state.currentSession == null) return;

    _stopTimer();
    state = state.copyWith(isLoading: true, error: null);
    try {
      final ReadingSession session = await _repository.endSession(
        state.currentSession!.sessionId,
        state.versesReadInCurrentSession,
      );
      // Session ended, clear state or show completion?
      // For now, update with completed session
      state = state.copyWith(
        currentSession: session,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void incrementVersesRead() {
    state = state.copyWith(versesReadInCurrentSession: state.versesReadInCurrentSession + 1);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      state = state.copyWith(elapsedTimeSeconds: state.elapsedTimeSeconds + 1);
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
