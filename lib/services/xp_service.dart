import 'package:shared_preferences/shared_preferences.dart';

class XpService {
  static const _keyTotalXp = 'total_xp';
  static const int xpPerItem = 150;

  static Future<void> addXp() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_keyTotalXp) ?? 0;
    await prefs.setInt(_keyTotalXp, current + xpPerItem);
  }

  static Future<int> getTotalXp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalXp) ?? 0;
  }
}