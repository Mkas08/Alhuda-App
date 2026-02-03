import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/prayer/presentation/providers/prayer_provider.dart';
import '../../data/models/dua.dart';

final duaCategoriesProvider = FutureProvider<List<DuaCategory>>((ref) async {
  final service = ref.watch(mockDataServiceProvider);
  return service.getDuaCategories();
});

final duasByCategoryProvider = FutureProvider.family<List<Dua>, String>((ref, categoryId) async {
  final service = ref.watch(mockDataServiceProvider);
  return service.getDuasByCategory(categoryId);
});
