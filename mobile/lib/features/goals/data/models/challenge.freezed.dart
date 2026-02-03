// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppChallenge _$AppChallengeFromJson(Map<String, dynamic> json) {
  return _AppChallenge.fromJson(json);
}

/// @nodoc
mixin _$AppChallenge {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  int get participants => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppChallengeCopyWith<AppChallenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppChallengeCopyWith<$Res> {
  factory $AppChallengeCopyWith(
          AppChallenge value, $Res Function(AppChallenge) then) =
      _$AppChallengeCopyWithImpl<$Res, AppChallenge>;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      int progress,
      int participants});
}

/// @nodoc
class _$AppChallengeCopyWithImpl<$Res, $Val extends AppChallenge>
    implements $AppChallengeCopyWith<$Res> {
  _$AppChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? progress = null,
    Object? participants = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppChallengeImplCopyWith<$Res>
    implements $AppChallengeCopyWith<$Res> {
  factory _$$AppChallengeImplCopyWith(
          _$AppChallengeImpl value, $Res Function(_$AppChallengeImpl) then) =
      __$$AppChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      int progress,
      int participants});
}

/// @nodoc
class __$$AppChallengeImplCopyWithImpl<$Res>
    extends _$AppChallengeCopyWithImpl<$Res, _$AppChallengeImpl>
    implements _$$AppChallengeImplCopyWith<$Res> {
  __$$AppChallengeImplCopyWithImpl(
      _$AppChallengeImpl _value, $Res Function(_$AppChallengeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? progress = null,
    Object? participants = null,
  }) {
    return _then(_$AppChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppChallengeImpl implements _AppChallenge {
  const _$AppChallengeImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.progress,
      required this.participants});

  factory _$AppChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppChallengeImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int progress;
  @override
  final int participants;

  @override
  String toString() {
    return 'AppChallenge(id: $id, title: $title, description: $description, progress: $progress, participants: $participants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.participants, participants) ||
                other.participants == participants));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, progress, participants);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppChallengeImplCopyWith<_$AppChallengeImpl> get copyWith =>
      __$$AppChallengeImplCopyWithImpl<_$AppChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppChallengeImplToJson(
      this,
    );
  }
}

abstract class _AppChallenge implements AppChallenge {
  const factory _AppChallenge(
      {required final int id,
      required final String title,
      required final String description,
      required final int progress,
      required final int participants}) = _$AppChallengeImpl;

  factory _AppChallenge.fromJson(Map<String, dynamic> json) =
      _$AppChallengeImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get progress;
  @override
  int get participants;
  @override
  @JsonKey(ignore: true)
  _$$AppChallengeImplCopyWith<_$AppChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
