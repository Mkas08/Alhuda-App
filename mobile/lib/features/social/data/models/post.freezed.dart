// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SocialPost _$SocialPostFromJson(Map<String, dynamic> json) {
  return _SocialPost.fromJson(json);
}

/// @nodoc
mixin _$SocialPost {
  String get id => throw _privateConstructorUsedError;
  String get user => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  int get comments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialPostCopyWith<SocialPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialPostCopyWith<$Res> {
  factory $SocialPostCopyWith(
          SocialPost value, $Res Function(SocialPost) then) =
      _$SocialPostCopyWithImpl<$Res, SocialPost>;
  @useResult
  $Res call(
      {String id,
      String user,
      String username,
      String avatar,
      String time,
      String content,
      int likes,
      int comments});
}

/// @nodoc
class _$SocialPostCopyWithImpl<$Res, $Val extends SocialPost>
    implements $SocialPostCopyWith<$Res> {
  _$SocialPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? username = null,
    Object? avatar = null,
    Object? time = null,
    Object? content = null,
    Object? likes = null,
    Object? comments = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SocialPostImplCopyWith<$Res>
    implements $SocialPostCopyWith<$Res> {
  factory _$$SocialPostImplCopyWith(
          _$SocialPostImpl value, $Res Function(_$SocialPostImpl) then) =
      __$$SocialPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String user,
      String username,
      String avatar,
      String time,
      String content,
      int likes,
      int comments});
}

/// @nodoc
class __$$SocialPostImplCopyWithImpl<$Res>
    extends _$SocialPostCopyWithImpl<$Res, _$SocialPostImpl>
    implements _$$SocialPostImplCopyWith<$Res> {
  __$$SocialPostImplCopyWithImpl(
      _$SocialPostImpl _value, $Res Function(_$SocialPostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = null,
    Object? username = null,
    Object? avatar = null,
    Object? time = null,
    Object? content = null,
    Object? likes = null,
    Object? comments = null,
  }) {
    return _then(_$SocialPostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SocialPostImpl implements _SocialPost {
  const _$SocialPostImpl(
      {required this.id,
      required this.user,
      required this.username,
      required this.avatar,
      required this.time,
      required this.content,
      required this.likes,
      required this.comments});

  factory _$SocialPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$SocialPostImplFromJson(json);

  @override
  final String id;
  @override
  final String user;
  @override
  final String username;
  @override
  final String avatar;
  @override
  final String time;
  @override
  final String content;
  @override
  final int likes;
  @override
  final int comments;

  @override
  String toString() {
    return 'SocialPost(id: $id, user: $user, username: $username, avatar: $avatar, time: $time, content: $content, likes: $likes, comments: $comments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.comments, comments) ||
                other.comments == comments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, user, username, avatar, time, content, likes, comments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialPostImplCopyWith<_$SocialPostImpl> get copyWith =>
      __$$SocialPostImplCopyWithImpl<_$SocialPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SocialPostImplToJson(
      this,
    );
  }
}

abstract class _SocialPost implements SocialPost {
  const factory _SocialPost(
      {required final String id,
      required final String user,
      required final String username,
      required final String avatar,
      required final String time,
      required final String content,
      required final int likes,
      required final int comments}) = _$SocialPostImpl;

  factory _SocialPost.fromJson(Map<String, dynamic> json) =
      _$SocialPostImpl.fromJson;

  @override
  String get id;
  @override
  String get user;
  @override
  String get username;
  @override
  String get avatar;
  @override
  String get time;
  @override
  String get content;
  @override
  int get likes;
  @override
  int get comments;
  @override
  @JsonKey(ignore: true)
  _$$SocialPostImplCopyWith<_$SocialPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
