import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {

        const factory ProductModel({
    required String id,
    String? branchId,
    required String name,
    required String category,
    required String sizeGroupId,
    required double priceMin,
    required double priceMax,
    @Default(true) bool isActive,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
}
