import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/goals/data/models/challenge.dart';
import 'package:mobile/shared/services/mock_data_service.dart';

part 'challenges_provider.freezed.dart';
part 'challenges_provider.g.dart';

@freezed
class ChallengesState with _$ChallengesState {
  const factory ChallengesState({
    @Default([]) List<AppChallenge> challenges,
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _ChallengesState;
}

@riverpod
class ChallengesNotifier extends _$ChallengesNotifier {
  final MockDataService _mockDataService = MockDataService();

  @override
  Future<ChallengesState> build() async {
    try {
      final challenges = await _mockDataService.getChallenges();
      return ChallengesState(challenges: challenges, isLoading: false);
    } catch (e) {
      return ChallengesState(isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final challenges = await _mockDataService.getChallenges();
      return ChallengesState(challenges: challenges, isLoading: false);
    });
  }
}
