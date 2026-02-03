import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

@freezed
class AppChallenge with _$AppChallenge {
  const factory AppChallenge({
    required int id,
    required String title,
    required String description,
    required int progress,
    required int participants,
  }) = _AppChallenge;

  factory AppChallenge.fromJson(Map<String, dynamic> json) =>
      _$AppChallengeFromJson(json);
}
