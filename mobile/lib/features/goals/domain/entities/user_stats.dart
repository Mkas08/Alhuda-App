import 'package:mobile/features/goals/domain/entities/goal.dart';

class UserStats {
  final String userId;
  final int totalVersesRead;
  final int totalHasanat;
  final int currentStreak;
  final int longestStreak;
  final DateTime updatedAt;

  UserStats({
    required this.userId,
    required this.totalVersesRead,
    required this.totalHasanat,
    required this.currentStreak,
    required this.longestStreak,
    required this.updatedAt,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      userId: json['user_id'] as String,
      totalVersesRead: json['total_verses_read'] as int,
      totalHasanat: json['total_hasanat'] as int,
      currentStreak: json['current_streak'] as int,
      longestStreak: json['longest_streak'] as int,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}

class UserProgress {
  final UserStats stats;
  final Goal? activeGoal;
  final double completionPercentage;

  UserProgress({
    required this.stats,
    this.activeGoal,
    required this.completionPercentage,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      stats: UserStats.fromJson(json['stats'] as Map<String, dynamic>),
      activeGoal: json['active_goal'] != null 
          ? Goal.fromJson(json['active_goal'] as Map<String, dynamic>) 
          : null,
      completionPercentage: (json['completion_percentage'] as num).toDouble(),
    );
  }
}
