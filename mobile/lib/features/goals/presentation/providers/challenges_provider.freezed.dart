// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenges_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChallengesState {
  List<AppChallenge> get challenges => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChallengesStateCopyWith<ChallengesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengesStateCopyWith<$Res> {
  factory $ChallengesStateCopyWith(
          ChallengesState value, $Res Function(ChallengesState) then) =
      _$ChallengesStateCopyWithImpl<$Res, ChallengesState>;
  @useResult
  $Res call(
      {List<AppChallenge> challenges,
      bool isLoading,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class _$ChallengesStateCopyWithImpl<$Res, $Val extends ChallengesState>
    implements $ChallengesStateCopyWith<$Res> {
  _$ChallengesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challenges = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      challenges: null == challenges
          ? _value.challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as List<AppChallenge>,
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
abstract class _$$ChallengesStateImplCopyWith<$Res>
    implements $ChallengesStateCopyWith<$Res> {
  factory _$$ChallengesStateImplCopyWith(_$ChallengesStateImpl value,
          $Res Function(_$ChallengesStateImpl) then) =
      __$$ChallengesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AppChallenge> challenges,
      bool isLoading,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class __$$ChallengesStateImplCopyWithImpl<$Res>
    extends _$ChallengesStateCopyWithImpl<$Res, _$ChallengesStateImpl>
    implements _$$ChallengesStateImplCopyWith<$Res> {
  __$$ChallengesStateImplCopyWithImpl(
      _$ChallengesStateImpl _value, $Res Function(_$ChallengesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? challenges = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ChallengesStateImpl(
      challenges: null == challenges
          ? _value._challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as List<AppChallenge>,
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

class _$ChallengesStateImpl implements _ChallengesState {
  const _$ChallengesStateImpl(
      {final List<AppChallenge> challenges = const [],
      this.isLoading = true,
      this.isError = false,
      this.errorMessage})
      : _challenges = challenges;

  final List<AppChallenge> _challenges;
  @override
  @JsonKey()
  List<AppChallenge> get challenges {
    if (_challenges is EqualUnmodifiableListView) return _challenges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_challenges);
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
    return 'ChallengesState(challenges: $challenges, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengesStateImpl &&
            const DeepCollectionEquality()
                .equals(other._challenges, _challenges) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_challenges),
      isLoading,
      isError,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengesStateImplCopyWith<_$ChallengesStateImpl> get copyWith =>
      __$$ChallengesStateImplCopyWithImpl<_$ChallengesStateImpl>(
          this, _$identity);
}

abstract class _ChallengesState implements ChallengesState {
  const factory _ChallengesState(
      {final List<AppChallenge> challenges,
      final bool isLoading,
      final bool isError,
      final String? errorMessage}) = _$ChallengesStateImpl;

  @override
  List<AppChallenge> get challenges;
  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$ChallengesStateImplCopyWith<_$ChallengesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
