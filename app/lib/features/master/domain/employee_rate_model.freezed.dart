// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_rate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmployeeRateModel {

 String get id; String? get branchId; String get employeeId; String get operationType; double get ratePerPiece; bool get isActive;
/// Create a copy of EmployeeRateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeRateModelCopyWith<EmployeeRateModel> get copyWith => _$EmployeeRateModelCopyWithImpl<EmployeeRateModel>(this as EmployeeRateModel, _$identity);

  /// Serializes this EmployeeRateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeRateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.operationType, operationType) || other.operationType == operationType)&&(identical(other.ratePerPiece, ratePerPiece) || other.ratePerPiece == ratePerPiece)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,employeeId,operationType,ratePerPiece,isActive);

@override
String toString() {
  return 'EmployeeRateModel(id: $id, branchId: $branchId, employeeId: $employeeId, operationType: $operationType, ratePerPiece: $ratePerPiece, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $EmployeeRateModelCopyWith<$Res>  {
  factory $EmployeeRateModelCopyWith(EmployeeRateModel value, $Res Function(EmployeeRateModel) _then) = _$EmployeeRateModelCopyWithImpl;
@useResult
$Res call({
 String id, String? branchId, String employeeId, String operationType, double ratePerPiece, bool isActive
});




}
/// @nodoc
class _$EmployeeRateModelCopyWithImpl<$Res>
    implements $EmployeeRateModelCopyWith<$Res> {
  _$EmployeeRateModelCopyWithImpl(this._self, this._then);

  final EmployeeRateModel _self;
  final $Res Function(EmployeeRateModel) _then;

/// Create a copy of EmployeeRateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = freezed,Object? employeeId = null,Object? operationType = null,Object? ratePerPiece = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,operationType: null == operationType ? _self.operationType : operationType // ignore: cast_nullable_to_non_nullable
as String,ratePerPiece: null == ratePerPiece ? _self.ratePerPiece : ratePerPiece // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeRateModel].
extension EmployeeRateModelPatterns on EmployeeRateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeRateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeRateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeRateModel value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeRateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeRateModel value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeRateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? branchId,  String employeeId,  String operationType,  double ratePerPiece,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeRateModel() when $default != null:
return $default(_that.id,_that.branchId,_that.employeeId,_that.operationType,_that.ratePerPiece,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? branchId,  String employeeId,  String operationType,  double ratePerPiece,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _EmployeeRateModel():
return $default(_that.id,_that.branchId,_that.employeeId,_that.operationType,_that.ratePerPiece,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? branchId,  String employeeId,  String operationType,  double ratePerPiece,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeRateModel() when $default != null:
return $default(_that.id,_that.branchId,_that.employeeId,_that.operationType,_that.ratePerPiece,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeRateModel implements EmployeeRateModel {
  const _EmployeeRateModel({required this.id, this.branchId, required this.employeeId, required this.operationType, required this.ratePerPiece, this.isActive = true});
  factory _EmployeeRateModel.fromJson(Map<String, dynamic> json) => _$EmployeeRateModelFromJson(json);

@override final  String id;
@override final  String? branchId;
@override final  String employeeId;
@override final  String operationType;
@override final  double ratePerPiece;
@override@JsonKey() final  bool isActive;

/// Create a copy of EmployeeRateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeRateModelCopyWith<_EmployeeRateModel> get copyWith => __$EmployeeRateModelCopyWithImpl<_EmployeeRateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeRateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeRateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.operationType, operationType) || other.operationType == operationType)&&(identical(other.ratePerPiece, ratePerPiece) || other.ratePerPiece == ratePerPiece)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,employeeId,operationType,ratePerPiece,isActive);

@override
String toString() {
  return 'EmployeeRateModel(id: $id, branchId: $branchId, employeeId: $employeeId, operationType: $operationType, ratePerPiece: $ratePerPiece, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$EmployeeRateModelCopyWith<$Res> implements $EmployeeRateModelCopyWith<$Res> {
  factory _$EmployeeRateModelCopyWith(_EmployeeRateModel value, $Res Function(_EmployeeRateModel) _then) = __$EmployeeRateModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? branchId, String employeeId, String operationType, double ratePerPiece, bool isActive
});




}
/// @nodoc
class __$EmployeeRateModelCopyWithImpl<$Res>
    implements _$EmployeeRateModelCopyWith<$Res> {
  __$EmployeeRateModelCopyWithImpl(this._self, this._then);

  final _EmployeeRateModel _self;
  final $Res Function(_EmployeeRateModel) _then;

/// Create a copy of EmployeeRateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = freezed,Object? employeeId = null,Object? operationType = null,Object? ratePerPiece = null,Object? isActive = null,}) {
  return _then(_EmployeeRateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,operationType: null == operationType ? _self.operationType : operationType // ignore: cast_nullable_to_non_nullable
as String,ratePerPiece: null == ratePerPiece ? _self.ratePerPiece : ratePerPiece // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
