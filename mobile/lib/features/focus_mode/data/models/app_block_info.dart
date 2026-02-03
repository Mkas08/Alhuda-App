import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_block_info.freezed.dart';
part 'app_block_info.g.dart';

@freezed
class AppBlockInfo with _$AppBlockInfo {
  const factory AppBlockInfo({
    required int id,
    required String name,
    required String category,
    required String icon,
    @Default(false) bool blocked,
  }) = _AppBlockInfo;

  factory AppBlockInfo.fromJson(Map<String, dynamic> json) =>
      _$AppBlockInfoFromJson(json);
}
