import 'package:freezed_annotation/freezed_annotation.dart';

part 'size_group_model.freezed.dart';
part 'size_group_model.g.dart';

@freezed
abstract class SizeGroupModel with _$SizeGroupModel {

        const factory SizeGroupModel({
    required String id,
    String? branchId,
    required String name,
    required List<String> sizes,
  }) = _SizeGroupModel;

  factory SizeGroupModel.fromJson(Map<String, dynamic> json) => _$SizeGroupModelFromJson(json);
}
