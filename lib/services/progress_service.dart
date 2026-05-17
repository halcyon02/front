import 'package:shared_preferences/shared_preferences.dart';
import 'package:puzzle_dot/models/curriculum_item.dart';
import 'package:puzzle_dot/data/curriculum_data.dart';
import 'package:puzzle_dot/services/streak_service.dart';
import 'package:puzzle_dot/services/xp_service.dart';

class ProgressService {
  static const _prefix = 'completed_';

  // 신규 완료 시에만 Streak + XP 업데이트
  static Future<void> markCompleted(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final alreadyDone = prefs.getBool('$_prefix$itemId') ?? false;
    if (!alreadyDone) {
      await prefs.setBool('$_prefix$itemId', true);
      await StreakService.recordActivityAndGetStreak();
      await XpService.addXp();
    }
  }

  static Future<Set<String>> getCompletedIds(
      List<CurriculumItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    return items
        .where((item) => prefs.getBool('$_prefix${item.id}') ?? false)
        .map((item) => item.id)
        .toSet();
  }

  static Future<Map<String, double>> getLevelProgressMap() async {
    final prefs = await SharedPreferences.getInstance();
    final result = <String, double>{};
    for (final entry in curriculumData.entries) {
      final total = entry.value.length;
      if (total == 0) { result[entry.key] = 0.0; continue; }
      final done = entry.value
          .where((item) => prefs.getBool('$_prefix${item.id}') ?? false)
          .length;
      result[entry.key] = done / total;
    }
    return result;
  }
}