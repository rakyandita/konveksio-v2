import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/supabase/supabase_client_provider.dart';
import '../domain/product_model.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ref.watch(supabaseClientProvider));
});

class ProductRepository {
  final SupabaseClient _supabase;

  ProductRepository(this._supabase);

  Future<List<ProductModel>> getProducts() async {
    final response = await _supabase.from('products').select().eq('is_active', true).order('name');
    return response.map((json) => ProductModel.fromJson(json)).toList();
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    final data = product.toJson()..remove('id');
    final response = await _supabase.from('products').insert(data).select().single();
    return ProductModel.fromJson(response);
  }

  Future<ProductModel> updateProduct(ProductModel product) async {
    final response = await _supabase
        .from('products')
        .update(product.toJson())
        .eq('id', product.id)
        .select()
        .single();
    return ProductModel.fromJson(response);
  }

  Future<void> deleteProduct(String id) async {
    await _supabase.from('products').update({'is_active': false}).eq('id', id);
  }
}
