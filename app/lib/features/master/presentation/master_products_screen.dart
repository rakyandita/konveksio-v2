import 'package:flutter/material.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';
import '../../../core/theme/app_theme.dart';
import 'forms/master_product_form_modal.dart' as import_modal;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/product_provider.dart';
import 'package:intl/intl.dart';

class MasterProductsScreen extends ConsumerWidget {
  const MasterProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productListProvider);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        backgroundColor: AppTheme.surface,
        scrolledUnderElevation: 4.0,
      ),

      body: productsAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return const Center(child: Text('Belum ada data produk'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(AppTheme.spacingBase),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final prod = products[index];
              final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
              
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
                  title: Text(prod.name, style: Theme.of(context).textTheme.titleSmall),
                  subtitle: Text(prod.category),
                  trailing: Text(
                    currencyFormat.format(prod.priceMin),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Terjadi kesalahan: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          import_modal.MasterProductFormModal.show(context);
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(PhosphorIconsRegular.plus, color: AppTheme.background),
      ),
    );
  }
}
