// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_block_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppBlockInfo _$AppBlockInfoFromJson(Map<String, dynamic> json) {
  return _AppBlockInfo.fromJson(json);
}

/// @nodoc
mixin _$AppBlockInfo {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  bool get blocked => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppBlockInfoCopyWith<AppBlockInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppBlockInfoCopyWith<$Res> {
  factory $AppBlockInfoCopyWith(
          AppBlockInfo value, $Res Function(AppBlockInfo) then) =
      _$AppBlockInfoCopyWithImpl<$Res, AppBlockInfo>;
  @useResult
  $Res call({int id, String name, String category, String icon, bool blocked});
}

/// @nodoc
class _$AppBlockInfoCopyWithImpl<$Res, $Val extends AppBlockInfo>
    implements $AppBlockInfoCopyWith<$Res> {
  _$AppBlockInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? icon = null,
    Object? blocked = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      blocked: null == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppBlockInfoImplCopyWith<$Res>
    implements $AppBlockInfoCopyWith<$Res> {
  factory _$$AppBlockInfoImplCopyWith(
          _$AppBlockInfoImpl value, $Res Function(_$AppBlockInfoImpl) then) =
      __$$AppBlockInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String category, String icon, bool blocked});
}

/// @nodoc
class __$$AppBlockInfoImplCopyWithImpl<$Res>
    extends _$AppBlockInfoCopyWithImpl<$Res, _$AppBlockInfoImpl>
    implements _$$AppBlockInfoImplCopyWith<$Res> {
  __$$AppBlockInfoImplCopyWithImpl(
      _$AppBlockInfoImpl _value, $Res Function(_$AppBlockInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? icon = null,
    Object? blocked = null,
  }) {
    return _then(_$AppBlockInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      blocked: null == blocked
          ? _value.blocked
          : blocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppBlockInfoImpl implements _AppBlockInfo {
  const _$AppBlockInfoImpl(
      {required this.id,
      required this.name,
      required this.category,
      required this.icon,
      this.blocked = false});

  factory _$AppBlockInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppBlockInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String icon;
  @override
  @JsonKey()
  final bool blocked;

  @override
  String toString() {
    return 'AppBlockInfo(id: $id, name: $name, category: $category, icon: $icon, blocked: $blocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppBlockInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.blocked, blocked) || other.blocked == blocked));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, category, icon, blocked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppBlockInfoImplCopyWith<_$AppBlockInfoImpl> get copyWith =>
      __$$AppBlockInfoImplCopyWithImpl<_$AppBlockInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppBlockInfoImplToJson(
      this,
    );
  }
}

abstract class _AppBlockInfo implements AppBlockInfo {
  const factory _AppBlockInfo(
      {required final int id,
      required final String name,
      required final String category,
      required final String icon,
      final bool blocked}) = _$AppBlockInfoImpl;

  factory _AppBlockInfo.fromJson(Map<String, dynamic> json) =
      _$AppBlockInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get icon;
  @override
  bool get blocked;
  @override
  @JsonKey(ignore: true)
  _$$AppBlockInfoImplCopyWith<_$AppBlockInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
