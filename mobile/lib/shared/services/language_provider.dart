import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/main.dart';
import 'package:mobile/shared/services/local_storage_service.dart';

enum AppLanguage {
  english(Locale('en'), 'English'),
  arabic(Locale('ar'), 'العربية');

  final Locale locale;
  final String label;
  const AppLanguage(this.locale, this.label);
}

class LanguageNotifier extends StateNotifier<AppLanguage> {
  final LocalStorageService _storage;

  LanguageNotifier(this._storage) : super(AppLanguage.english) {
    _loadInitial();
  }

  void _loadInitial() {
    final code = _storage.get(LocalStorageService.settingsBox, 'language_code');
    if (code != null) {
      state = AppLanguage.values.firstWhere(
        (l) => l.locale.languageCode == code,
        orElse: () => AppLanguage.english,
      );
    }
  }

  Future<void> setLanguage(AppLanguage language) async {
    state = language;
    await _storage.put(
      LocalStorageService.settingsBox,
      'language_code',
      language.locale.languageCode,
    );
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, AppLanguage>((ref) {
  return LanguageNotifier(ref.watch(localStorageProvider));
});
