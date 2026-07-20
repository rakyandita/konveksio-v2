// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'adjustment_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdjustmentItemModel {

 String get id; String get orderId; String get name; double get amount; AdjustmentType get type;
/// Create a copy of AdjustmentItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdjustmentItemModelCopyWith<AdjustmentItemModel> get copyWith => _$AdjustmentItemModelCopyWithImpl<AdjustmentItemModel>(this as AdjustmentItemModel, _$identity);

  /// Serializes this AdjustmentItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdjustmentItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,name,amount,type);

@override
String toString() {
  return 'AdjustmentItemModel(id: $id, orderId: $orderId, name: $name, amount: $amount, type: $type)';
}


}

/// @nodoc
abstract mixin class $AdjustmentItemModelCopyWith<$Res>  {
  factory $AdjustmentItemModelCopyWith(AdjustmentItemModel value, $Res Function(AdjustmentItemModel) _then) = _$AdjustmentItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String orderId, String name, double amount, AdjustmentType type
});




}
/// @nodoc
class _$AdjustmentItemModelCopyWithImpl<$Res>
    implements $AdjustmentItemModelCopyWith<$Res> {
  _$AdjustmentItemModelCopyWithImpl(this._self, this._then);

  final AdjustmentItemModel _self;
  final $Res Function(AdjustmentItemModel) _then;

/// Create a copy of AdjustmentItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? orderId = null,Object? name = null,Object? amount = null,Object? type = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AdjustmentType,
  ));
}

}


/// Adds pattern-matching-related methods to [AdjustmentItemModel].
extension AdjustmentItemModelPatterns on AdjustmentItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdjustmentItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdjustmentItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdjustmentItemModel value)  $default,){
final _that = this;
switch (_that) {
case _AdjustmentItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdjustmentItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _AdjustmentItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String orderId,  String name,  double amount,  AdjustmentType type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdjustmentItemModel() when $default != null:
return $default(_that.id,_that.orderId,_that.name,_that.amount,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String orderId,  String name,  double amount,  AdjustmentType type)  $default,) {final _that = this;
switch (_that) {
case _AdjustmentItemModel():
return $default(_that.id,_that.orderId,_that.name,_that.amount,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String orderId,  String name,  double amount,  AdjustmentType type)?  $default,) {final _that = this;
switch (_that) {
case _AdjustmentItemModel() when $default != null:
return $default(_that.id,_that.orderId,_that.name,_that.amount,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdjustmentItemModel implements AdjustmentItemModel {
  const _AdjustmentItemModel({required this.id, required this.orderId, required this.name, required this.amount, required this.type});
  factory _AdjustmentItemModel.fromJson(Map<String, dynamic> json) => _$AdjustmentItemModelFromJson(json);

@override final  String id;
@override final  String orderId;
@override final  String name;
@override final  double amount;
@override final  AdjustmentType type;

/// Create a copy of AdjustmentItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdjustmentItemModelCopyWith<_AdjustmentItemModel> get copyWith => __$AdjustmentItemModelCopyWithImpl<_AdjustmentItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdjustmentItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdjustmentItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,orderId,name,amount,type);

@override
String toString() {
  return 'AdjustmentItemModel(id: $id, orderId: $orderId, name: $name, amount: $amount, type: $type)';
}


}

/// @nodoc
abstract mixin class _$AdjustmentItemModelCopyWith<$Res> implements $AdjustmentItemModelCopyWith<$Res> {
  factory _$AdjustmentItemModelCopyWith(_AdjustmentItemModel value, $Res Function(_AdjustmentItemModel) _then) = __$AdjustmentItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String orderId, String name, double amount, AdjustmentType type
});




}
/// @nodoc
class __$AdjustmentItemModelCopyWithImpl<$Res>
    implements _$AdjustmentItemModelCopyWith<$Res> {
  __$AdjustmentItemModelCopyWithImpl(this._self, this._then);

  final _AdjustmentItemModel _self;
  final $Res Function(_AdjustmentItemModel) _then;

/// Create a copy of AdjustmentItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? orderId = null,Object? name = null,Object? amount = null,Object? type = null,}) {
  return _then(_AdjustmentItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AdjustmentType,
  ));
}


}

// dart format on
