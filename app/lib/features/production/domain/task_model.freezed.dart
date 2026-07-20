// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskModel {

 String get id; String get orderItemId; String? get assignedToUser; String? get assignedToVendor; String get division; String get status; double get ongkosPerPcsSnapshot;
/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskModelCopyWith<TaskModel> get copyWith => _$TaskModelCopyWithImpl<TaskModel>(this as TaskModel, _$identity);

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderItemId, orderItemId) || other.orderItemId == orderItemId)&&(identical(other.assignedToUser, assignedToUser) || other.assignedToUser == assignedToUser)&&(identical(other.assignedToVendor, assignedToVendor) || other.assignedToVendor == assignedToVendor)&&(identical(other.division, division) || other.division == division)&&(identical(other.status, status) || other.status == status)&&(identical(other.ongkosPerPcsSnapshot, ongkosPerPcsSnapshot) || other.ongkosPerPcsSnapshot == ongkosPerPcsSnapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderItemId,assignedToUser,assignedToVendor,division,status,ongkosPerPcsSnapshot);

@override
String toString() {
  return 'TaskModel(id: $id, orderItemId: $orderItemId, assignedToUser: $assignedToUser, assignedToVendor: $assignedToVendor, division: $division, status: $status, ongkosPerPcsSnapshot: $ongkosPerPcsSnapshot)';
}


}

/// @nodoc
abstract mixin class $TaskModelCopyWith<$Res>  {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) _then) = _$TaskModelCopyWithImpl;
@useResult
$Res call({
 String id, String orderItemId, String? assignedToUser, String? assignedToVendor, String division, String status, double ongkosPerPcsSnapshot
});




}
/// @nodoc
class _$TaskModelCopyWithImpl<$Res>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._self, this._then);

  final TaskModel _self;
  final $Res Function(TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderItemId = null,Object? assignedToUser = freezed,Object? assignedToVendor = freezed,Object? division = null,Object? status = null,Object? ongkosPerPcsSnapshot = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderItemId: null == orderItemId ? _self.orderItemId : orderItemId // ignore: cast_nullable_to_non_nullable
as String,assignedToUser: freezed == assignedToUser ? _self.assignedToUser : assignedToUser // ignore: cast_nullable_to_non_nullable
as String?,assignedToVendor: freezed == assignedToVendor ? _self.assignedToVendor : assignedToVendor // ignore: cast_nullable_to_non_nullable
as String?,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,ongkosPerPcsSnapshot: null == ongkosPerPcsSnapshot ? _self.ongkosPerPcsSnapshot : ongkosPerPcsSnapshot // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskModel].
extension TaskModelPatterns on TaskModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderItemId,  String? assignedToUser,  String? assignedToVendor,  String division,  String status,  double ongkosPerPcsSnapshot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.orderItemId,_that.assignedToUser,_that.assignedToVendor,_that.division,_that.status,_that.ongkosPerPcsSnapshot);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderItemId,  String? assignedToUser,  String? assignedToVendor,  String division,  String status,  double ongkosPerPcsSnapshot)  $default,) {final _that = this;
switch (_that) {
case _TaskModel():
return $default(_that.id,_that.orderItemId,_that.assignedToUser,_that.assignedToVendor,_that.division,_that.status,_that.ongkosPerPcsSnapshot);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderItemId,  String? assignedToUser,  String? assignedToVendor,  String division,  String status,  double ongkosPerPcsSnapshot)?  $default,) {final _that = this;
switch (_that) {
case _TaskModel() when $default != null:
return $default(_that.id,_that.orderItemId,_that.assignedToUser,_that.assignedToVendor,_that.division,_that.status,_that.ongkosPerPcsSnapshot);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskModel implements TaskModel {
  const _TaskModel({required this.id, required this.orderItemId, this.assignedToUser, this.assignedToVendor, required this.division, required this.status, this.ongkosPerPcsSnapshot = 0});
  factory _TaskModel.fromJson(Map<String, dynamic> json) => _$TaskModelFromJson(json);

@override final  String id;
@override final  String orderItemId;
@override final  String? assignedToUser;
@override final  String? assignedToVendor;
@override final  String division;
@override final  String status;
@override@JsonKey() final  double ongkosPerPcsSnapshot;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskModelCopyWith<_TaskModel> get copyWith => __$TaskModelCopyWithImpl<_TaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderItemId, orderItemId) || other.orderItemId == orderItemId)&&(identical(other.assignedToUser, assignedToUser) || other.assignedToUser == assignedToUser)&&(identical(other.assignedToVendor, assignedToVendor) || other.assignedToVendor == assignedToVendor)&&(identical(other.division, division) || other.division == division)&&(identical(other.status, status) || other.status == status)&&(identical(other.ongkosPerPcsSnapshot, ongkosPerPcsSnapshot) || other.ongkosPerPcsSnapshot == ongkosPerPcsSnapshot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderItemId,assignedToUser,assignedToVendor,division,status,ongkosPerPcsSnapshot);

@override
String toString() {
  return 'TaskModel(id: $id, orderItemId: $orderItemId, assignedToUser: $assignedToUser, assignedToVendor: $assignedToVendor, division: $division, status: $status, ongkosPerPcsSnapshot: $ongkosPerPcsSnapshot)';
}


}

/// @nodoc
abstract mixin class _$TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$TaskModelCopyWith(_TaskModel value, $Res Function(_TaskModel) _then) = __$TaskModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderItemId, String? assignedToUser, String? assignedToVendor, String division, String status, double ongkosPerPcsSnapshot
});




}
/// @nodoc
class __$TaskModelCopyWithImpl<$Res>
    implements _$TaskModelCopyWith<$Res> {
  __$TaskModelCopyWithImpl(this._self, this._then);

  final _TaskModel _self;
  final $Res Function(_TaskModel) _then;

/// Create a copy of TaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderItemId = null,Object? assignedToUser = freezed,Object? assignedToVendor = freezed,Object? division = null,Object? status = null,Object? ongkosPerPcsSnapshot = null,}) {
  return _then(_TaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderItemId: null == orderItemId ? _self.orderItemId : orderItemId // ignore: cast_nullable_to_non_nullable
as String,assignedToUser: freezed == assignedToUser ? _self.assignedToUser : assignedToUser // ignore: cast_nullable_to_non_nullable
as String?,assignedToVendor: freezed == assignedToVendor ? _self.assignedToVendor : assignedToVendor // ignore: cast_nullable_to_non_nullable
as String?,division: null == division ? _self.division : division // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,ongkosPerPcsSnapshot: null == ongkosPerPcsSnapshot ? _self.ongkosPerPcsSnapshot : ongkosPerPcsSnapshot // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$TaskSizeModel {

 String get id; String get taskId; String get size; int get targetQty; int get completedQty;
/// Create a copy of TaskSizeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskSizeModelCopyWith<TaskSizeModel> get copyWith => _$TaskSizeModelCopyWithImpl<TaskSizeModel>(this as TaskSizeModel, _$identity);

  /// Serializes this TaskSizeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskSizeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.size, size) || other.size == size)&&(identical(other.targetQty, targetQty) || other.targetQty == targetQty)&&(identical(other.completedQty, completedQty) || other.completedQty == completedQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,size,targetQty,completedQty);

@override
String toString() {
  return 'TaskSizeModel(id: $id, taskId: $taskId, size: $size, targetQty: $targetQty, completedQty: $completedQty)';
}


}

/// @nodoc
abstract mixin class $TaskSizeModelCopyWith<$Res>  {
  factory $TaskSizeModelCopyWith(TaskSizeModel value, $Res Function(TaskSizeModel) _then) = _$TaskSizeModelCopyWithImpl;
@useResult
$Res call({
 String id, String taskId, String size, int targetQty, int completedQty
});




}
/// @nodoc
class _$TaskSizeModelCopyWithImpl<$Res>
    implements $TaskSizeModelCopyWith<$Res> {
  _$TaskSizeModelCopyWithImpl(this._self, this._then);

  final TaskSizeModel _self;
  final $Res Function(TaskSizeModel) _then;

/// Create a copy of TaskSizeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? size = null,Object? targetQty = null,Object? completedQty = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,targetQty: null == targetQty ? _self.targetQty : targetQty // ignore: cast_nullable_to_non_nullable
as int,completedQty: null == completedQty ? _self.completedQty : completedQty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TaskSizeModel].
extension TaskSizeModelPatterns on TaskSizeModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaskSizeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaskSizeModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaskSizeModel value)  $default,){
final _that = this;
switch (_that) {
case _TaskSizeModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaskSizeModel value)?  $default,){
final _that = this;
switch (_that) {
case _TaskSizeModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String taskId,  String size,  int targetQty,  int completedQty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaskSizeModel() when $default != null:
return $default(_that.id,_that.taskId,_that.size,_that.targetQty,_that.completedQty);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String taskId,  String size,  int targetQty,  int completedQty)  $default,) {final _that = this;
switch (_that) {
case _TaskSizeModel():
return $default(_that.id,_that.taskId,_that.size,_that.targetQty,_that.completedQty);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String taskId,  String size,  int targetQty,  int completedQty)?  $default,) {final _that = this;
switch (_that) {
case _TaskSizeModel() when $default != null:
return $default(_that.id,_that.taskId,_that.size,_that.targetQty,_that.completedQty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaskSizeModel implements TaskSizeModel {
  const _TaskSizeModel({required this.id, required this.taskId, required this.size, required this.targetQty, this.completedQty = 0});
  factory _TaskSizeModel.fromJson(Map<String, dynamic> json) => _$TaskSizeModelFromJson(json);

@override final  String id;
@override final  String taskId;
@override final  String size;
@override final  int targetQty;
@override@JsonKey() final  int completedQty;

/// Create a copy of TaskSizeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskSizeModelCopyWith<_TaskSizeModel> get copyWith => __$TaskSizeModelCopyWithImpl<_TaskSizeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskSizeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskSizeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.size, size) || other.size == size)&&(identical(other.targetQty, targetQty) || other.targetQty == targetQty)&&(identical(other.completedQty, completedQty) || other.completedQty == completedQty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,size,targetQty,completedQty);

@override
String toString() {
  return 'TaskSizeModel(id: $id, taskId: $taskId, size: $size, targetQty: $targetQty, completedQty: $completedQty)';
}


}

/// @nodoc
abstract mixin class _$TaskSizeModelCopyWith<$Res> implements $TaskSizeModelCopyWith<$Res> {
  factory _$TaskSizeModelCopyWith(_TaskSizeModel value, $Res Function(_TaskSizeModel) _then) = __$TaskSizeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String taskId, String size, int targetQty, int completedQty
});




}
/// @nodoc
class __$TaskSizeModelCopyWithImpl<$Res>
    implements _$TaskSizeModelCopyWith<$Res> {
  __$TaskSizeModelCopyWithImpl(this._self, this._then);

  final _TaskSizeModel _self;
  final $Res Function(_TaskSizeModel) _then;

/// Create a copy of TaskSizeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? size = null,Object? targetQty = null,Object? completedQty = null,}) {
  return _then(_TaskSizeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,targetQty: null == targetQty ? _self.targetQty : targetQty // ignore: cast_nullable_to_non_nullable
as int,completedQty: null == completedQty ? _self.completedQty : completedQty // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
