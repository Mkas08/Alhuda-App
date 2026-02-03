import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/quran/data/models/quran_models.dart';
import 'package:mobile/shared/services/mock_data_service.dart';

class SurahListScreen extends ConsumerStatefulWidget {
  const SurahListScreen({super.key});

  @override
  ConsumerState<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends ConsumerState<SurahListScreen> {
  final MockDataService _mockDataService = MockDataService();
  String _searchQuery = '';
  List<QuranSurah> _allSurahs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSurahs();
  }

  Future<void> _loadSurahs() async {
    final surahs = await _mockDataService.getSurahs();
    setState(() {
      _allSurahs = surahs;
      _isLoading = false;
    });
  }

  List<QuranSurah> get _filteredSurahs {
    if (_searchQuery.isEmpty) return _allSurahs;
    return _allSurahs.where((surah) {
      return surah.nameEnglish.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             surah.number.toString().contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepForest,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: _isLoading 
                ? const Center(child: CircularProgressIndicator(color: AppColors.emeraldPrimary))
                : _buildSurahList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Surah List',
            style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
          ),
          const Icon(Icons.info_outline, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Search Surah...',
          hintStyle: TextStyle(color: AppColors.textSecondary.withValues(alpha: 0.7)),
          prefixIcon: const Icon(Icons.search, color: AppColors.emeraldPrimary),
          filled: true,
          fillColor: AppColors.surfaceElevated,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildSurahList() {
    if (_filteredSurahs.isEmpty) {
      return const Center(
        child: Text('No Surahs found', style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: _filteredSurahs.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final surah = _filteredSurahs[index];
        return _buildSurahItem(surah);
      },
    );
  }

  Widget _buildSurahItem(QuranSurah surah) {
    return InkWell(
      onTap: () => context.push('/reading/${surah.number}/1'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderDark),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${surah.number}',
                  style: const TextStyle(
                    color: AppColors.emeraldPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.nameEnglish,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${surah.versesCount} Verses • ${surah.revelationPlace.toUpperCase()}',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                       const Icon(Icons.timelapse, size: 12, color: AppColors.emeraldLight),
                       const SizedBox(width: 4),
                       Text(
                        'Verse 1/${surah.versesCount}', 
                        style: AppTextStyles.labelSmall.copyWith(color: AppColors.emeraldLight)
                      ),
                    ],
                  )
                ],
              ),
            ),
            Text(
              surah.nameArabic,
              style: const TextStyle(
                color: AppColors.emeraldPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
