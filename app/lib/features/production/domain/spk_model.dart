import 'package:freezed_annotation/freezed_annotation.dart';

part 'spk_model.freezed.dart';
part 'spk_model.g.dart';

@freezed
abstract class SpkModel with _$SpkModel {

        const factory SpkModel({
    required String id,
    String? branchId,
    required String orderId,
    required String spkNumber,
    required String status,
  }) = _SpkModel;

  factory SpkModel.fromJson(Map<String, dynamic> json) => _$SpkModelFromJson(json);
}
