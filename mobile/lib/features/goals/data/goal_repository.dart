import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/goals/domain/entities/goal.dart';
import 'package:mobile/features/goals/domain/entities/user_stats.dart';
import 'package:mobile/features/goals/domain/entities/bookmark.dart';

final Provider<GoalRepository> goalRepositoryProvider = Provider<GoalRepository>((Ref ref) {
  final Dio dio = ref.watch(dioProvider);
  return GoalRepository(dio);
});

class GoalRepository {
  final Dio _dio;

  GoalRepository(this._dio);

  Future<Goal> getActiveGoal() async {
    final Response<dynamic> response = await _dio.get<dynamic>('/goals/');
    return Goal.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Goal> createGoal({
    required String goalType,
    required int goalValue,
    List<String> preferredTimes = const <String>[],
  }) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      '/goals/',
      data: <String, dynamic>{
        'goal_type': goalType,
        'goal_value': goalValue,
        'preferred_times': preferredTimes,
      },
    );
    return Goal.fromJson(response.data as Map<String, dynamic>);
  }

  Future<UserProgress> getProgressSummary() async {
    final Response<dynamic> response = await _dio.get<dynamic>('/progress/');
    return UserProgress.fromJson(response.data as Map<String, dynamic>);
  }

  Future<UserStats> updateProgress(int verseId, {String? sessionId}) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      '/progress/update',
      data: <String, dynamic>{
        'verse_id': verseId,
        if (sessionId != null) 'session_id': sessionId,
      },
    );
    return UserStats.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<Bookmark>> getBookmarks() async {
    final Response<dynamic> response = await _dio.get<dynamic>('/progress/bookmarks');
    return (response.data as List<dynamic>)
        .map((dynamic e) => Bookmark.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Bookmark> addBookmark(int verseId, {String? note}) async {
    final Response<dynamic> response = await _dio.post<dynamic>(
      '/progress/bookmarks',
      data: <String, dynamic>{
        'verse_id': verseId,
        if (note != null) 'note': note,
      },
    );
    return Bookmark.fromJson(response.data as Map<String, dynamic>);
  }

  Future<void> deleteBookmark(String bookmarkId) async {
    await _dio.delete<dynamic>('/progress/bookmarks/$bookmarkId');
  }
}
