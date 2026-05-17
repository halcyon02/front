import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const _keyLastDate = 'streak_last_date';
  static const _keyDays = 'streak_days';

  static Future<int> recordActivityAndGetStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _today();
    final lastDate = prefs.getString(_keyLastDate);
    int streak = prefs.getInt(_keyDays) ?? 0;

    if (lastDate == null) {
      streak = 1;
    } else if (lastDate == today) {
      // 오늘 이미 기록됨 — 변경 없음
    } else {
      final diff = DateTime.parse(today)
          .difference(DateTime.parse(lastDate))
          .inDays;
      streak = diff == 1 ? streak + 1 : 1;
    }

    await prefs.setString(_keyLastDate, today);
    await prefs.setInt(_keyDays, streak);
    return streak;
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString(_keyLastDate);
    if (lastDate == null) return 0;
    final diff = DateTime.parse(_today())
        .difference(DateTime.parse(lastDate))
        .inDays;
    if (diff > 1) return 0;
    return prefs.getInt(_keyDays) ?? 0;
  }

  static String _today() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-'
        '${d.day.toString().padLeft(2, '0')}';
  }
}