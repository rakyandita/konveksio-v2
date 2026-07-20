// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spk_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpkModel {

 String get id; String? get branchId; String get orderId; String get spkNumber; String get status;
/// Create a copy of SpkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpkModelCopyWith<SpkModel> get copyWith => _$SpkModelCopyWithImpl<SpkModel>(this as SpkModel, _$identity);

  /// Serializes this SpkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.spkNumber, spkNumber) || other.spkNumber == spkNumber)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,orderId,spkNumber,status);

@override
String toString() {
  return 'SpkModel(id: $id, branchId: $branchId, orderId: $orderId, spkNumber: $spkNumber, status: $status)';
}


}

/// @nodoc
abstract mixin class $SpkModelCopyWith<$Res>  {
  factory $SpkModelCopyWith(SpkModel value, $Res Function(SpkModel) _then) = _$SpkModelCopyWithImpl;
@useResult
$Res call({
 String id, String? branchId, String orderId, String spkNumber, String status
});




}
/// @nodoc
class _$SpkModelCopyWithImpl<$Res>
    implements $SpkModelCopyWith<$Res> {
  _$SpkModelCopyWithImpl(this._self, this._then);

  final SpkModel _self;
  final $Res Function(SpkModel) _then;

/// Create a copy of SpkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = freezed,Object? orderId = null,Object? spkNumber = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,spkNumber: null == spkNumber ? _self.spkNumber : spkNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SpkModel].
extension SpkModelPatterns on SpkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpkModel value)  $default,){
final _that = this;
switch (_that) {
case _SpkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpkModel value)?  $default,){
final _that = this;
switch (_that) {
case _SpkModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? branchId,  String orderId,  String spkNumber,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpkModel() when $default != null:
return $default(_that.id,_that.branchId,_that.orderId,_that.spkNumber,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? branchId,  String orderId,  String spkNumber,  String status)  $default,) {final _that = this;
switch (_that) {
case _SpkModel():
return $default(_that.id,_that.branchId,_that.orderId,_that.spkNumber,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? branchId,  String orderId,  String spkNumber,  String status)?  $default,) {final _that = this;
switch (_that) {
case _SpkModel() when $default != null:
return $default(_that.id,_that.branchId,_that.orderId,_that.spkNumber,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpkModel implements SpkModel {
  const _SpkModel({required this.id, this.branchId, required this.orderId, required this.spkNumber, required this.status});
  factory _SpkModel.fromJson(Map<String, dynamic> json) => _$SpkModelFromJson(json);

@override final  String id;
@override final  String? branchId;
@override final  String orderId;
@override final  String spkNumber;
@override final  String status;

/// Create a copy of SpkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpkModelCopyWith<_SpkModel> get copyWith => __$SpkModelCopyWithImpl<_SpkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.spkNumber, spkNumber) || other.spkNumber == spkNumber)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,orderId,spkNumber,status);

@override
String toString() {
  return 'SpkModel(id: $id, branchId: $branchId, orderId: $orderId, spkNumber: $spkNumber, status: $status)';
}


}

/// @nodoc
abstract mixin class _$SpkModelCopyWith<$Res> implements $SpkModelCopyWith<$Res> {
  factory _$SpkModelCopyWith(_SpkModel value, $Res Function(_SpkModel) _then) = __$SpkModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? branchId, String orderId, String spkNumber, String status
});




}
/// @nodoc
class __$SpkModelCopyWithImpl<$Res>
    implements _$SpkModelCopyWith<$Res> {
  __$SpkModelCopyWithImpl(this._self, this._then);

  final _SpkModel _self;
  final $Res Function(_SpkModel) _then;

/// Create a copy of SpkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = freezed,Object? orderId = null,Object? spkNumber = null,Object? status = null,}) {
  return _then(_SpkModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,spkNumber: null == spkNumber ? _self.spkNumber : spkNumber // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
