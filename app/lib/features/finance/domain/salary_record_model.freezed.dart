// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salary_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SalaryRecordModel {

 String get id; String get branchId; String get userId; DateTime get periodEnd; double get grossSalary; double get cashAdvanceDeduction; double get netSalary; DateTime get createdAt;
/// Create a copy of SalaryRecordModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalaryRecordModelCopyWith<SalaryRecordModel> get copyWith => _$SalaryRecordModelCopyWithImpl<SalaryRecordModel>(this as SalaryRecordModel, _$identity);

  /// Serializes this SalaryRecordModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalaryRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.grossSalary, grossSalary) || other.grossSalary == grossSalary)&&(identical(other.cashAdvanceDeduction, cashAdvanceDeduction) || other.cashAdvanceDeduction == cashAdvanceDeduction)&&(identical(other.netSalary, netSalary) || other.netSalary == netSalary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,userId,periodEnd,grossSalary,cashAdvanceDeduction,netSalary,createdAt);

@override
String toString() {
  return 'SalaryRecordModel(id: $id, branchId: $branchId, userId: $userId, periodEnd: $periodEnd, grossSalary: $grossSalary, cashAdvanceDeduction: $cashAdvanceDeduction, netSalary: $netSalary, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SalaryRecordModelCopyWith<$Res>  {
  factory $SalaryRecordModelCopyWith(SalaryRecordModel value, $Res Function(SalaryRecordModel) _then) = _$SalaryRecordModelCopyWithImpl;
@useResult
$Res call({
 String id, String branchId, String userId, DateTime periodEnd, double grossSalary, double cashAdvanceDeduction, double netSalary, DateTime createdAt
});




}
/// @nodoc
class _$SalaryRecordModelCopyWithImpl<$Res>
    implements $SalaryRecordModelCopyWith<$Res> {
  _$SalaryRecordModelCopyWithImpl(this._self, this._then);

  final SalaryRecordModel _self;
  final $Res Function(SalaryRecordModel) _then;

/// Create a copy of SalaryRecordModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = null,Object? userId = null,Object? periodEnd = null,Object? grossSalary = null,Object? cashAdvanceDeduction = null,Object? netSalary = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,grossSalary: null == grossSalary ? _self.grossSalary : grossSalary // ignore: cast_nullable_to_non_nullable
as double,cashAdvanceDeduction: null == cashAdvanceDeduction ? _self.cashAdvanceDeduction : cashAdvanceDeduction // ignore: cast_nullable_to_non_nullable
as double,netSalary: null == netSalary ? _self.netSalary : netSalary // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SalaryRecordModel].
extension SalaryRecordModelPatterns on SalaryRecordModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalaryRecordModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalaryRecordModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalaryRecordModel value)  $default,){
final _that = this;
switch (_that) {
case _SalaryRecordModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalaryRecordModel value)?  $default,){
final _that = this;
switch (_that) {
case _SalaryRecordModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String branchId,  String userId,  DateTime periodEnd,  double grossSalary,  double cashAdvanceDeduction,  double netSalary,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalaryRecordModel() when $default != null:
return $default(_that.id,_that.branchId,_that.userId,_that.periodEnd,_that.grossSalary,_that.cashAdvanceDeduction,_that.netSalary,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String branchId,  String userId,  DateTime periodEnd,  double grossSalary,  double cashAdvanceDeduction,  double netSalary,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SalaryRecordModel():
return $default(_that.id,_that.branchId,_that.userId,_that.periodEnd,_that.grossSalary,_that.cashAdvanceDeduction,_that.netSalary,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String branchId,  String userId,  DateTime periodEnd,  double grossSalary,  double cashAdvanceDeduction,  double netSalary,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SalaryRecordModel() when $default != null:
return $default(_that.id,_that.branchId,_that.userId,_that.periodEnd,_that.grossSalary,_that.cashAdvanceDeduction,_that.netSalary,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SalaryRecordModel implements SalaryRecordModel {
  const _SalaryRecordModel({required this.id, required this.branchId, required this.userId, required this.periodEnd, required this.grossSalary, required this.cashAdvanceDeduction, required this.netSalary, required this.createdAt});
  factory _SalaryRecordModel.fromJson(Map<String, dynamic> json) => _$SalaryRecordModelFromJson(json);

@override final  String id;
@override final  String branchId;
@override final  String userId;
@override final  DateTime periodEnd;
@override final  double grossSalary;
@override final  double cashAdvanceDeduction;
@override final  double netSalary;
@override final  DateTime createdAt;

/// Create a copy of SalaryRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalaryRecordModelCopyWith<_SalaryRecordModel> get copyWith => __$SalaryRecordModelCopyWithImpl<_SalaryRecordModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SalaryRecordModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalaryRecordModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.periodEnd, periodEnd) || other.periodEnd == periodEnd)&&(identical(other.grossSalary, grossSalary) || other.grossSalary == grossSalary)&&(identical(other.cashAdvanceDeduction, cashAdvanceDeduction) || other.cashAdvanceDeduction == cashAdvanceDeduction)&&(identical(other.netSalary, netSalary) || other.netSalary == netSalary)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,userId,periodEnd,grossSalary,cashAdvanceDeduction,netSalary,createdAt);

@override
String toString() {
  return 'SalaryRecordModel(id: $id, branchId: $branchId, userId: $userId, periodEnd: $periodEnd, grossSalary: $grossSalary, cashAdvanceDeduction: $cashAdvanceDeduction, netSalary: $netSalary, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SalaryRecordModelCopyWith<$Res> implements $SalaryRecordModelCopyWith<$Res> {
  factory _$SalaryRecordModelCopyWith(_SalaryRecordModel value, $Res Function(_SalaryRecordModel) _then) = __$SalaryRecordModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String branchId, String userId, DateTime periodEnd, double grossSalary, double cashAdvanceDeduction, double netSalary, DateTime createdAt
});




}
/// @nodoc
class __$SalaryRecordModelCopyWithImpl<$Res>
    implements _$SalaryRecordModelCopyWith<$Res> {
  __$SalaryRecordModelCopyWithImpl(this._self, this._then);

  final _SalaryRecordModel _self;
  final $Res Function(_SalaryRecordModel) _then;

/// Create a copy of SalaryRecordModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = null,Object? userId = null,Object? periodEnd = null,Object? grossSalary = null,Object? cashAdvanceDeduction = null,Object? netSalary = null,Object? createdAt = null,}) {
  return _then(_SalaryRecordModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,periodEnd: null == periodEnd ? _self.periodEnd : periodEnd // ignore: cast_nullable_to_non_nullable
as DateTime,grossSalary: null == grossSalary ? _self.grossSalary : grossSalary // ignore: cast_nullable_to_non_nullable
as double,cashAdvanceDeduction: null == cashAdvanceDeduction ? _self.cashAdvanceDeduction : cashAdvanceDeduction // ignore: cast_nullable_to_non_nullable
as double,netSalary: null == netSalary ? _self.netSalary : netSalary // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
