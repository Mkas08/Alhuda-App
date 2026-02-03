import 'package:mobile/features/quran/data/models/quran_models.dart';
import 'package:mobile/features/social/data/models/post.dart';
import 'package:mobile/features/goals/data/models/challenge.dart';
import 'package:mobile/features/focus_mode/data/models/app_block_info.dart';
import 'package:mobile/features/prayer/data/models/prayer_times.dart';
import 'package:mobile/features/dua/data/models/dua.dart';

class MockDataService {
  static const Duration _delay = Duration(milliseconds: 500);

  static final List<QuranSurah> mockSurahs = [
    const QuranSurah(number: 1, nameEnglish: 'Al-Fatihah', nameArabic: 'الفاتحة', nameComplex: 'Al-Fatihah', versesCount: 7, revelationPlace: 'makkah'),
    const QuranSurah(number: 2, nameEnglish: 'Al-Baqarah', nameArabic: 'البقرة', nameComplex: 'Al-Baqarah', versesCount: 286, revelationPlace: 'madinah'),
    const QuranSurah(number: 3, nameEnglish: 'Ali \'Imran', nameArabic: 'آل عمران', nameComplex: 'Ali \'Imran', versesCount: 200, revelationPlace: 'madinah'),
    const QuranSurah(number: 36, nameEnglish: 'Ya-Sin', nameArabic: 'يس', nameComplex: 'Ya-Sin', versesCount: 83, revelationPlace: 'makkah'),
    const QuranSurah(number: 55, nameEnglish: 'Ar-Rahman', nameArabic: 'الرحمن', nameComplex: 'Ar-Rahman', versesCount: 78, revelationPlace: 'madinah'),
    const QuranSurah(number: 67, nameEnglish: 'Al-Mulk', nameArabic: 'الملك', nameComplex: 'Al-Mulk', versesCount: 30, revelationPlace: 'makkah'),
    const QuranSurah(number: 112, nameEnglish: 'Al-Ikhlas', nameArabic: 'الإخلاص', nameComplex: 'Al-Ikhlas', versesCount: 4, revelationPlace: 'makkah'),
    const QuranSurah(number: 113, nameEnglish: 'Al-Falaq', nameArabic: 'الفلق', nameComplex: 'Al-Falaq', versesCount: 5, revelationPlace: 'makkah'),
    const QuranSurah(number: 114, nameEnglish: 'An-Nas', nameArabic: 'الناس', nameComplex: 'An-Nas', versesCount: 6, revelationPlace: 'makkah'),
  ];

  static final List<SocialPost> mockPosts = [
    const SocialPost(
      id: '1',
      user: 'Fatima Ali',
      username: '@fatima_a',
      avatar: 'F',
      time: '2h ago',
      content: 'Just completed my 30-day streak of reading Quran! Alhamdulillah for this blessing. Never give up on your goals. 🌟',
      likes: 42,
      comments: 8,
    ),
    const SocialPost(
      id: '2',
      user: 'Omar Khan',
      username: '@omar_k',
      avatar: 'O',
      time: '5h ago',
      content: '"Indeed, with hardship comes ease" - Surah Ash-Sharh 94:6\n\nThis verse gives me so much hope during difficult times. What verse inspires you the most?',
      likes: 128,
      comments: 23,
    ),
  ];

  static final List<AppChallenge> mockChallenges = [
    const AppChallenge(id: 1, title: 'Complete Juz Amma', description: 'Finish the 30th Juz in 7 days', progress: 60, participants: 234),
    const AppChallenge(id: 2, title: 'Morning Routine', description: 'Read 10 verses after Fajr for 14 days', progress: 35, participants: 89),
  ];

  static final List<AppBlockInfo> mockApps = [
    const AppBlockInfo(id: 1, name: 'Instagram', category: 'Social', icon: 'instagram', blocked: true),
    const AppBlockInfo(id: 2, name: 'TikTok', category: 'Entertainment', icon: 'tiktok', blocked: true),
    const AppBlockInfo(id: 3, name: 'YouTube', category: 'Entertainment', icon: 'youtube', blocked: false),
    const AppBlockInfo(id: 4, name: 'Twitter / X', category: 'Social', icon: 'social', blocked: true),
    const AppBlockInfo(id: 5, name: 'Games', category: 'Gaming', icon: 'games', blocked: false),
  ];

  Future<List<QuranSurah>> getSurahs() async {
    await Future.delayed(_delay);
    return mockSurahs;
  }

  Future<List<SocialPost>> getPosts() async {
    await Future.delayed(_delay);
    return mockPosts;
  }

  Future<List<AppChallenge>> getChallenges() async {
    await Future.delayed(_delay);
    return mockChallenges;
  }

  Future<List<AppBlockInfo>> getBlockedApps() async {
    await Future.delayed(_delay);
    return mockApps;
  }

  Future<List<PrayerTime>> getPrayerTimes() async {
    await Future.delayed(_delay);
    final now = DateTime.now();
    return [
      PrayerTime(name: 'Fajr', time: DateTime(now.year, now.month, now.day, 5, 20)),
      PrayerTime(name: 'Sunrise', time: DateTime(now.year, now.month, now.day, 6, 45)),
      PrayerTime(name: 'Dhuhr', time: DateTime(now.year, now.month, now.day, 12, 30), isNext: true),
      PrayerTime(name: 'Asr', time: DateTime(now.year, now.month, now.day, 15, 45)),
      PrayerTime(name: 'Maghrib', time: DateTime(now.year, now.month, now.day, 18, 10)),
      PrayerTime(name: 'Isha', time: DateTime(now.year, now.month, now.day, 19, 45)),
    ];
  }

  Future<QiblaDirection> getQiblaDirection() async {
     await Future.delayed(_delay);
     return const QiblaDirection(degree: 118.5, compassDirection: 'SE');
  }

  Future<List<DuaCategory>> getDuaCategories() async {
     await Future.delayed(_delay);
     return const [
       DuaCategory(id: '1', name: 'Morning & Evening', icon: 'wb_twilight'),
       DuaCategory(id: '2', name: 'Travel', icon: 'flight'),
       DuaCategory(id: '3', name: 'Food & Drink', icon: 'restaurant'),
       DuaCategory(id: '4', name: 'Forgiveness', icon: 'volunteer_activism'),
     ];
  }

  Future<List<Dua>> getDuasByCategory(String categoryId) async {
    await Future.delayed(_delay);
    return const [
       Dua(
         id: '1',
         categoryId: '1',
         title: 'Morning Dua',
         arabic: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ',
         transliteration: 'Asbahna wa asbahal mulku lillah',
         translation: 'We have reached the morning and at this very time unto Allah belongs all sovereignty...',
         reference: 'Muslim',
       ),
       Dua(
         id: '2',
         categoryId: '2',
         title: 'Travel Dua',
         arabic: 'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا',
         transliteration: 'Subhanalladhi sakhkhara lana hadha',
         translation: 'Glory to Him who has subjected this to us...',
         reference: 'Quran 43:13',
       ),
    ];
  }
}
