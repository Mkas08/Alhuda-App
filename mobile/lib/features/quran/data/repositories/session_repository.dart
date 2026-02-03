import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
// quran_models.dart removed as unused

part 'session_repository.g.dart';

@riverpod
SessionRepository sessionRepository(SessionRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return SessionRepository(dio);
}

class SessionRepository {
  final Dio _dio;

  SessionRepository(this._dio);

  Future<String> startSession() async {
    final response = await _dio.post('/sessions/start');
    return response.data['session_id'];
  }

  Future<void> endSession(String sessionId, int versesRead) async {
    await _dio.post('/sessions/$sessionId/end', queryParameters: {
      'verses_read': versesRead,
    });
  }

  Future<void> logVerseRead(String sessionId, int verseId) async {
    await _dio.post('/sessions/verse_read', queryParameters: {
      'session_id': sessionId,
      'verse_id': verseId,
    });
  }
}
