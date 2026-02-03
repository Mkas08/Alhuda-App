import 'package:json_annotation/json_annotation.dart';

part 'reading_session.g.dart';

@JsonSerializable()
class ReadingSession {
  final String sessionId;
  final String userId;
  final DateTime startTime;
  final DateTime? endTime;
  final int totalDurationSeconds;
  final int versesRead;
  final int hasanatEarned;
  final bool goalAchieved;
  final String sessionType;
  final String status;
  final DateTime createdAt;

  ReadingSession({
    required this.sessionId,
    required this.userId,
    required this.startTime,
    this.endTime,
    this.totalDurationSeconds = 0,
    this.versesRead = 0,
    this.hasanatEarned = 0,
    this.goalAchieved = false,
    this.sessionType = 'spontaneous',
    this.status = 'active',
    required this.createdAt,
  });

  factory ReadingSession.fromJson(Map<String, dynamic> json) => _$ReadingSessionFromJson(json);
  Map<String, dynamic> toJson() => _$ReadingSessionToJson(this);
}
