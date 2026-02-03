import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/quran_models.dart';
import '../../data/repositories/quran_repository.dart';

part 'reading_provider.freezed.dart';
part 'reading_provider.g.dart';

@freezed
class ReadingState with _$ReadingState {
  const factory ReadingState({
    @Default(1) int currentSurahNumber,
    @Default(0) int currentVerseIndex,
    @Default([]) List<QuranVerse> verses,
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _ReadingState;
}

@riverpod
class ReadingNotifier extends _$ReadingNotifier {
  @override
  ReadingState build() {
    return const ReadingState();
  }

  Future<void> loadSurah(int surahNumber) async {
    state = state.copyWith(isLoading: true, currentSurahNumber: surahNumber, verses: []);
    try {
      final repository = ref.read(quranRepositoryProvider);
      final verses = await repository.getVerses(surahNumber);
      state = state.copyWith(
        isLoading: false,
        verses: verses,
        currentVerseIndex: 0,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  void nextVerse() {
    if (state.verses.isEmpty) return;
    if (state.currentVerseIndex < state.verses.length - 1) {
      state = state.copyWith(currentVerseIndex: state.currentVerseIndex + 1);
    }
  }

  void prevVerse() {
    if (state.verses.isEmpty) return;
    if (state.currentVerseIndex > 0) {
      state = state.copyWith(currentVerseIndex: state.currentVerseIndex - 1);
    }
  }
  void setVerse(int index) {
    if (state.verses.isEmpty) return;
    if (index >= 0 && index < state.verses.length) {
      state = state.copyWith(currentVerseIndex: index);
    }
  }
}
