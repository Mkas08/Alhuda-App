import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/config/routes/route_constants.dart';
import 'package:mobile/core/theme/text_styles.dart';
import '../providers/dua_provider.dart';

class DuaCategoryScreen extends ConsumerWidget {
  final String categoryId;
  final String categoryName;

  const DuaCategoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duasAsync = ref.watch(duasByCategoryProvider(categoryId));

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: Text(categoryName, style: AppTextStyles.h3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: duasAsync.when(
        data: (duas) {
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: duas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final dua = duas[index];
              return ListTile(
                tileColor: AppColors.surfaceDark,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                title: Text(dua.title, style: AppTextStyles.bodyLarge),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
                onTap: () {
                    context.pushNamed(RouteConstants.duaDetail, extra: dua);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary)),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
