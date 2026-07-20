// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'size_group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SizeGroupModel {

 String get id; String? get branchId; String get name; List<String> get sizes;
/// Create a copy of SizeGroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SizeGroupModelCopyWith<SizeGroupModel> get copyWith => _$SizeGroupModelCopyWithImpl<SizeGroupModel>(this as SizeGroupModel, _$identity);

  /// Serializes this SizeGroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SizeGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.sizes, sizes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,name,const DeepCollectionEquality().hash(sizes));

@override
String toString() {
  return 'SizeGroupModel(id: $id, branchId: $branchId, name: $name, sizes: $sizes)';
}


}

/// @nodoc
abstract mixin class $SizeGroupModelCopyWith<$Res>  {
  factory $SizeGroupModelCopyWith(SizeGroupModel value, $Res Function(SizeGroupModel) _then) = _$SizeGroupModelCopyWithImpl;
@useResult
$Res call({
 String id, String? branchId, String name, List<String> sizes
});




}
/// @nodoc
class _$SizeGroupModelCopyWithImpl<$Res>
    implements $SizeGroupModelCopyWith<$Res> {
  _$SizeGroupModelCopyWithImpl(this._self, this._then);

  final SizeGroupModel _self;
  final $Res Function(SizeGroupModel) _then;

/// Create a copy of SizeGroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? branchId = freezed,Object? name = null,Object? sizes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sizes: null == sizes ? _self.sizes : sizes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SizeGroupModel].
extension SizeGroupModelPatterns on SizeGroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SizeGroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SizeGroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SizeGroupModel value)  $default,){
final _that = this;
switch (_that) {
case _SizeGroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SizeGroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _SizeGroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? branchId,  String name,  List<String> sizes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SizeGroupModel() when $default != null:
return $default(_that.id,_that.branchId,_that.name,_that.sizes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? branchId,  String name,  List<String> sizes)  $default,) {final _that = this;
switch (_that) {
case _SizeGroupModel():
return $default(_that.id,_that.branchId,_that.name,_that.sizes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? branchId,  String name,  List<String> sizes)?  $default,) {final _that = this;
switch (_that) {
case _SizeGroupModel() when $default != null:
return $default(_that.id,_that.branchId,_that.name,_that.sizes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SizeGroupModel implements SizeGroupModel {
  const _SizeGroupModel({required this.id, this.branchId, required this.name, required final  List<String> sizes}): _sizes = sizes;
  factory _SizeGroupModel.fromJson(Map<String, dynamic> json) => _$SizeGroupModelFromJson(json);

@override final  String id;
@override final  String? branchId;
@override final  String name;
 final  List<String> _sizes;
@override List<String> get sizes {
  if (_sizes is EqualUnmodifiableListView) return _sizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sizes);
}


/// Create a copy of SizeGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SizeGroupModelCopyWith<_SizeGroupModel> get copyWith => __$SizeGroupModelCopyWithImpl<_SizeGroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SizeGroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SizeGroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.branchId, branchId) || other.branchId == branchId)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._sizes, _sizes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,branchId,name,const DeepCollectionEquality().hash(_sizes));

@override
String toString() {
  return 'SizeGroupModel(id: $id, branchId: $branchId, name: $name, sizes: $sizes)';
}


}

/// @nodoc
abstract mixin class _$SizeGroupModelCopyWith<$Res> implements $SizeGroupModelCopyWith<$Res> {
  factory _$SizeGroupModelCopyWith(_SizeGroupModel value, $Res Function(_SizeGroupModel) _then) = __$SizeGroupModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? branchId, String name, List<String> sizes
});




}
/// @nodoc
class __$SizeGroupModelCopyWithImpl<$Res>
    implements _$SizeGroupModelCopyWith<$Res> {
  __$SizeGroupModelCopyWithImpl(this._self, this._then);

  final _SizeGroupModel _self;
  final $Res Function(_SizeGroupModel) _then;

/// Create a copy of SizeGroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? branchId = freezed,Object? name = null,Object? sizes = null,}) {
  return _then(_SizeGroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,branchId: freezed == branchId ? _self.branchId : branchId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,sizes: null == sizes ? _self._sizes : sizes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
