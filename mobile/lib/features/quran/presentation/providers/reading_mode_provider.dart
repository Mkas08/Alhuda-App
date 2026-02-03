import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reading_mode_provider.g.dart';

enum ReadingMode {
  ayah,
  mushaf,
}

@riverpod
class ReadingModeNotifier extends _$ReadingModeNotifier {
  @override
  ReadingMode build() {
    return ReadingMode.ayah;
  }

  void toggle() {
    state = state == ReadingMode.ayah ? ReadingMode.mushaf : ReadingMode.ayah;
  }

  void setMode(ReadingMode mode) {
    state = mode;
  }
}
