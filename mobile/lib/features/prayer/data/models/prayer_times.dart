class PrayerTime {
  final String name;
  final DateTime time;
  final bool isNext;

  const PrayerTime({required this.name, required this.time, this.isNext = false});
}

class QiblaDirection {
  final double degree;
  final String compassDirection;

  const QiblaDirection({required this.degree, required this.compassDirection});
}
