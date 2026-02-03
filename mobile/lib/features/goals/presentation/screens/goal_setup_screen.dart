import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/theme/colors.dart';
import 'package:mobile/core/theme/text_styles.dart';
import 'package:mobile/features/goals/domain/entities/goal.dart';
import 'package:mobile/features/goals/presentation/providers/goal_provider.dart';

class GoalSetupScreen extends ConsumerStatefulWidget {
  const GoalSetupScreen({super.key});

  @override
  ConsumerState<GoalSetupScreen> createState() => _GoalSetupScreenState();
}

class _GoalSetupScreenState extends ConsumerState<GoalSetupScreen> {
  String _selectedType = 'verse'; // verse, time, page
  int _goalValue = 10;
  final List<String> _selectedTimes = <String>[];

  final List<Map<String, dynamic>> _goalTypes = <Map<String, dynamic>>[
    <String, dynamic>{'id': 'verse', 'title': 'Verses', 'icon': Icons.menu_book, 'subtitle': 'Track by number of verses'},
    <String, dynamic>{'id': 'time', 'title': 'Minutes', 'icon': Icons.timer, 'subtitle': 'Track by reading duration'},
    <String, dynamic>{'id': 'page', 'title': 'Pages', 'icon': Icons.description, 'subtitle': 'Track by Quran pages'},
  ];

  final List<Map<String, String>> _timeOptions = <Map<String, String>>[
    <String, String>{'id': 'after_fajr', 'label': 'After Fajr'},
    <String, String>{'id': 'before_zuhr', 'label': 'Before Zuhr'},
    <String, String>{'id': 'after_asr', 'label': 'After Asr'},
    <String, String>{'id': 'after_maghrib', 'label': 'After Maghrib'},
    <String, String>{'id': 'after_isha', 'label': 'After Isha'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) {
      final Goal? activeGoal = ref.read(goalProvider).activeGoal;
      if (activeGoal != null) {
        setState(() {
          _selectedType = activeGoal.goalType;
          _goalValue = activeGoal.goalValue;
          _selectedTimes.clear();
          _selectedTimes.addAll(activeGoal.preferredTimes);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final GoalState state = ref.watch(goalProvider);

    return Scaffold(
      backgroundColor: AppColors.deepForest,
      appBar: AppBar(
        title: const Text('Set Your Goal'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'What would you like to track?',
              style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 24),
            ..._goalTypes.map((Map<String, dynamic> type) => _buildTypeCard(type)),
            const SizedBox(height: 32),
            Text(
              'Daily Target',
              style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            _buildValueSelector(),
            const SizedBox(height: 32),
            Text(
              'Preferred Times (Optional)',
              style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _timeOptions.map((Map<String, String> time) => _buildTimeChip(time)).toList(),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: state.isLoading ? null : _saveGoal,
              child: state.isLoading 
                ? const SizedBox(
                    height: 20, 
                    width: 20, 
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.onPrimary),
                  )
                : const Text('Start My Journey'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard(Map<String, dynamic> type) {
    final bool isSelected = _selectedType == type['id'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = type['id'] as String),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surfaceElevated : AppColors.surfaceDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.emeraldPrimary : AppColors.borderDark,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected ? <BoxShadow>[
              const BoxShadow(
                color: AppColors.emeraldGlow,
                blurRadius: 15,
                spreadRadius: 2,
              )
            ] : null,
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Icon(
                type['icon'] as IconData,
                color: isSelected ? AppColors.emeraldPrimary : AppColors.textSecondary,
                size: 32,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      type['title'] as String,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      type['subtitle'] as String,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle, color: AppColors.emeraldPrimary),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          Text(
            '$_goalValue ${_selectedType == 'time' ? 'Minutes' : (_selectedType == 'verse' ? 'Verses' : 'Pages')}',
            style: AppTextStyles.h1.copyWith(color: AppColors.emeraldPrimary),
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: const SliderThemeData(
              activeTrackColor: AppColors.emeraldPrimary,
              inactiveTrackColor: AppColors.borderDark,
              thumbColor: AppColors.emeraldPrimary,
              overlayColor: AppColors.emeraldGlow,
            ),
            child: Slider(
              value: _goalValue.toDouble(),
              min: 1,
              max: 100,
              onChanged: (double val) => setState(() => _goalValue = val.toInt()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeChip(Map<String, String> time) {
    final bool isSelected = _selectedTimes.contains(time['id']);
    return FilterChip(
      label: Text(time['label']!),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          if (selected) {
            _selectedTimes.add(time['id']!);
          } else {
            _selectedTimes.remove(time['id']!);
          }
        });
      },
      selectedColor: AppColors.emeraldPrimary,
      checkmarkColor: AppColors.onPrimary,
      backgroundColor: AppColors.surfaceDark,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isSelected ? Colors.transparent : AppColors.borderDark),
      ),
    );
  }

  void _saveGoal() async {
    final Goal? activeGoal = ref.read(goalProvider).activeGoal;
    
    if (activeGoal != null) {
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: AppColors.surfaceDark,
          title: const Text('Update Goal?', style: TextStyle(color: AppColors.textPrimary)),
          content: const Text(
            'Your current progress for today will be preserved, but your daily target will change.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textTertiary)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Update', style: TextStyle(color: AppColors.emeraldPrimary)),
            ),
          ],
        ),
      );
      
      if (confirm != true) return;
    }

    await ref.read(goalProvider.notifier).createGoal(
      goalType: _selectedType,
      goalValue: _goalValue,
      preferredTimes: _selectedTimes,
    );
    
    if (mounted) {
      final GoalState state = ref.read(goalProvider);
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!), backgroundColor: AppColors.error),
        );
      } else {
        // Navigate to home or show success
        Navigator.of(context).pop(); // Simple pop for now
      }
    }
  }
}
