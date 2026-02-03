// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ReadingState {
  int get currentSurahNumber => throw _privateConstructorUsedError;
  int get currentVerseIndex => throw _privateConstructorUsedError;
  List<QuranVerse> get verses => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReadingStateCopyWith<ReadingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReadingStateCopyWith<$Res> {
  factory $ReadingStateCopyWith(
          ReadingState value, $Res Function(ReadingState) then) =
      _$ReadingStateCopyWithImpl<$Res, ReadingState>;
  @useResult
  $Res call(
      {int currentSurahNumber,
      int currentVerseIndex,
      List<QuranVerse> verses,
      bool isLoading,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class _$ReadingStateCopyWithImpl<$Res, $Val extends ReadingState>
    implements $ReadingStateCopyWith<$Res> {
  _$ReadingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSurahNumber = null,
    Object? currentVerseIndex = null,
    Object? verses = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      currentSurahNumber: null == currentSurahNumber
          ? _value.currentSurahNumber
          : currentSurahNumber // ignore: cast_nullable_to_non_nullable
              as int,
      currentVerseIndex: null == currentVerseIndex
          ? _value.currentVerseIndex
          : currentVerseIndex // ignore: cast_nullable_to_non_nullable
              as int,
      verses: null == verses
          ? _value.verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<QuranVerse>,
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
abstract class _$$ReadingStateImplCopyWith<$Res>
    implements $ReadingStateCopyWith<$Res> {
  factory _$$ReadingStateImplCopyWith(
          _$ReadingStateImpl value, $Res Function(_$ReadingStateImpl) then) =
      __$$ReadingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentSurahNumber,
      int currentVerseIndex,
      List<QuranVerse> verses,
      bool isLoading,
      bool isError,
      String? errorMessage});
}

/// @nodoc
class __$$ReadingStateImplCopyWithImpl<$Res>
    extends _$ReadingStateCopyWithImpl<$Res, _$ReadingStateImpl>
    implements _$$ReadingStateImplCopyWith<$Res> {
  __$$ReadingStateImplCopyWithImpl(
      _$ReadingStateImpl _value, $Res Function(_$ReadingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSurahNumber = null,
    Object? currentVerseIndex = null,
    Object? verses = null,
    Object? isLoading = null,
    Object? isError = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ReadingStateImpl(
      currentSurahNumber: null == currentSurahNumber
          ? _value.currentSurahNumber
          : currentSurahNumber // ignore: cast_nullable_to_non_nullable
              as int,
      currentVerseIndex: null == currentVerseIndex
          ? _value.currentVerseIndex
          : currentVerseIndex // ignore: cast_nullable_to_non_nullable
              as int,
      verses: null == verses
          ? _value._verses
          : verses // ignore: cast_nullable_to_non_nullable
              as List<QuranVerse>,
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

class _$ReadingStateImpl implements _ReadingState {
  const _$ReadingStateImpl(
      {this.currentSurahNumber = 1,
      this.currentVerseIndex = 0,
      final List<QuranVerse> verses = const [],
      this.isLoading = true,
      this.isError = false,
      this.errorMessage})
      : _verses = verses;

  @override
  @JsonKey()
  final int currentSurahNumber;
  @override
  @JsonKey()
  final int currentVerseIndex;
  final List<QuranVerse> _verses;
  @override
  @JsonKey()
  List<QuranVerse> get verses {
    if (_verses is EqualUnmodifiableListView) return _verses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_verses);
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
    return 'ReadingState(currentSurahNumber: $currentSurahNumber, currentVerseIndex: $currentVerseIndex, verses: $verses, isLoading: $isLoading, isError: $isError, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadingStateImpl &&
            (identical(other.currentSurahNumber, currentSurahNumber) ||
                other.currentSurahNumber == currentSurahNumber) &&
            (identical(other.currentVerseIndex, currentVerseIndex) ||
                other.currentVerseIndex == currentVerseIndex) &&
            const DeepCollectionEquality().equals(other._verses, _verses) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isError, isError) || other.isError == isError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentSurahNumber,
      currentVerseIndex,
      const DeepCollectionEquality().hash(_verses),
      isLoading,
      isError,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadingStateImplCopyWith<_$ReadingStateImpl> get copyWith =>
      __$$ReadingStateImplCopyWithImpl<_$ReadingStateImpl>(this, _$identity);
}

abstract class _ReadingState implements ReadingState {
  const factory _ReadingState(
      {final int currentSurahNumber,
      final int currentVerseIndex,
      final List<QuranVerse> verses,
      final bool isLoading,
      final bool isError,
      final String? errorMessage}) = _$ReadingStateImpl;

  @override
  int get currentSurahNumber;
  @override
  int get currentVerseIndex;
  @override
  List<QuranVerse> get verses;
  @override
  bool get isLoading;
  @override
  bool get isError;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$ReadingStateImplCopyWith<_$ReadingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
