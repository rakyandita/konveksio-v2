// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProgressLogModel {

 String get id; String get taskId; String get userId; String get size; int get qtyCompleted; DateTime? get createdAt;
/// Create a copy of ProgressLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressLogModelCopyWith<ProgressLogModel> get copyWith => _$ProgressLogModelCopyWithImpl<ProgressLogModel>(this as ProgressLogModel, _$identity);

  /// Serializes this ProgressLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.size, size) || other.size == size)&&(identical(other.qtyCompleted, qtyCompleted) || other.qtyCompleted == qtyCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,userId,size,qtyCompleted,createdAt);

@override
String toString() {
  return 'ProgressLogModel(id: $id, taskId: $taskId, userId: $userId, size: $size, qtyCompleted: $qtyCompleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ProgressLogModelCopyWith<$Res>  {
  factory $ProgressLogModelCopyWith(ProgressLogModel value, $Res Function(ProgressLogModel) _then) = _$ProgressLogModelCopyWithImpl;
@useResult
$Res call({
 String id, String taskId, String userId, String size, int qtyCompleted, DateTime? createdAt
});




}
/// @nodoc
class _$ProgressLogModelCopyWithImpl<$Res>
    implements $ProgressLogModelCopyWith<$Res> {
  _$ProgressLogModelCopyWithImpl(this._self, this._then);

  final ProgressLogModel _self;
  final $Res Function(ProgressLogModel) _then;

/// Create a copy of ProgressLogModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? userId = null,Object? size = null,Object? qtyCompleted = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,qtyCompleted: null == qtyCompleted ? _self.qtyCompleted : qtyCompleted // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProgressLogModel].
extension ProgressLogModelPatterns on ProgressLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProgressLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProgressLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProgressLogModel value)  $default,){
final _that = this;
switch (_that) {
case _ProgressLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProgressLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProgressLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String taskId,  String userId,  String size,  int qtyCompleted,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProgressLogModel() when $default != null:
return $default(_that.id,_that.taskId,_that.userId,_that.size,_that.qtyCompleted,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String taskId,  String userId,  String size,  int qtyCompleted,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ProgressLogModel():
return $default(_that.id,_that.taskId,_that.userId,_that.size,_that.qtyCompleted,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String taskId,  String userId,  String size,  int qtyCompleted,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ProgressLogModel() when $default != null:
return $default(_that.id,_that.taskId,_that.userId,_that.size,_that.qtyCompleted,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProgressLogModel implements ProgressLogModel {
  const _ProgressLogModel({required this.id, required this.taskId, required this.userId, required this.size, required this.qtyCompleted, this.createdAt});
  factory _ProgressLogModel.fromJson(Map<String, dynamic> json) => _$ProgressLogModelFromJson(json);

@override final  String id;
@override final  String taskId;
@override final  String userId;
@override final  String size;
@override final  int qtyCompleted;
@override final  DateTime? createdAt;

/// Create a copy of ProgressLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProgressLogModelCopyWith<_ProgressLogModel> get copyWith => __$ProgressLogModelCopyWithImpl<_ProgressLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProgressLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProgressLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.size, size) || other.size == size)&&(identical(other.qtyCompleted, qtyCompleted) || other.qtyCompleted == qtyCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,userId,size,qtyCompleted,createdAt);

@override
String toString() {
  return 'ProgressLogModel(id: $id, taskId: $taskId, userId: $userId, size: $size, qtyCompleted: $qtyCompleted, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ProgressLogModelCopyWith<$Res> implements $ProgressLogModelCopyWith<$Res> {
  factory _$ProgressLogModelCopyWith(_ProgressLogModel value, $Res Function(_ProgressLogModel) _then) = __$ProgressLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String taskId, String userId, String size, int qtyCompleted, DateTime? createdAt
});




}
/// @nodoc
class __$ProgressLogModelCopyWithImpl<$Res>
    implements _$ProgressLogModelCopyWith<$Res> {
  __$ProgressLogModelCopyWithImpl(this._self, this._then);

  final _ProgressLogModel _self;
  final $Res Function(_ProgressLogModel) _then;

/// Create a copy of ProgressLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? userId = null,Object? size = null,Object? qtyCompleted = null,Object? createdAt = freezed,}) {
  return _then(_ProgressLogModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,qtyCompleted: null == qtyCompleted ? _self.qtyCompleted : qtyCompleted // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
