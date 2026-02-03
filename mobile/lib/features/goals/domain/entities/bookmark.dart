class Bookmark {
  final String bookmarkId;
  final String userId;
  final int verseId;
  final String? note;
  final DateTime createdAt;

  Bookmark({
    required this.bookmarkId,
    required this.userId,
    required this.verseId,
    this.note,
    required this.createdAt,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      bookmarkId: json['bookmark_id'] as String,
      userId: json['user_id'] as String,
      verseId: json['verse_id'] as int,
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'bookmark_id': bookmarkId,
      'user_id': userId,
      'verse_id': verseId,
      'note': note,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
