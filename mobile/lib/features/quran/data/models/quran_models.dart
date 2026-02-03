import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_models.freezed.dart';
part 'quran_models.g.dart';

@freezed
class QuranSurah with _$QuranSurah {
  const factory QuranSurah({
    @JsonKey(name: 'surah_number') required int number,
    @JsonKey(name: 'name_arabic') required String nameArabic,
    @JsonKey(name: 'name_complex') required String nameComplex,
    @JsonKey(name: 'name_english') required String nameEnglish,
    @JsonKey(name: 'verses_count') required int versesCount,
    @JsonKey(name: 'revelation_place') required String revelationPlace,
  }) = _QuranSurah;

  factory QuranSurah.fromJson(Map<String, dynamic> json) =>
      _$QuranSurahFromJson(json);
}

@freezed
class QuranVerse with _$QuranVerse {
  const factory QuranVerse({
    @JsonKey(name: 'verse_id') required int id,
    @JsonKey(name: 'surah_number') required int surahNumber,
    @JsonKey(name: 'verse_number') required int verseNumber,
    @JsonKey(name: 'arabic_text') required String textUthmanic,
    @JsonKey(name: 'simple_text') String? textSimple,
    @JsonKey(name: 'letter_count') @Default(0) int letterCount,
    @JsonKey(name: 'has_sajdah') @Default(false) bool hasSajdah,
    @JsonKey(name: 'translations') @Default([]) List<QuranTranslation> translations,
  }) = _QuranVerse;

  factory QuranVerse.fromJson(Map<String, dynamic> json) =>
      _$QuranVerseFromJson(json);
}

@freezed
class QuranTranslation with _$QuranTranslation {
  const factory QuranTranslation({
    @JsonKey(name: 'translation_id') required int id,
    @JsonKey(name: 'language') required String language,
    @JsonKey(name: 'translator_name') required String translatorName,
    @JsonKey(name: 'translation_text') required String text,
  }) = _QuranTranslation;

  factory QuranTranslation.fromJson(Map<String, dynamic> json) =>
      _$QuranTranslationFromJson(json);
}
