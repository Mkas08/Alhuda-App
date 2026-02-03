import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/network/dio_client.dart';
import 'package:mobile/features/reading_session/data/models/reading_session.dart';

final Provider<SessionRepository> sessionRepositoryProvider = Provider<SessionRepository>((Ref ref) {
  final Dio dio = ref.watch(dioProvider);
  return SessionRepository(dio);
});

class SessionRepository {
  final Dio _dio;

  SessionRepository(this._dio);

  Future<ReadingSession> startSession() async {
    try {
      final Response<dynamic> response = await _dio.post('/sessions/start');
      return ReadingSession.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<ReadingSession> pauseSession(String sessionId) async {
    try {
      final Response<dynamic> response = await _dio.patch('/sessions/$sessionId/pause');
      return ReadingSession.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<ReadingSession> resumeSession(String sessionId) async {
    try {
      final Response<dynamic> response = await _dio.patch('/sessions/$sessionId/resume');
      return ReadingSession.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<ReadingSession> endSession(String sessionId, int versesRead) async {
    try {
      final Response<dynamic> response = await _dio.post(
        '/sessions/$sessionId/end',
        queryParameters: <String, dynamic>{'verses_read': versesRead}, 
      );
      return ReadingSession.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReadingSession>> getSessions() async {
    try {
      final Response<dynamic> response = await _dio.get('/sessions/');
      final List<dynamic> list = response.data as List<dynamic>;
      return list.map((dynamic e) => ReadingSession.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
