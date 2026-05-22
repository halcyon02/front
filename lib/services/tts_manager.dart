import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TtsManager {
  TtsManager._();
  static final TtsManager instance = TtsManager._();

  final Set<FlutterTts> _activeTts = {};

  // 전역 설정값 캐싱
  double _speed = 0.45;
  double _volume = 1.0;

  // 앱 시작 시 호출하여 설정값 로드
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _speed = prefs.getDouble('tts_speed') ?? 0.45;
    _volume = prefs.getDouble('tts_volume') ?? 1.0;
  }

  void register(FlutterTts tts) {
    _activeTts.add(tts);
    // 새로 등록될 때 현재 전역 설정값 적용
    tts.setSpeechRate(_speed);
    tts.setVolume(_volume);
    tts.setLanguage('ko-KR'); // 기본 언어 설정
    tts.setPitch(1.0);
  }

  // 설정 변경 시 호출 (설정 화면에서 호출하면 됨)
  Future<void> updateSettings(double speed, double volume) async {
    _speed = speed;
    _volume = volume;

    // 현재 활성화된 모든 TTS에 즉시 적용
    for (final tts in _activeTts) {
      await tts.setSpeechRate(_speed);
      await tts.setVolume(_volume);
    }
  }

  void unregister(FlutterTts tts) {
    _activeTts.remove(tts);
  }

  Future<void> stopAll() async {
    for (final tts in _activeTts.toList()) {
      try {
        await tts.stop();
      } catch (_) {}
    }
  }
}
