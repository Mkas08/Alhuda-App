import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/goals/data/goal_repository.dart';
import 'package:mobile/features/goals/domain/entities/goal.dart';
import 'package:mobile/features/goals/domain/entities/user_stats.dart';
import 'package:mobile/features/goals/domain/entities/bookmark.dart';
import 'package:mobile/core/error/network_exceptions.dart';

class GoalState {
  final Goal? activeGoal;
  final UserStats? stats;
  final List<Bookmark> bookmarks;
  final double completionPercentage;
  final bool isLoading;
  final String? errorMessage;

  GoalState({
    this.activeGoal,
    this.stats,
    this.bookmarks = const <Bookmark>[],
    this.completionPercentage = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  GoalState copyWith({
    Goal? activeGoal,
    UserStats? stats,
    List<Bookmark>? bookmarks,
    double? completionPercentage,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GoalState(
      activeGoal: activeGoal ?? this.activeGoal,
      stats: stats ?? this.stats,
      bookmarks: bookmarks ?? this.bookmarks,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class GoalNotifier extends StateNotifier<GoalState> {
  final GoalRepository _repository;

  GoalNotifier(this._repository) : super(GoalState()) {
    refreshProgress();
    refreshBookmarks();
  }

  Future<void> refreshProgress() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final UserProgress progress = await _repository.getProgressSummary();
      state = state.copyWith(
        activeGoal: progress.activeGoal,
        stats: progress.stats,
        completionPercentage: progress.completionPercentage,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: NetworkExceptions.getErrorMessage(e),
      );
    }
  }

  Future<void> createGoal({
    required String goalType,
    required int goalValue,
    List<String> preferredTimes = const <String>[],
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final Goal goal = await _repository.createGoal(
        goalType: goalType,
        goalValue: goalValue,
        preferredTimes: preferredTimes,
      );
      state = state.copyWith(activeGoal: goal, isLoading: false);
      // Also refresh stats to get latest summary
      await refreshProgress();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: NetworkExceptions.getErrorMessage(e),
      );
    }
  }

  Future<void> markVerseAsRead(int verseId) async {
    // We don't necessarily want to set global loading for a single verse mark
    try {
      final UserStats stats = await _repository.updateProgress(verseId);
      state = state.copyWith(stats: stats);
      // We might want to recalculate completion percentage locally if we don't refresh
      // or just refresh periodically.
    } catch (e) {
      state = state.copyWith(errorMessage: NetworkExceptions.getErrorMessage(e));
    }
  }

  Future<void> refreshBookmarks() async {
    try {
      final List<Bookmark> bookmarks = await _repository.getBookmarks();
      state = state.copyWith(bookmarks: bookmarks);
    } catch (e) {
      state = state.copyWith(errorMessage: NetworkExceptions.getErrorMessage(e));
    }
  }

  Future<void> addBookmark(int verseId, {String? note}) async {
    try {
      await _repository.addBookmark(verseId, note: note);
      await refreshBookmarks();
    } catch (e) {
      state = state.copyWith(errorMessage: NetworkExceptions.getErrorMessage(e));
    }
  }

  Future<void> removeBookmark(String bookmarkId) async {
    try {
      await _repository.deleteBookmark(bookmarkId);
      await refreshBookmarks();
    } catch (e) {
      state = state.copyWith(errorMessage: NetworkExceptions.getErrorMessage(e));
    }
  }
}

final StateNotifierProvider<GoalNotifier, GoalState> goalProvider =
    StateNotifierProvider<GoalNotifier, GoalState>((Ref ref) {
  final GoalRepository repository = ref.watch(goalRepositoryProvider);
  return GoalNotifier(repository);
});
