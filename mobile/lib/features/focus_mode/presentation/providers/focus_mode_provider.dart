import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile/features/focus_mode/data/models/app_block_info.dart';
import 'package:mobile/shared/services/mock_data_service.dart';

part 'focus_mode_provider.freezed.dart';
part 'focus_mode_provider.g.dart';

@freezed
class FocusModeState with _$FocusModeState {
  const factory FocusModeState({
    @Default(false) bool isEnabled,
    @Default([]) List<AppBlockInfo> apps,
    @Default(true) bool isLoading,
  }) = _FocusModeState;
}

@riverpod
class FocusModeNotifier extends _$FocusModeNotifier {
  final MockDataService _mockDataService = MockDataService();

  @override
  Future<FocusModeState> build() async {
    final apps = await _mockDataService.getBlockedApps();
    return FocusModeState(
      apps: apps,
      isLoading: false,
    );
  }

  void toggleFocus() {
    state.whenData((current) {
      state = AsyncData(current.copyWith(isEnabled: !current.isEnabled));
    });
  }

  void toggleAppBlock(int appId) {
    state.whenData((current) {
      final updatedApps = current.apps.map((app) {
        if (app.id == appId) {
          return app.copyWith(blocked: !app.blocked);
        }
        return app;
      }).toList();
      state = AsyncData(current.copyWith(apps: updatedApps));
    });
  }
}
