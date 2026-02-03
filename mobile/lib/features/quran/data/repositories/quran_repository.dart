import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/dio_client.dart';
import '../models/quran_models.dart';

part 'quran_repository.g.dart';

@riverpod
QuranRepository quranRepository(QuranRepositoryRef ref) {
  // By default returns the API implementation
  // This can be overridden in ProviderScope for testing
  final dio = ref.watch(dioProvider);
  return ApiQuranRepository(dio);
}

abstract class QuranRepository {
  Future<List<QuranSurah>> getSurahs();
  Future<QuranSurah> getSurahDetail(int surahNumber);
  Future<List<QuranVerse>> getVerses(int surahNumber);
}

class ApiQuranRepository implements QuranRepository {
  final Dio _dio;

  ApiQuranRepository(this._dio);

  @override
  Future<List<QuranSurah>> getSurahs() async {
    final response = await _dio.get('/quran/surahs');
    final data = response.data as List;
    return data.map((e) => QuranSurah.fromJson(e)).toList();
  }

  @override
  Future<QuranSurah> getSurahDetail(int surahNumber) async {
    final response = await _dio.get('/quran/surah/$surahNumber', queryParameters: {
      'include_verses': true,
    });
    return QuranSurah.fromJson(response.data);
  }

  @override
  Future<List<QuranVerse>> getVerses(int surahNumber) async {
    final response = await _dio.get('/quran/surah/$surahNumber', queryParameters: {
      'include_verses': true,
      'limit': 286,
    });
    
    final surahData = response.data;
    final versesList = surahData['verses'] as List;
    return versesList.map((e) => QuranVerse.fromJson(e)).toList();
  }
}
