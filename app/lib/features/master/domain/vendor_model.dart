import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_model.freezed.dart';
part 'vendor_model.g.dart';

@freezed
abstract class VendorModel with _$VendorModel {

        const factory VendorModel({
    required String id,
    String? branchId,
    required String name,
    required String division,
    String? phone,
    String? notes,
    @Default(true) bool isActive,
  }) = _VendorModel;

  factory VendorModel.fromJson(Map<String, dynamic> json) => _$VendorModelFromJson(json);
}
