import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/product_repository.dart';
import '../widgets/horizontal_bento_grid.dart';
import '../../../../core/database/app_database.dart'; // Untuk model Product

// State Provider untuk watch products
final productsProvider = StreamProvider.autoDispose.family<List<Product>, String>((ref, branchId) {
  final repo = ref.watch(productRepositoryProvider);
  return repo.watchProducts(branchId);
});

class ProductCatalogScreen extends ConsumerStatefulWidget {
  final String branchId;
  const ProductCatalogScreen({super.key, required this.branchId});

  @override
  ConsumerState<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends ConsumerState<ProductCatalogScreen> {
  @override
  void initState() {
    super.initState();
    // Sinkronisasi background saat halaman dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(productRepositoryProvider).syncProducts(widget.branchId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider(widget.branchId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              productsAsync.when(
                data: (products) => HorizontalBentoGrid(
                  title: 'Daftar Produk',
                  itemCount: products.length,
                  onAdd: () {
                    // TODO: Navigasi ke form tambah produk
                  },
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      padding: const EdgeInsets.all(AppRadius.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondary.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: AppTypography.h2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              product.category.toUpperCase(),
                              style: AppTypography.caption.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Rp ${product.priceMin.toInt()} - Rp ${product.priceMax.toInt()}',
                            style: AppTypography.body2.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                loading: () => HorizontalBentoGrid(
                  title: 'Daftar Produk',
                  itemCount: 3,
                  itemBuilder: (context, index) => const BentoSkeleton(),
                ),
                error: (err, stack) => Center(
                  child: Text('Gagal memuat data: $err', style: AppTypography.body2),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Tempat untuk Size Groups Bento Grid (akan diimplementasikan nanti)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Master Ukuran', style: AppTypography.h2),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Akan segera hadir...'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
