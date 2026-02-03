import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/social/data/models/post.dart';
import 'package:mobile/shared/services/mock_data_service.dart';

part 'social_provider.freezed.dart';
part 'social_provider.g.dart';

@freezed
class SocialState with _$SocialState {
  const factory SocialState({
    @Default([]) List<SocialPost> posts,
    @Default(true) bool isLoading,
    @Default(false) bool isError,
    String? errorMessage,
  }) = _SocialState;
}

@riverpod
class SocialNotifier extends _$SocialNotifier {
  final MockDataService _mockDataService = MockDataService();

  @override
  Future<SocialState> build() async {
    try {
      final posts = await _mockDataService.getPosts();
      return SocialState(posts: posts, isLoading: false);
    } catch (e) {
      return SocialState(isLoading: false, isError: true, errorMessage: e.toString());
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final posts = await _mockDataService.getPosts();
      return SocialState(posts: posts, isLoading: false);
    });
  }
}
