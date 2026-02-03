// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppChallengeImpl _$$AppChallengeImplFromJson(Map<String, dynamic> json) =>
    _$AppChallengeImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      progress: (json['progress'] as num).toInt(),
      participants: (json['participants'] as num).toInt(),
    );

Map<String, dynamic> _$$AppChallengeImplToJson(_$AppChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'progress': instance.progress,
      'participants': instance.participants,
    };
