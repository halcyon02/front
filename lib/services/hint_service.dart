/// 정답 벡터와 촬영 벡터를 비교해 TTS 힌트 문장을 생성합니다 (⑦-1).
/// 외부 의존성 없는 순수 로직 클래스.
abstract class HintService {
  HintService._();

  static const _dotNames = [
    '왼쪽 첫 번째 점',
    '왼쪽 두 번째 점',
    '왼쪽 세 번째 점',
    '오른쪽 첫 번째 점',
    '오른쪽 두 번째 점',
    '오른쪽 세 번째 점',
  ];

  /// [answer]: 정답 이진벡터, [result]: AI 반환 벡터, [wrongCount]: 누적 오답 횟수
  static String generateHint({
    required List<int> answer,
    required List<int> result,
    required int wrongCount,
  }) {
    // 3회 이상 연속 오답
    if (wrongCount >= 3) {
      return '계속 어려우신가요? 정답을 확인하시려면 화면을 두 번 탭 하세요.';
    }

    final remove = <String>[]; // 정답=0, AI=1 → 빼야 함
    final add    = <String>[]; // 정답=1, AI=0 → 추가해야 함

    for (int i = 0; i < 6; i++) {
      if (answer[i] == 0 && result[i] == 1) {
        remove.add('${_dotNames[i]}은 빼주세요.');
      } else if (answer[i] == 1 && result[i] == 0) {
        add.add('${_dotNames[i]}을 추가해주세요.');
      }
    }

    final allHints = [...remove, ...add];

    if (allHints.isEmpty) return '오답입니다. 다시 시도해주세요.';
    if (allHints.length >= 3) return '여러 곳이 다릅니다. 처음부터 다시 만들어보세요.';

    return '오답입니다. ${allHints.join(' ')}';
  }

  /// 인식 실패 통일 문장 (⑦-2)
  static const String recognitionFailed =
      '점자판이 잘 인식되지 않았습니다. 카메라와 점자판의 거리를 조정한 후 다시 촬영해주세요.';
}