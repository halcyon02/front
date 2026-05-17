import 'package:flutter_tts/flutter_tts.dart';
import 'package:puzzle_dot/services/interfaces/i_tts_service.dart';
import 'package:puzzle_dot/services/tts_manager.dart';

class AppTtsService implements ITtsService {
  final FlutterTts _tts = FlutterTts();

  AppTtsService() {
    TtsManager.instance.register(_tts);
    _init();
  }

  Future<void> _init() async {
    try {
      await _tts.setLanguage('ko-KR');
      await _tts.setSpeechRate(0.85);
      await _tts.setVolume(1.0);
      await _tts.setPitch(1.0);
    } catch (_) {}
  }

  @override
  Future<void> speak(String text) async {
    try { await _tts.speak(text); } catch (_) {}
  }

  @override
  Future<void> stop() async {
    try { await _tts.stop(); } catch (_) {}
  }

  @override
  Future<void> setRate(double rate) async {
    try { await _tts.setSpeechRate(rate); } catch (_) {}
  }

  @override
  Future<void> setVolume(double volume) async {
    try { await _tts.setVolume(volume); } catch (_) {}
  }

  void dispose() {
    TtsManager.instance.unregister(_tts);
    _tts.stop();
  }
}