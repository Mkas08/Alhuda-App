// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SocialPostImpl _$$SocialPostImplFromJson(Map<String, dynamic> json) =>
    _$SocialPostImpl(
      id: json['id'] as String,
      user: json['user'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String,
      time: json['time'] as String,
      content: json['content'] as String,
      likes: (json['likes'] as num).toInt(),
      comments: (json['comments'] as num).toInt(),
    );

Map<String, dynamic> _$$SocialPostImplToJson(_$SocialPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'username': instance.username,
      'avatar': instance.avatar,
      'time': instance.time,
      'content': instance.content,
      'likes': instance.likes,
      'comments': instance.comments,
    };
