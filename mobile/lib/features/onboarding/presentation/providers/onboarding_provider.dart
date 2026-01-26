import 'package:flutter_riverpod/flutter_riverpod.dart';

enum GoalType { verse, time, page }
enum UserLevel { beginner, intermediate, advanced }

class OnboardingData {
  final GoalType goalType;
  final int goalValue;
  final UserLevel level;
  final List<String> preferredTimes;
  final String? city;
  final double? latitude;
  final double? longitude;

  OnboardingData({
    this.goalType = GoalType.verse,
    this.goalValue = 10,
    this.level = UserLevel.beginner,
    this.preferredTimes = const [],
    this.city,
    this.latitude,
    this.longitude,
  });

  OnboardingData copyWith({
    GoalType? goalType,
    int? goalValue,
    UserLevel? level,
    List<String>? preferredTimes,
    String? city,
    double? latitude,
    double? longitude,
  }) {
    return OnboardingData(
      goalType: goalType ?? this.goalType,
      goalValue: goalValue ?? this.goalValue,
      level: level ?? this.level,
      preferredTimes: preferredTimes ?? this.preferredTimes,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingData> {
  OnboardingNotifier() : super(OnboardingData());

  void updateGoalType(GoalType type) => state = state.copyWith(goalType: type);
  void updateGoalValue(int value) => state = state.copyWith(goalValue: value);
  void updateLevel(UserLevel level) => state = state.copyWith(level: level);
  void togglePreferredTime(String time) {
    final times = List<String>.from(state.preferredTimes);
    if (times.contains(time)) {
      times.remove(time);
    } else {
      times.add(time);
    }
    state = state.copyWith(preferredTimes: times);
  }
  void updateLocation({String? city, double? lat, double? lon}) {
    state = state.copyWith(city: city, latitude: lat, longitude: lon);
  }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingData>((ref) {
  return OnboardingNotifier();
});
