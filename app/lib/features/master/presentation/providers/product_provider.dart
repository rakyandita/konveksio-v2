import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/product_model.dart';
import '../../data/product_repository.dart';

final productListProvider = AsyncNotifierProvider<ProductListNotifier, List<ProductModel>>(() {
  return ProductListNotifier();
});

class ProductListNotifier extends AsyncNotifier<List<ProductModel>> {
  @override
  Future<List<ProductModel>> build() async {
    return ref.watch(productRepositoryProvider).getProducts();
  }

  Future<void> addProduct(ProductModel product) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(productRepositoryProvider).createProduct(product);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(productRepositoryProvider).updateProduct(product);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteProduct(String id) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(productRepositoryProvider).deleteProduct(id);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
