// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handover_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HandoverModel {

 String get id; String get fromTaskId; String? get toUserId; String? get toVendorId; String get status; String? get rejectionReason; DateTime? get createdAt;
/// Create a copy of HandoverModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandoverModelCopyWith<HandoverModel> get copyWith => _$HandoverModelCopyWithImpl<HandoverModel>(this as HandoverModel, _$identity);

  /// Serializes this HandoverModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandoverModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromTaskId, fromTaskId) || other.fromTaskId == fromTaskId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.toVendorId, toVendorId) || other.toVendorId == toVendorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromTaskId,toUserId,toVendorId,status,rejectionReason,createdAt);

@override
String toString() {
  return 'HandoverModel(id: $id, fromTaskId: $fromTaskId, toUserId: $toUserId, toVendorId: $toVendorId, status: $status, rejectionReason: $rejectionReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $HandoverModelCopyWith<$Res>  {
  factory $HandoverModelCopyWith(HandoverModel value, $Res Function(HandoverModel) _then) = _$HandoverModelCopyWithImpl;
@useResult
$Res call({
 String id, String fromTaskId, String? toUserId, String? toVendorId, String status, String? rejectionReason, DateTime? createdAt
});




}
/// @nodoc
class _$HandoverModelCopyWithImpl<$Res>
    implements $HandoverModelCopyWith<$Res> {
  _$HandoverModelCopyWithImpl(this._self, this._then);

  final HandoverModel _self;
  final $Res Function(HandoverModel) _then;

/// Create a copy of HandoverModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromTaskId = null,Object? toUserId = freezed,Object? toVendorId = freezed,Object? status = null,Object? rejectionReason = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromTaskId: null == fromTaskId ? _self.fromTaskId : fromTaskId // ignore: cast_nullable_to_non_nullable
as String,toUserId: freezed == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String?,toVendorId: freezed == toVendorId ? _self.toVendorId : toVendorId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [HandoverModel].
extension HandoverModelPatterns on HandoverModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandoverModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandoverModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandoverModel value)  $default,){
final _that = this;
switch (_that) {
case _HandoverModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandoverModel value)?  $default,){
final _that = this;
switch (_that) {
case _HandoverModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fromTaskId,  String? toUserId,  String? toVendorId,  String status,  String? rejectionReason,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandoverModel() when $default != null:
return $default(_that.id,_that.fromTaskId,_that.toUserId,_that.toVendorId,_that.status,_that.rejectionReason,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fromTaskId,  String? toUserId,  String? toVendorId,  String status,  String? rejectionReason,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _HandoverModel():
return $default(_that.id,_that.fromTaskId,_that.toUserId,_that.toVendorId,_that.status,_that.rejectionReason,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fromTaskId,  String? toUserId,  String? toVendorId,  String status,  String? rejectionReason,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _HandoverModel() when $default != null:
return $default(_that.id,_that.fromTaskId,_that.toUserId,_that.toVendorId,_that.status,_that.rejectionReason,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HandoverModel implements HandoverModel {
  const _HandoverModel({required this.id, required this.fromTaskId, this.toUserId, this.toVendorId, required this.status, this.rejectionReason, this.createdAt});
  factory _HandoverModel.fromJson(Map<String, dynamic> json) => _$HandoverModelFromJson(json);

@override final  String id;
@override final  String fromTaskId;
@override final  String? toUserId;
@override final  String? toVendorId;
@override final  String status;
@override final  String? rejectionReason;
@override final  DateTime? createdAt;

/// Create a copy of HandoverModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandoverModelCopyWith<_HandoverModel> get copyWith => __$HandoverModelCopyWithImpl<_HandoverModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HandoverModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandoverModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromTaskId, fromTaskId) || other.fromTaskId == fromTaskId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.toVendorId, toVendorId) || other.toVendorId == toVendorId)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromTaskId,toUserId,toVendorId,status,rejectionReason,createdAt);

@override
String toString() {
  return 'HandoverModel(id: $id, fromTaskId: $fromTaskId, toUserId: $toUserId, toVendorId: $toVendorId, status: $status, rejectionReason: $rejectionReason, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$HandoverModelCopyWith<$Res> implements $HandoverModelCopyWith<$Res> {
  factory _$HandoverModelCopyWith(_HandoverModel value, $Res Function(_HandoverModel) _then) = __$HandoverModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String fromTaskId, String? toUserId, String? toVendorId, String status, String? rejectionReason, DateTime? createdAt
});




}
/// @nodoc
class __$HandoverModelCopyWithImpl<$Res>
    implements _$HandoverModelCopyWith<$Res> {
  __$HandoverModelCopyWithImpl(this._self, this._then);

  final _HandoverModel _self;
  final $Res Function(_HandoverModel) _then;

/// Create a copy of HandoverModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromTaskId = null,Object? toUserId = freezed,Object? toVendorId = freezed,Object? status = null,Object? rejectionReason = freezed,Object? createdAt = freezed,}) {
  return _then(_HandoverModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromTaskId: null == fromTaskId ? _self.fromTaskId : fromTaskId // ignore: cast_nullable_to_non_nullable
as String,toUserId: freezed == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String?,toVendorId: freezed == toVendorId ? _self.toVendorId : toVendorId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$HandoverSizeModel {

 String get id; String get handoverId; String get size; int get qtySent; int? get qtyReceived;
/// Create a copy of HandoverSizeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandoverSizeModelCopyWith<HandoverSizeModel> get copyWith => _$HandoverSizeModelCopyWithImpl<HandoverSizeModel>(this as HandoverSizeModel, _$identity);

  /// Serializes this HandoverSizeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandoverSizeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.handoverId, handoverId) || other.handoverId == handoverId)&&(identical(other.size, size) || other.size == size)&&(identical(other.qtySent, qtySent) || other.qtySent == qtySent)&&(identical(other.qtyReceived, qtyReceived) || other.qtyReceived == qtyReceived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,handoverId,size,qtySent,qtyReceived);

@override
String toString() {
  return 'HandoverSizeModel(id: $id, handoverId: $handoverId, size: $size, qtySent: $qtySent, qtyReceived: $qtyReceived)';
}


}

/// @nodoc
abstract mixin class $HandoverSizeModelCopyWith<$Res>  {
  factory $HandoverSizeModelCopyWith(HandoverSizeModel value, $Res Function(HandoverSizeModel) _then) = _$HandoverSizeModelCopyWithImpl;
@useResult
$Res call({
 String id, String handoverId, String size, int qtySent, int? qtyReceived
});




}
/// @nodoc
class _$HandoverSizeModelCopyWithImpl<$Res>
    implements $HandoverSizeModelCopyWith<$Res> {
  _$HandoverSizeModelCopyWithImpl(this._self, this._then);

  final HandoverSizeModel _self;
  final $Res Function(HandoverSizeModel) _then;

/// Create a copy of HandoverSizeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? handoverId = null,Object? size = null,Object? qtySent = null,Object? qtyReceived = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handoverId: null == handoverId ? _self.handoverId : handoverId // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,qtySent: null == qtySent ? _self.qtySent : qtySent // ignore: cast_nullable_to_non_nullable
as int,qtyReceived: freezed == qtyReceived ? _self.qtyReceived : qtyReceived // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [HandoverSizeModel].
extension HandoverSizeModelPatterns on HandoverSizeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandoverSizeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandoverSizeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandoverSizeModel value)  $default,){
final _that = this;
switch (_that) {
case _HandoverSizeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandoverSizeModel value)?  $default,){
final _that = this;
switch (_that) {
case _HandoverSizeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String handoverId,  String size,  int qtySent,  int? qtyReceived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandoverSizeModel() when $default != null:
return $default(_that.id,_that.handoverId,_that.size,_that.qtySent,_that.qtyReceived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String handoverId,  String size,  int qtySent,  int? qtyReceived)  $default,) {final _that = this;
switch (_that) {
case _HandoverSizeModel():
return $default(_that.id,_that.handoverId,_that.size,_that.qtySent,_that.qtyReceived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String handoverId,  String size,  int qtySent,  int? qtyReceived)?  $default,) {final _that = this;
switch (_that) {
case _HandoverSizeModel() when $default != null:
return $default(_that.id,_that.handoverId,_that.size,_that.qtySent,_that.qtyReceived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HandoverSizeModel implements HandoverSizeModel {
  const _HandoverSizeModel({required this.id, required this.handoverId, required this.size, required this.qtySent, this.qtyReceived});
  factory _HandoverSizeModel.fromJson(Map<String, dynamic> json) => _$HandoverSizeModelFromJson(json);

@override final  String id;
@override final  String handoverId;
@override final  String size;
@override final  int qtySent;
@override final  int? qtyReceived;

/// Create a copy of HandoverSizeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandoverSizeModelCopyWith<_HandoverSizeModel> get copyWith => __$HandoverSizeModelCopyWithImpl<_HandoverSizeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HandoverSizeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandoverSizeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.handoverId, handoverId) || other.handoverId == handoverId)&&(identical(other.size, size) || other.size == size)&&(identical(other.qtySent, qtySent) || other.qtySent == qtySent)&&(identical(other.qtyReceived, qtyReceived) || other.qtyReceived == qtyReceived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,handoverId,size,qtySent,qtyReceived);

@override
String toString() {
  return 'HandoverSizeModel(id: $id, handoverId: $handoverId, size: $size, qtySent: $qtySent, qtyReceived: $qtyReceived)';
}


}

/// @nodoc
abstract mixin class _$HandoverSizeModelCopyWith<$Res> implements $HandoverSizeModelCopyWith<$Res> {
  factory _$HandoverSizeModelCopyWith(_HandoverSizeModel value, $Res Function(_HandoverSizeModel) _then) = __$HandoverSizeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String handoverId, String size, int qtySent, int? qtyReceived
});




}
/// @nodoc
class __$HandoverSizeModelCopyWithImpl<$Res>
    implements _$HandoverSizeModelCopyWith<$Res> {
  __$HandoverSizeModelCopyWithImpl(this._self, this._then);

  final _HandoverSizeModel _self;
  final $Res Function(_HandoverSizeModel) _then;

/// Create a copy of HandoverSizeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? handoverId = null,Object? size = null,Object? qtySent = null,Object? qtyReceived = freezed,}) {
  return _then(_HandoverSizeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,handoverId: null == handoverId ? _self.handoverId : handoverId // ignore: cast_nullable_to_non_nullable
as String,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as String,qtySent: null == qtySent ? _self.qtySent : qtySent // ignore: cast_nullable_to_non_nullable
as int,qtyReceived: freezed == qtyReceived ? _self.qtyReceived : qtyReceived // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
