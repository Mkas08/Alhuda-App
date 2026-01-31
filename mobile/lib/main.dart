import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile/app.dart';
import 'package:mobile/shared/services/local_storage_service.dart';

// Providers for global services
final Provider<LocalStorageService> localStorageProvider =
    Provider<LocalStorageService>((Ref ref) => LocalStorageService());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open boxes
  await Hive.openBox<dynamic>(LocalStorageService.authBox);
  await Hive.openBox<dynamic>(LocalStorageService.settingsBox);

  // TODO: Initialize Sentry (Phase 1.4 placeholder)

  runApp(const ProviderScope(child: AlHudaApp()));
}
