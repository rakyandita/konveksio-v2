// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_advance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CashAdvanceModel {

 String get id; String get branchId; String get userId; double get amountRequested; double? get amountApproved; String? get reason; ApprovalStatus get status; DateTime get createdAt; DateTime? get approvedAt; String? get rejectionReason;
/// Create a copy of CashAdvanceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashAdvanceModelCopyWith<CashAdvanceModel> get copyWith => _$CashAdvanceModelCopyWithImpl<CashAdvanceModel>(this as CashAdvanceModel, _$identity);

  /// Serializes this CashAdvanceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashAdvanceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amountRequested, amountRequested) || other.amountRequested == amountRequested)&&(identical(other.amountApproved, amountApproved) || other.amountApproved == amountApproved)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,userId,amountRequested,amountApproved,reason,status,createdAt,approvedAt,rejectionReason);

@override
String toString() {
  return 'CashAdvanceModel(id: $id, branchId: $branchId, userId: $userId, amountRequested: $amountRequested, amountApproved: $amountApproved, reason: $reason, status: $status, createdAt: $createdAt, approvedAt: $approvedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class $CashAdvanceModelCopyWith<$Res>  {
  factory $CashAdvanceModelCopyWith(CashAdvanceModel value, $Res Function(CashAdvanceModel) _then) = _$CashAdvanceModelCopyWithImpl;
@useResult
$Res call({
 String id, String branchId, String userId, double amountRequested, double? amountApproved, String? reason, ApprovalStatus status, DateTime createdAt, DateTime? approvedAt, String? rejectionReason
});




}
/// @nodoc
class _$CashAdvanceModelCopyWithImpl<$Res>
    implements $CashAdvanceModelCopyWith<$Res> {
  _$CashAdvanceModelCopyWithImpl(this._self, this._then);

  final CashAdvanceModel _self;
  final $Res Function(CashAdvanceModel) _then;

/// Create a copy of CashAdvanceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = null,Object? userId = null,Object? amountRequested = null,Object? amountApproved = freezed,Object? reason = freezed,Object? status = null,Object? createdAt = null,Object? approvedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amountRequested: null == amountRequested ? _self.amountRequested : amountRequested // ignore: cast_nullable_to_non_nullable
as double,amountApproved: freezed == amountApproved ? _self.amountApproved : amountApproved // ignore: cast_nullable_to_non_nullable
as double?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApprovalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashAdvanceModel].
extension CashAdvanceModelPatterns on CashAdvanceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashAdvanceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashAdvanceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashAdvanceModel value)  $default,){
final _that = this;
switch (_that) {
case _CashAdvanceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashAdvanceModel value)?  $default,){
final _that = this;
switch (_that) {
case _CashAdvanceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String branchId,  String userId,  double amountRequested,  double? amountApproved,  String? reason,  ApprovalStatus status,  DateTime createdAt,  DateTime? approvedAt,  String? rejectionReason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashAdvanceModel() when $default != null:
return $default(_that.id,_that.branchId,_that.userId,_that.amountRequested,_that.amountApproved,_that.reason,_that.status,_that.createdAt,_that.approvedAt,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String branchId,  String userId,  double amountRequested,  double? amountApproved,  String? reason,  ApprovalStatus status,  DateTime createdAt,  DateTime? approvedAt,  String? rejectionReason)  $default,) {final _that = this;
switch (_that) {
case _CashAdvanceModel():
return $default(_that.id,_that.branchId,_that.userId,_that.amountRequested,_that.amountApproved,_that.reason,_that.status,_that.createdAt,_that.approvedAt,_that.rejectionReason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String branchId,  String userId,  double amountRequested,  double? amountApproved,  String? reason,  ApprovalStatus status,  DateTime createdAt,  DateTime? approvedAt,  String? rejectionReason)?  $default,) {final _that = this;
switch (_that) {
case _CashAdvanceModel() when $default != null:
return $default(_that.id,_that.branchId,_that.userId,_that.amountRequested,_that.amountApproved,_that.reason,_that.status,_that.createdAt,_that.approvedAt,_that.rejectionReason);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashAdvanceModel implements CashAdvanceModel {
  const _CashAdvanceModel({required this.id, required this.branchId, required this.userId, required this.amountRequested, this.amountApproved, this.reason, required this.status, required this.createdAt, this.approvedAt, this.rejectionReason});
  factory _CashAdvanceModel.fromJson(Map<String, dynamic> json) => _$CashAdvanceModelFromJson(json);

@override final  String id;
@override final  String branchId;
@override final  String userId;
@override final  double amountRequested;
@override final  double? amountApproved;
@override final  String? reason;
@override final  ApprovalStatus status;
@override final  DateTime createdAt;
@override final  DateTime? approvedAt;
@override final  String? rejectionReason;

/// Create a copy of CashAdvanceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashAdvanceModelCopyWith<_CashAdvanceModel> get copyWith => __$CashAdvanceModelCopyWithImpl<_CashAdvanceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashAdvanceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashAdvanceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amountRequested, amountRequested) || other.amountRequested == amountRequested)&&(identical(other.amountApproved, amountApproved) || other.amountApproved == amountApproved)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,userId,amountRequested,amountApproved,reason,status,createdAt,approvedAt,rejectionReason);

@override
String toString() {
  return 'CashAdvanceModel(id: $id, branchId: $branchId, userId: $userId, amountRequested: $amountRequested, amountApproved: $amountApproved, reason: $reason, status: $status, createdAt: $createdAt, approvedAt: $approvedAt, rejectionReason: $rejectionReason)';
}


}

/// @nodoc
abstract mixin class _$CashAdvanceModelCopyWith<$Res> implements $CashAdvanceModelCopyWith<$Res> {
  factory _$CashAdvanceModelCopyWith(_CashAdvanceModel value, $Res Function(_CashAdvanceModel) _then) = __$CashAdvanceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String branchId, String userId, double amountRequested, double? amountApproved, String? reason, ApprovalStatus status, DateTime createdAt, DateTime? approvedAt, String? rejectionReason
});




}
/// @nodoc
class __$CashAdvanceModelCopyWithImpl<$Res>
    implements _$CashAdvanceModelCopyWith<$Res> {
  __$CashAdvanceModelCopyWithImpl(this._self, this._then);

  final _CashAdvanceModel _self;
  final $Res Function(_CashAdvanceModel) _then;

/// Create a copy of CashAdvanceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = null,Object? userId = null,Object? amountRequested = null,Object? amountApproved = freezed,Object? reason = freezed,Object? status = null,Object? createdAt = null,Object? approvedAt = freezed,Object? rejectionReason = freezed,}) {
  return _then(_CashAdvanceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amountRequested: null == amountRequested ? _self.amountRequested : amountRequested // ignore: cast_nullable_to_non_nullable
as double,amountApproved: freezed == amountApproved ? _self.amountApproved : amountApproved // ignore: cast_nullable_to_non_nullable
as double?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApprovalStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
