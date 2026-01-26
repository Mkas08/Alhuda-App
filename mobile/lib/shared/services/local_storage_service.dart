import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String settingsBox = 'settings';
  static const String quranCacheBox = 'quran_cache';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBox);
    await Hive.openBox(quranCacheBox);
  }

  // Generic helpers
  Future<void> put(String boxName, String key, dynamic value) async {
    final Box box = Hive.box(boxName);
    await box.put(key, value);
  }

  dynamic get(String boxName, String key) {
    final Box box = Hive.box(boxName);
    return box.get(key);
  }

  Future<void> delete(String boxName, String key) async {
    final Box box = Hive.box(boxName);
    await box.delete(key);
  }

  Future<void> clear(String boxName) async {
    final Box box = Hive.box(boxName);
    await box.clear();
  }
}
