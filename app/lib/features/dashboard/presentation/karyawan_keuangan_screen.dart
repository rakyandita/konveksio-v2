import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class KaryawanKeuanganScreen extends StatelessWidget {
  const KaryawanKeuanganScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keuangan'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        child: Text(
          'Fitur Keuangan (Kasbon & Slip Gaji) akan datang',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppTheme.muted),
        ),
      ),
    );
  }
}
