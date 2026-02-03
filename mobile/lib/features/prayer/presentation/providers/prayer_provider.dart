import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/mock_data_service.dart';
import '../../data/models/prayer_times.dart';

final mockDataServiceProvider = Provider((ref) => MockDataService());

final prayerTimesProvider = FutureProvider<List<PrayerTime>>((ref) async {
  final service = ref.watch(mockDataServiceProvider);
  return service.getPrayerTimes();
});

final qiblaDirectionProvider = FutureProvider<QiblaDirection>((ref) async {
  final service = ref.watch(mockDataServiceProvider);
  return service.getQiblaDirection();
});
