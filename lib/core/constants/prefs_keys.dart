/// SharedPreferences 키를 한 곳에서 관리합니다 (LOC_002).
/// 직접 문자열 하드코딩 금지 — 이 클래스의 상수만 사용.
abstract class PrefsKeys {
  PrefsKeys._();

  // 온보딩
  static const String isFirstLaunch = 'is_first_launch';

  // 학습 완료 (LOC_003: done_{ID} 패턴)
  static const String completedPrefix = 'completed_';

  // 카메라 거치 가이드 표시 여부 (레벨별)
  static const String cameraGuidePrefix = 'camera_guide_shown_';

  // 연속 학습일
  static const String streakLastDate = 'streak_last_date';
  static const String streakDays    = 'streak_days';

  // 누적 XP
  static const String totalXp = 'total_xp';

  // TTS 설정
  static const String ttsSpeechRate = 'tts_speech_rate';
  static const String ttsVolume     = 'tts_volume';

  // 기타 설정
  static const String vibrationEnabled = 'vibration_enabled';
}