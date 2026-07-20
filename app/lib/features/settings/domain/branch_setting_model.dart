import 'package:freezed_annotation/freezed_annotation.dart';

part 'branch_setting_model.freezed.dart';
part 'branch_setting_model.g.dart';

@freezed
abstract class BranchSettingModel with _$BranchSettingModel {
  const factory BranchSettingModel({
    required String branchId,
    String? paymentSystem,
    int? maxKasbonPercentage,
    String? contactWa,
    String? bankAccountInfo,
  }) = _BranchSettingModel;

  factory BranchSettingModel.fromJson(Map<String, dynamic> json) => _$BranchSettingModelFromJson(json);
}
