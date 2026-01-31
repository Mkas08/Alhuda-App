import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String settingsBox = 'settings';
  static const String quranCacheBox = 'quran_cache';
  static const String authBox = 'auth';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBox);
    await Hive.openBox(quranCacheBox);
  }

  // Generic helpers
  String? get(String boxName, String key) {
    final Box<dynamic> box = Hive.box<dynamic>(boxName);
    return box.get(key) as String?;
  }

  Future<void> put(String boxName, String key, String value) async {
    final Box<dynamic> box = Hive.box<dynamic>(boxName);
    await box.put(key, value);
  }

  Future<void> delete(String boxName, String key) async {
    final Box<dynamic> box = Hive.box<dynamic>(boxName);
    await box.delete(key);
  }

  Future<void> clear(String boxName) async {
    final Box<dynamic> box = Hive.box<dynamic>(boxName);
    await box.clear();
  }
}
