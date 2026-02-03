class Goal {
  final String goalId;
  final String userId;
  final String goalType; // verse, time, page
  final int goalValue;
  final List<String> preferredTimes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Goal({
    required this.goalId,
    required this.userId,
    required this.goalType,
    required this.goalValue,
    required this.preferredTimes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      goalId: json['goal_id'] as String,
      userId: json['user_id'] as String,
      goalType: json['goal_type'] as String,
      goalValue: json['goal_value'] as int,
      preferredTimes: List<String>.from(json['preferred_times'] as List<dynamic>? ?? <dynamic>[]),
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'goal_id': goalId,
      'user_id': userId,
      'goal_type': goalType,
      'goal_value': goalValue,
      'preferred_times': preferredTimes,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
