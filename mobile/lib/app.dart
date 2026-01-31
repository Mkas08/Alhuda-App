import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/config/routes/app_router.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/shared/services/language_provider.dart';

class AlHudaApp extends ConsumerWidget {
  const AlHudaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLanguage currentLanguage = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'Al-Huda',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark, // Default to Emerald Night dark mode
      routerConfig: appRouter,
      locale: currentLanguage.locale,
    );
  }
}
