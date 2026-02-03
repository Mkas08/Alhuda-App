// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuranSurahImpl _$$QuranSurahImplFromJson(Map<String, dynamic> json) =>
    _$QuranSurahImpl(
      number: (json['surah_number'] as num).toInt(),
      nameArabic: json['name_arabic'] as String,
      nameComplex: json['name_complex'] as String,
      nameEnglish: json['name_english'] as String,
      versesCount: (json['verses_count'] as num).toInt(),
      revelationPlace: json['revelation_place'] as String,
    );

Map<String, dynamic> _$$QuranSurahImplToJson(_$QuranSurahImpl instance) =>
    <String, dynamic>{
      'surah_number': instance.number,
      'name_arabic': instance.nameArabic,
      'name_complex': instance.nameComplex,
      'name_english': instance.nameEnglish,
      'verses_count': instance.versesCount,
      'revelation_place': instance.revelationPlace,
    };

_$QuranVerseImpl _$$QuranVerseImplFromJson(Map<String, dynamic> json) =>
    _$QuranVerseImpl(
      id: (json['verse_id'] as num).toInt(),
      surahNumber: (json['surah_number'] as num).toInt(),
      verseNumber: (json['verse_number'] as num).toInt(),
      textUthmanic: json['arabic_text'] as String,
      textSimple: json['simple_text'] as String?,
      letterCount: (json['letter_count'] as num?)?.toInt() ?? 0,
      hasSajdah: json['has_sajdah'] as bool? ?? false,
      translations: (json['translations'] as List<dynamic>?)
              ?.map((e) => QuranTranslation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$QuranVerseImplToJson(_$QuranVerseImpl instance) =>
    <String, dynamic>{
      'verse_id': instance.id,
      'surah_number': instance.surahNumber,
      'verse_number': instance.verseNumber,
      'arabic_text': instance.textUthmanic,
      'simple_text': instance.textSimple,
      'letter_count': instance.letterCount,
      'has_sajdah': instance.hasSajdah,
      'translations': instance.translations,
    };

_$QuranTranslationImpl _$$QuranTranslationImplFromJson(
        Map<String, dynamic> json) =>
    _$QuranTranslationImpl(
      id: (json['translation_id'] as num).toInt(),
      language: json['language'] as String,
      translatorName: json['translator_name'] as String,
      text: json['translation_text'] as String,
    );

Map<String, dynamic> _$$QuranTranslationImplToJson(
        _$QuranTranslationImpl instance) =>
    <String, dynamic>{
      'translation_id': instance.id,
      'language': instance.language,
      'translator_name': instance.translatorName,
      'translation_text': instance.text,
    };
