import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class SocialPost with _$SocialPost {
  const factory SocialPost({
    required String id,
    required String user,
    required String username,
    required String avatar,
    required String time,
    required String content,
    required int likes,
    required int comments,
  }) = _SocialPost;

  factory SocialPost.fromJson(Map<String, dynamic> json) =>
      _$SocialPostFromJson(json);
}
