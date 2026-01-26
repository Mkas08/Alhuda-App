import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app.dart';
import 'package:mobile/shared/services/local_storage_service.dart';

// Providers for global services
final localStorageProvider = Provider<LocalStorageService>((ref) => LocalStorageService());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Local Storage (Hive)
  final LocalStorageService localStorage = LocalStorageService();
  await localStorage.init();

  // TODO: Initialize Sentry (Phase 1.4 placeholder)

  runApp(
    ProviderScope(
      overrides: [
        localStorageProvider.overrideWithValue(localStorage),
      ],
      child: const AlHudaApp(),
    ),
  );
}
