import 'package:flutter/material.dart';
import 'package:konveksio_app/core/theme/app_theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
            Icon(
              PhosphorIcons.factory(PhosphorIconsStyle.fill),
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
