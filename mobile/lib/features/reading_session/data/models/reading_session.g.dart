// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingSession _$ReadingSessionFromJson(Map<String, dynamic> json) =>
    ReadingSession(
      sessionId: json['sessionId'] as String,
      userId: json['userId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      totalDurationSeconds:
          (json['totalDurationSeconds'] as num?)?.toInt() ?? 0,
      versesRead: (json['versesRead'] as num?)?.toInt() ?? 0,
      hasanatEarned: (json['hasanatEarned'] as num?)?.toInt() ?? 0,
      goalAchieved: json['goalAchieved'] as bool? ?? false,
      sessionType: json['sessionType'] as String? ?? 'spontaneous',
      status: json['status'] as String? ?? 'active',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ReadingSessionToJson(ReadingSession instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'totalDurationSeconds': instance.totalDurationSeconds,
      'versesRead': instance.versesRead,
      'hasanatEarned': instance.hasanatEarned,
      'goalAchieved': instance.goalAchieved,
      'sessionType': instance.sessionType,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
