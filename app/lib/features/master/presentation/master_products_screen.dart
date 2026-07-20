import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';

class MasterProductsScreen extends StatelessWidget {
  const MasterProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockProducts = [
      {'name': 'Kemeja PDL', 'category': 'Kemeja', 'price': 'Rp 150.000'},
      {'name': 'Kaos Polo', 'category': 'Kaos', 'price': 'Rp 85.000'},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: () {},
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.onPrimary),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingBase),
        itemCount: mockProducts.length,
        itemBuilder: (context, index) {
          final prod = mockProducts[index];
          return Card(
            elevation: 0,
            color: AppTheme.surface,
            margin: const EdgeInsets.only(bottom: AppTheme.spacingBase),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              side: const BorderSide(color: AppTheme.border),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(AppTheme.spacingBase),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.background,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: const Icon(PhosphorIconsRegular.tShirt, color: AppTheme.primary),
              ),
              title: Text(prod['name']!, style: Theme.of(context).textTheme.titleSmall),
              subtitle: Text(prod['category']!),
              trailing: Text(
                prod['price']!,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary),
              ),
            ),
          );
        },
      ),
    );
  }
}
