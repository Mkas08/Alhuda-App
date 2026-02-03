import 'package:mobile/features/quran/data/models/quran_models.dart';
import 'package:mobile/features/quran/data/repositories/quran_repository.dart';
import 'package:mobile/shared/services/mock_data_service.dart';

class MockQuranRepository implements QuranRepository {
  final MockDataService _mockDataService = MockDataService();

  @override
  Future<List<QuranSurah>> getSurahs() {
    return _mockDataService.getSurahs();
  }

  @override
  Future<QuranSurah> getSurahDetail(int surahNumber) async {
    final surahs = await _mockDataService.getSurahs();
    return surahs.firstWhere((s) => s.number == surahNumber);
  }

  @override
  Future<List<QuranVerse>> getVerses(int surahNumber) async {
    return List.generate(10, (index) {
      const text = 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';
      return QuranVerse(
        id: index + 1,
        surahNumber: surahNumber,
        verseNumber: index + 1,
        textUthmanic: text,
        letterCount: text.length, // Simple mock
        hasSajdah: (index + 1) == 5, // Mark 5th verse as Sajdah for testing
        translations: [
          const QuranTranslation(
            id: 1, 
            language: 'en', 
            translatorName: 'Saheeh International', 
            text: 'In the name of Allah, the Entirely Merciful, the Especially Merciful.',
          ),
        ],
      );
    });
  }
}
