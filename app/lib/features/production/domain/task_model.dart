import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {

        const factory TaskModel({
    required String id,
    required String orderItemId,
    String? assignedToUser,
    String? assignedToVendor,
    required String division,
    required String status,
    @Default(0) double ongkosPerPcsSnapshot,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);
}

@freezed
abstract class TaskSizeModel with _$TaskSizeModel {

        const factory TaskSizeModel({
    required String id,
    required String taskId,
    required String size,
    required int targetQty,
    @Default(0) int completedQty,
  }) = _TaskSizeModel;

  factory TaskSizeModel.fromJson(Map<String, dynamic> json) => _$TaskSizeModelFromJson(json);
}
