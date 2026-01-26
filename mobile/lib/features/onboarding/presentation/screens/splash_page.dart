import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/features/auth/presentation/providers/auth_provider.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Simulate initialization delay & splash animation
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    final authStatus = ref.read(authProvider).status;
    
    if (authStatus == AuthStatus.authenticated) {
      context.go(RouteConstants.home); 
    } else {
      context.go(RouteConstants.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.emeraldPrimary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.emeraldGlow,
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                size: 64,
                color: AppColors.onPrimary,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'AL-HUDA',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: AppColors.emeraldPrimary,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
