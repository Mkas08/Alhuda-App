// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_mode_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FocusModeState {
  bool get isEnabled => throw _privateConstructorUsedError;
  List<AppBlockInfo> get apps => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FocusModeStateCopyWith<FocusModeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FocusModeStateCopyWith<$Res> {
  factory $FocusModeStateCopyWith(
          FocusModeState value, $Res Function(FocusModeState) then) =
      _$FocusModeStateCopyWithImpl<$Res, FocusModeState>;
  @useResult
  $Res call({bool isEnabled, List<AppBlockInfo> apps, bool isLoading});
}

/// @nodoc
class _$FocusModeStateCopyWithImpl<$Res, $Val extends FocusModeState>
    implements $FocusModeStateCopyWith<$Res> {
  _$FocusModeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? apps = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      apps: null == apps
          ? _value.apps
          : apps // ignore: cast_nullable_to_non_nullable
              as List<AppBlockInfo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FocusModeStateImplCopyWith<$Res>
    implements $FocusModeStateCopyWith<$Res> {
  factory _$$FocusModeStateImplCopyWith(_$FocusModeStateImpl value,
          $Res Function(_$FocusModeStateImpl) then) =
      __$$FocusModeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isEnabled, List<AppBlockInfo> apps, bool isLoading});
}

/// @nodoc
class __$$FocusModeStateImplCopyWithImpl<$Res>
    extends _$FocusModeStateCopyWithImpl<$Res, _$FocusModeStateImpl>
    implements _$$FocusModeStateImplCopyWith<$Res> {
  __$$FocusModeStateImplCopyWithImpl(
      _$FocusModeStateImpl _value, $Res Function(_$FocusModeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEnabled = null,
    Object? apps = null,
    Object? isLoading = null,
  }) {
    return _then(_$FocusModeStateImpl(
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      apps: null == apps
          ? _value._apps
          : apps // ignore: cast_nullable_to_non_nullable
              as List<AppBlockInfo>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FocusModeStateImpl implements _FocusModeState {
  const _$FocusModeStateImpl(
      {this.isEnabled = false,
      final List<AppBlockInfo> apps = const [],
      this.isLoading = true})
      : _apps = apps;

  @override
  @JsonKey()
  final bool isEnabled;
  final List<AppBlockInfo> _apps;
  @override
  @JsonKey()
  List<AppBlockInfo> get apps {
    if (_apps is EqualUnmodifiableListView) return _apps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_apps);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'FocusModeState(isEnabled: $isEnabled, apps: $apps, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FocusModeStateImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            const DeepCollectionEquality().equals(other._apps, _apps) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnabled,
      const DeepCollectionEquality().hash(_apps), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FocusModeStateImplCopyWith<_$FocusModeStateImpl> get copyWith =>
      __$$FocusModeStateImplCopyWithImpl<_$FocusModeStateImpl>(
          this, _$identity);
}

abstract class _FocusModeState implements FocusModeState {
  const factory _FocusModeState(
      {final bool isEnabled,
      final List<AppBlockInfo> apps,
      final bool isLoading}) = _$FocusModeStateImpl;

  @override
  bool get isEnabled;
  @override
  List<AppBlockInfo> get apps;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$FocusModeStateImplCopyWith<_$FocusModeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
