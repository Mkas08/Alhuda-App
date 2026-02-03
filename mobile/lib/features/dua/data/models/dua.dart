class DuaCategory {
  final String id;
  final String name;
  final String icon; 

  const DuaCategory({required this.id, required this.name, required this.icon});
}

class Dua {
  final String id;
  final String categoryId;
  final String title;
  final String arabic;
  final String translation;
  final String transliteration;
  final String reference;

  const Dua({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.arabic,
    required this.translation,
    required this.transliteration,
    required this.reference,
  });
}
