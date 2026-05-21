import 'package:flutter/material.dart';

/// [TODO] : 해당 카테고리 메서드에 로직을 추가하고 `analyzeMessage`에서 호출
class ChatBotService {
  /// 메인 분석 함수
  Map<String, String?> analyzeMessage(String input) {
    final text = input.trim().replaceAll(' ', '');

    // 1. 학습 카테고리 (자음, 모음, 단어, 문장)
    final learningResult = _handleLearning(text);
    if (learningResult != null) return learningResult;

    // 2. 학습 보조 카테고리 (퀴즈, 오답노트)
    final auxiliaryResult = _handleAuxiliary(text);
    if (auxiliaryResult != null) return auxiliaryResult;

    // 3. 시스템 및 탐색 카테고리 (홈, 설정, 가이드)
    final systemResult = _handleSystem(text);
    if (systemResult != null) return systemResult;

    // 기본 응답
    return _defaultResponse();
  }

  // [모듈화된 분석 메서드]

  Map<String, String?>? _handleLearning(String text) {
    final consonantRegex = RegExp(r'[ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎㄲㄸㅃㅆㅉ]');
    final vowelRegex = RegExp(r'[ㅏㅑㅓㅕㅗㅛㅜㅠㅡㅣㅐㅒㅔㅖㅘㅙㅚㅝㅞㅟㅢ]');

    if (text.contains('자음') ||
        text.contains('첫소리') ||
        text.contains('ㄱㄴㄷ') ||
        consonantRegex.hasMatch(text)) {
      return {'reply': "자음 학습 화면으로 이동합니다.", 'route': "consonant"};
    }
    if (text.contains('모음') ||
        text.contains('ㅏㅑㅓ') ||
        vowelRegex.hasMatch(text)) {
      return {'reply': "모음 학습 화면으로 이동합니다.", 'route': "vowel"};
    }
    if (text.contains('단어') || text.contains('낱말') || text.contains('글자')) {
      return {'reply': "일상 단어 연습 화면으로 이동합니다.", 'route': "word"};
    }
    if (text.contains('문장') || text.contains('긴글') || text.contains('본문')) {
      return {'reply': "문장 연습 화면으로 이동합니다.", 'route': "sentence"};
    }
    return null;
  }

  Map<String, String?>? _handleAuxiliary(String text) {
    if (text.contains('퀴즈') ||
        text.contains('문제') ||
        text.contains('시험') ||
        text.contains('테스트')) {
      return {'reply': "점자 퀴즈 화면으로 이동합니다.", 'route': "quiz"};
    }
    if (text.contains('복습') ||
        text.contains('오답') ||
        text.contains('틀린') ||
        text.contains('어려워')) {
      return {'reply': "오답 및 복습하기 화면으로 이동합니다.", 'route': "review"};
    }
    if (text.contains('초급') || text.contains('입문') || text.contains('쉽')) {
      return {'reply': "초급 단계 학습 화면으로 이동합니다.", 'route': "beginner"};
    }
    if (text.contains('고급') || text.contains('심화') || text.contains('어렵')) {
      return {'reply': "고급 단계 학습 화면으로 이동합니다.", 'route': "advanced"};
    }
    return null;
  }

  Map<String, String?>? _handleSystem(String text) {
    if (text.contains('홈') ||
        text.contains('메인') ||
        text.contains('처음') ||
        text.contains('나가') ||
        text.contains('뒤로')) {
      return {'reply': "홈 화면으로 이동합니다!", 'route': "home"};
    }
    if (text.contains('설정') ||
        text.contains('세팅') ||
        text.contains('볼륨') ||
        text.contains('소리') ||
        text.contains('옵션')) {
      return {'reply': "앱 설정 화면으로 이동합니다.", 'route': "settings"};
    }
    if (text.contains('도움') ||
        text.contains('가이드') ||
        text.contains('설명') ||
        text.contains('어떻게')) {
      return {'reply': "이용 가이드 화면으로 이동합니다.", 'route': "help"};
    }
    return null;
  }

  Map<String, String?> _defaultResponse() {
    return {
      'reply':
          "죄송해요, 어떤 메뉴인지 잘 알아듣지 못했어요.\n\n💡 '자음 보여줘', '퀴즈 풀래', '소리 조절'처럼 말씀해 보세요!",
      'route': null,
    };
  }
}
