import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://e839cb985edca237e05ccfe7ae1d9d14@o4510681530630144.ingest.de.sentry.io/4510681554747472';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: AlHudaApp(),
      ),
    ),
  );
}

class AlHudaApp extends StatelessWidget {
  const AlHudaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Huda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF13ec5b)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Nurture your soul, one ayah at a time.'),
        ),
      ),
    );
  }
}
