// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SocialState {
  List<SocialPost> get posts => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SocialStateCopyWith<SocialState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialStateCopyWith<$Res> {
  factory $SocialStateCopyWith(
          SocialState value, $Res Function(SocialState) then) =
      _$SocialStateCopyWithImpl<$Res, SocialState>;
  @useResult
  $Res call(
      {List<SocialPost> posts,
      bool isLoading,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class _$SocialStateCopyWithImpl<$Res, $Val extends SocialState>
    implements $SocialStateCopyWith<$Res> {
  _$SocialStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      posts: null == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<SocialPost>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialStateImplCopyWith<$Res>
    implements $SocialStateCopyWith<$Res> {
  factory _$$SocialStateImplCopyWith(
          _$SocialStateImpl value, $Res Function(_$SocialStateImpl) then) =
      __$$SocialStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SocialPost> posts,
      bool isLoading,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class __$$SocialStateImplCopyWithImpl<$Res>
    extends _$SocialStateCopyWithImpl<$Res, _$SocialStateImpl>
    implements _$$SocialStateImplCopyWith<$Res> {
  __$$SocialStateImplCopyWithImpl(
      _$SocialStateImpl _value, $Res Function(_$SocialStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$SocialStateImpl(
      posts: null == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<SocialPost>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isError: null == isError
          ? _value.isError
          : isError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SocialStateImpl implements _SocialState {
  const _$SocialStateImpl(
      {final List<SocialPost> posts = const [],
      this.isLoading = true,
      this.isError = false,
      this.errorMessage})
      : _posts = posts;

  final List<SocialPost> _posts;
  @override
  @JsonKey()
  List<SocialPost> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isError;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SocialState(posts: $posts, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialStateImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_posts),
      isLoading,
      isError,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialStateImplCopyWith<_$SocialStateImpl> get copyWith =>
      __$$SocialStateImplCopyWithImpl<_$SocialStateImpl>(this, _$identity);
}

abstract class _SocialState implements SocialState {
  const factory _SocialState(
      {final List<SocialPost> posts,
      final bool isLoading,
      final bool isError,
      final String? errorMessage}) = _$SocialStateImpl;

  @override
  List<SocialPost> get posts;
  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$SocialStateImplCopyWith<_$SocialStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
