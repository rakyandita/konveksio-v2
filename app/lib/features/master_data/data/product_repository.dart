import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/database/app_database.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(
    Supabase.instance.client,
    ref.read(appDatabaseProvider),
  );
});

class ProductRepository {
  final SupabaseClient _supabase;
  final AppDatabase _db;

  ProductRepository(this._supabase, this._db);

  /// Watch local products (Reactive UI)
  Stream<List<Product>> watchProducts(String branchId) {
    return (_db.select(_db.products)..where((t) => t.branchId.equals(branchId))).watch();
  }

  /// Sync from Supabase to local Drift DB
  Future<void> syncProducts(String branchId) async {
    try {
      final response = await _supabase
          .from('products')
          .select()
          .eq('branch_id', branchId);

      await _db.batch((batch) {
        batch.insertAll(
          _db.products,
          response.map((row) => ProductsCompanion.insert(
            id: row['id'] as String,
            branchId: row['branch_id'] as String,
            name: row['name'] as String,
            category: row['category'] as String,
            sizeGroupId: row['size_group_id'] as String,
            priceMin: (row['price_min'] as num).toDouble(),
            priceMax: (row['price_max'] as num).toDouble(),
            isActive: Value(row['is_active'] as bool? ?? true),
          )).toList(),
          mode: InsertMode.insertOrReplace,
        );
      });
    } catch (e) {
      // Biarkan gagal diam-diam, data lama masih ada di Drift (Offline-First)
      debugPrint('Gagal sync products: $e');
    }
  }
}
