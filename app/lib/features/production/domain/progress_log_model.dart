import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_log_model.freezed.dart';
part 'progress_log_model.g.dart';

@freezed
abstract class ProgressLogModel with _$ProgressLogModel {

        const factory ProgressLogModel({
    required String id,
    required String taskId,
    required String userId,
    required String size,
    required int qtyCompleted,
    DateTime? createdAt,
  }) = _ProgressLogModel;

  factory ProgressLogModel.fromJson(Map<String, dynamic> json) => _$ProgressLogModelFromJson(json);
}
