// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'branch_setting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BranchSettingModel {

 String get branchId; String? get paymentSystem; int? get maxKasbonPercentage; String? get contactWa; String? get bankAccountInfo;
/// Create a copy of BranchSettingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BranchSettingModelCopyWith<BranchSettingModel> get copyWith => _$BranchSettingModelCopyWithImpl<BranchSettingModel>(this as BranchSettingModel, _$identity);

  /// Serializes this BranchSettingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BranchSettingModel&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.paymentSystem, paymentSystem) || other.paymentSystem == paymentSystem)&&(identical(other.maxKasbonPercentage, maxKasbonPercentage) || other.maxKasbonPercentage == maxKasbonPercentage)&&(identical(other.contactWa, contactWa) || other.contactWa == contactWa)&&(identical(other.bankAccountInfo, bankAccountInfo) || other.bankAccountInfo == bankAccountInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchId,paymentSystem,maxKasbonPercentage,contactWa,bankAccountInfo);

@override
String toString() {
  return 'BranchSettingModel(branchId: $branchId, paymentSystem: $paymentSystem, maxKasbonPercentage: $maxKasbonPercentage, contactWa: $contactWa, bankAccountInfo: $bankAccountInfo)';
}


}

/// @nodoc
abstract mixin class $BranchSettingModelCopyWith<$Res>  {
  factory $BranchSettingModelCopyWith(BranchSettingModel value, $Res Function(BranchSettingModel) _then) = _$BranchSettingModelCopyWithImpl;
@useResult
$Res call({
 String branchId, String? paymentSystem, int? maxKasbonPercentage, String? contactWa, String? bankAccountInfo
});




}
/// @nodoc
class _$BranchSettingModelCopyWithImpl<$Res>
    implements $BranchSettingModelCopyWith<$Res> {
  _$BranchSettingModelCopyWithImpl(this._self, this._then);

  final BranchSettingModel _self;
  final $Res Function(BranchSettingModel) _then;

/// Create a copy of BranchSettingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? branchId = null,Object? paymentSystem = freezed,Object? maxKasbonPercentage = freezed,Object? contactWa = freezed,Object? bankAccountInfo = freezed,}) {
  return _then(_self.copyWith(
branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,paymentSystem: freezed == paymentSystem ? _self.paymentSystem : paymentSystem // ignore: cast_nullable_to_non_nullable
as String?,maxKasbonPercentage: freezed == maxKasbonPercentage ? _self.maxKasbonPercentage : maxKasbonPercentage // ignore: cast_nullable_to_non_nullable
as int?,contactWa: freezed == contactWa ? _self.contactWa : contactWa // ignore: cast_nullable_to_non_nullable
as String?,bankAccountInfo: freezed == bankAccountInfo ? _self.bankAccountInfo : bankAccountInfo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BranchSettingModel].
extension BranchSettingModelPatterns on BranchSettingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BranchSettingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BranchSettingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BranchSettingModel value)  $default,){
final _that = this;
switch (_that) {
case _BranchSettingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BranchSettingModel value)?  $default,){
final _that = this;
switch (_that) {
case _BranchSettingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String branchId,  String? paymentSystem,  int? maxKasbonPercentage,  String? contactWa,  String? bankAccountInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BranchSettingModel() when $default != null:
return $default(_that.branchId,_that.paymentSystem,_that.maxKasbonPercentage,_that.contactWa,_that.bankAccountInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String branchId,  String? paymentSystem,  int? maxKasbonPercentage,  String? contactWa,  String? bankAccountInfo)  $default,) {final _that = this;
switch (_that) {
case _BranchSettingModel():
return $default(_that.branchId,_that.paymentSystem,_that.maxKasbonPercentage,_that.contactWa,_that.bankAccountInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String branchId,  String? paymentSystem,  int? maxKasbonPercentage,  String? contactWa,  String? bankAccountInfo)?  $default,) {final _that = this;
switch (_that) {
case _BranchSettingModel() when $default != null:
return $default(_that.branchId,_that.paymentSystem,_that.maxKasbonPercentage,_that.contactWa,_that.bankAccountInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BranchSettingModel implements BranchSettingModel {
  const _BranchSettingModel({required this.branchId, this.paymentSystem, this.maxKasbonPercentage, this.contactWa, this.bankAccountInfo});
  factory _BranchSettingModel.fromJson(Map<String, dynamic> json) => _$BranchSettingModelFromJson(json);

@override final  String branchId;
@override final  String? paymentSystem;
@override final  int? maxKasbonPercentage;
@override final  String? contactWa;
@override final  String? bankAccountInfo;

/// Create a copy of BranchSettingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BranchSettingModelCopyWith<_BranchSettingModel> get copyWith => __$BranchSettingModelCopyWithImpl<_BranchSettingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BranchSettingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BranchSettingModel&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.paymentSystem, paymentSystem) || other.paymentSystem == paymentSystem)&&(identical(other.maxKasbonPercentage, maxKasbonPercentage) || other.maxKasbonPercentage == maxKasbonPercentage)&&(identical(other.contactWa, contactWa) || other.contactWa == contactWa)&&(identical(other.bankAccountInfo, bankAccountInfo) || other.bankAccountInfo == bankAccountInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,branchId,paymentSystem,maxKasbonPercentage,contactWa,bankAccountInfo);

@override
String toString() {
  return 'BranchSettingModel(branchId: $branchId, paymentSystem: $paymentSystem, maxKasbonPercentage: $maxKasbonPercentage, contactWa: $contactWa, bankAccountInfo: $bankAccountInfo)';
}


}

/// @nodoc
abstract mixin class _$BranchSettingModelCopyWith<$Res> implements $BranchSettingModelCopyWith<$Res> {
  factory _$BranchSettingModelCopyWith(_BranchSettingModel value, $Res Function(_BranchSettingModel) _then) = __$BranchSettingModelCopyWithImpl;
@override @useResult
$Res call({
 String branchId, String? paymentSystem, int? maxKasbonPercentage, String? contactWa, String? bankAccountInfo
});




}
/// @nodoc
class __$BranchSettingModelCopyWithImpl<$Res>
    implements _$BranchSettingModelCopyWith<$Res> {
  __$BranchSettingModelCopyWithImpl(this._self, this._then);

  final _BranchSettingModel _self;
  final $Res Function(_BranchSettingModel) _then;

/// Create a copy of BranchSettingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? branchId = null,Object? paymentSystem = freezed,Object? maxKasbonPercentage = freezed,Object? contactWa = freezed,Object? bankAccountInfo = freezed,}) {
  return _then(_BranchSettingModel(
branchId: null == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String,paymentSystem: freezed == paymentSystem ? _self.paymentSystem : paymentSystem // ignore: cast_nullable_to_non_nullable
as String?,maxKasbonPercentage: freezed == maxKasbonPercentage ? _self.maxKasbonPercentage : maxKasbonPercentage // ignore: cast_nullable_to_non_nullable
as int?,contactWa: freezed == contactWa ? _self.contactWa : contactWa // ignore: cast_nullable_to_non_nullable
as String?,bankAccountInfo: freezed == bankAccountInfo ? _self.bankAccountInfo : bankAccountInfo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
