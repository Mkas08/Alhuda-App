// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SessionState {
  String? get sessionId => throw _privateConstructorUsedError;
  bool get isFocusMode => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get elapsedSeconds => throw _privateConstructorUsedError;
  int get versesReadSession => throw _privateConstructorUsedError;
  int get hasanatEarned => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SessionStateCopyWith<SessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
          SessionState value, $Res Function(SessionState) then) =
      _$SessionStateCopyWithImpl<$Res, SessionState>;
  @useResult
  $Res call(
      {String? sessionId,
      bool isFocusMode,
      bool isActive,
      int elapsedSeconds,
      int versesReadSession,
      int hasanatEarned});
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = freezed,
    Object? isFocusMode = null,
    Object? isActive = null,
    Object? elapsedSeconds = null,
    Object? versesReadSession = null,
    Object? hasanatEarned = null,
  }) {
    return _then(_value.copyWith(
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isFocusMode: null == isFocusMode
          ? _value.isFocusMode
          : isFocusMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      elapsedSeconds: null == elapsedSeconds
          ? _value.elapsedSeconds
          : elapsedSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      versesReadSession: null == versesReadSession
          ? _value.versesReadSession
          : versesReadSession // ignore: cast_nullable_to_non_nullable
              as int,
      hasanatEarned: null == hasanatEarned
          ? _value.hasanatEarned
          : hasanatEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionStateImplCopyWith<$Res>
    implements $SessionStateCopyWith<$Res> {
  factory _$$SessionStateImplCopyWith(
          _$SessionStateImpl value, $Res Function(_$SessionStateImpl) then) =
      __$$SessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? sessionId,
      bool isFocusMode,
      bool isActive,
      int elapsedSeconds,
      int versesReadSession,
      int hasanatEarned});
}

/// @nodoc
class __$$SessionStateImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionStateImpl>
    implements _$$SessionStateImplCopyWith<$Res> {
  __$$SessionStateImplCopyWithImpl(
      _$SessionStateImpl _value, $Res Function(_$SessionStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = freezed,
    Object? isFocusMode = null,
    Object? isActive = null,
    Object? elapsedSeconds = null,
    Object? versesReadSession = null,
    Object? hasanatEarned = null,
  }) {
    return _then(_$SessionStateImpl(
      sessionId: freezed == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isFocusMode: null == isFocusMode
          ? _value.isFocusMode
          : isFocusMode // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      elapsedSeconds: null == elapsedSeconds
          ? _value.elapsedSeconds
          : elapsedSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      versesReadSession: null == versesReadSession
          ? _value.versesReadSession
          : versesReadSession // ignore: cast_nullable_to_non_nullable
              as int,
      hasanatEarned: null == hasanatEarned
          ? _value.hasanatEarned
          : hasanatEarned // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SessionStateImpl implements _SessionState {
  const _$SessionStateImpl(
      {this.sessionId,
      this.isFocusMode = false,
      this.isActive = false,
      this.elapsedSeconds = 0,
      this.versesReadSession = 0,
      this.hasanatEarned = 0});

  @override
  final String? sessionId;
  @override
  @JsonKey()
  final bool isFocusMode;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int elapsedSeconds;
  @override
  @JsonKey()
  final int versesReadSession;
  @override
  @JsonKey()
  final int hasanatEarned;

  @override
  String toString() {
    return 'SessionState(sessionId: $sessionId, isFocusMode: $isFocusMode, isActive: $isActive, elapsedSeconds: $elapsedSeconds, versesReadSession: $versesReadSession, hasanatEarned: $hasanatEarned)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionStateImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.isFocusMode, isFocusMode) ||
                other.isFocusMode == isFocusMode) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.elapsedSeconds, elapsedSeconds) ||
                other.elapsedSeconds == elapsedSeconds) &&
            (identical(other.versesReadSession, versesReadSession) ||
                other.versesReadSession == versesReadSession) &&
            (identical(other.hasanatEarned, hasanatEarned) ||
                other.hasanatEarned == hasanatEarned));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId, isFocusMode, isActive,
      elapsedSeconds, versesReadSession, hasanatEarned);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      __$$SessionStateImplCopyWithImpl<_$SessionStateImpl>(this, _$identity);
}

abstract class _SessionState implements SessionState {
  const factory _SessionState(
      {final String? sessionId,
      final bool isFocusMode,
      final bool isActive,
      final int elapsedSeconds,
      final int versesReadSession,
      final int hasanatEarned}) = _$SessionStateImpl;

  @override
  String? get sessionId;
  @override
  bool get isFocusMode;
  @override
  bool get isActive;
  @override
  int get elapsedSeconds;
  @override
  int get versesReadSession;
  @override
  int get hasanatEarned;
  @override
  @JsonKey(ignore: true)
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
