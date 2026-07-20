import 'package:freezed_annotation/freezed_annotation.dart';

part 'handover_model.freezed.dart';
part 'handover_model.g.dart';

@freezed
abstract class HandoverModel with _$HandoverModel {

  const factory HandoverModel({
    required String id,
    required String fromTaskId,
    String? toUserId,
    String? toVendorId,
    required String status,
    String? rejectionReason,
    DateTime? createdAt,
  }) = _HandoverModel;

  factory HandoverModel.fromJson(Map<String, dynamic> json) => _$HandoverModelFromJson(json);
}

@freezed
abstract class HandoverSizeModel with _$HandoverSizeModel {

  const factory HandoverSizeModel({
    required String id,
    required String handoverId,
    required String size,
    required int qtySent,
    int? qtyReceived,
  }) = _HandoverSizeModel;

  factory HandoverSizeModel.fromJson(Map<String, dynamic> json) => _$HandoverSizeModelFromJson(json);
}
