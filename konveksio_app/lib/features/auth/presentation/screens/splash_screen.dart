import 'package:flutter/material.dart';
import 'package:konveksio_app/core/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.factory,
              size: 80,
              color: AppTheme.onPrimary,
            ),
            const SizedBox(height: AppTheme.spaceMd),
            const CircularProgressIndicator(
              color: AppTheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
