import 'package:puzzle_dot/models/curriculum_item.dart';

/// 레벨 ID → 항목 목록.  총 78개 항목.
/// ENT_1(6) + BEG_1(14) + BEG_2(10) + INT_1(16) + INT_2(10) + ADV_1(17) + ADV_2(5)
const Map<String, List<CurriculumItem>> curriculumData = {
  // ─────────────────────────────────────────────
  // 🟡 입문  |  점 위치 번호 익히기  |  6개
  // ─────────────────────────────────────────────
  'ENT_1': [
    CurriculumItem(
      id: 'ENT_001', character: '①', name: '1번 점',
      description: '왼쪽 열 가장 위 점 하나만 올리기. 나머지 5점은 내린 상태 유지',
      ttsGuide: '이번 학습은 왼쪽 위, 1번 점입니다. 1번 점 하나만 올려주세요.',
      dotPatterns: [[1,0,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'ENT_002', character: '②', name: '2번 점',
      description: '왼쪽 열 가운데 점 하나만 올리기',
      ttsGuide: '이번 학습은 왼쪽 가운데, 2번 점입니다. 2번 점 하나만 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'ENT_003', character: '③', name: '3번 점',
      description: '왼쪽 열 가장 아래 점 하나만 올리기',
      ttsGuide: '이번 학습은 왼쪽 아래, 3번 점입니다. 3번 점 하나만 올려주세요.',
      dotPatterns: [[0,0,1,0,0,0]],
    ),
    CurriculumItem(
      id: 'ENT_004', character: '④', name: '4번 점',
      description: '오른쪽 열 가장 위 점 하나만 올리기',
      ttsGuide: '이번 학습은 오른쪽 위, 4번 점입니다. 4번 점 하나만 올려주세요.',
      dotPatterns: [[0,0,0,1,0,0]],
    ),
    CurriculumItem(
      id: 'ENT_005', character: '⑤', name: '5번 점',
      description: '오른쪽 열 가운데 점 하나만 올리기',
      ttsGuide: '이번 학습은 오른쪽 가운데, 5번 점입니다. 5번 점 하나만 올려주세요.',
      dotPatterns: [[0,0,0,0,1,0]],
    ),
    CurriculumItem(
      id: 'ENT_006', character: '⑥', name: '6번 점',
      description: '오른쪽 열 가장 아래 점 하나만 올리기',
      ttsGuide: '이번 학습은 오른쪽 아래, 6번 점입니다. 6번 점 하나만 올려주세요.',
      dotPatterns: [[0,0,0,0,0,1]],
    ),
  ],

  // ─────────────────────────────────────────────
  // 🔵 초급 자음  |  자음 초성 14개
  // ─────────────────────────────────────────────
  'BEG_1': [
    CurriculumItem(
      id: 'BEG_001', character: 'ㄱ', name: '기역',
      description: '초성 ㄱ. 점형: 4번 점 단독',
      ttsGuide: '이번 학습은 자음 기역, ㄱ입니다. 4번 점만 올려주세요.',
      dotPatterns: [[0,0,0,1,0,0]],
    ),
    CurriculumItem(
      id: 'BEG_002', character: 'ㄴ', name: '니은',
      description: '초성 ㄴ. 점형: 1·4번 점',
      ttsGuide: '이번 학습은 자음 니은, ㄴ입니다. 1번과 4번 점을 올려주세요.',
      dotPatterns: [[1,0,0,1,0,0]],
    ),
    CurriculumItem(
      id: 'BEG_003', character: 'ㄷ', name: '디귿',
      description: '초성 ㄷ. 점형: 2·4번 점',
      ttsGuide: '이번 학습은 자음 디귿, ㄷ입니다. 2번과 4번 점을 올려주세요.',
      dotPatterns: [[0,1,0,1,0,0]],
    ),
    CurriculumItem(
      id: 'BEG_004', character: 'ㄹ', name: '리을',
      description: '초성 ㄹ. 점형: 5번 점 단독',
      ttsGuide: '이번 학습은 자음 리을, ㄹ입니다. 5번 점만 올려주세요.',
      dotPatterns: [[0,0,0,0,1,0]],
    ),
    CurriculumItem(
      id: 'BEG_005', character: 'ㅁ', name: '미음',
      description: '초성 ㅁ. 점형: 1·5번 점',
      ttsGuide: '이번 학습은 자음 미음, ㅁ입니다. 1번과 5번 점을 올려주세요.',
      dotPatterns: [[1,0,0,0,1,0]],
    ),
    CurriculumItem(
      id: 'BEG_006', character: 'ㅂ', name: '비읍',
      description: '초성 ㅂ. 점형: 4·5번 점',
      ttsGuide: '이번 학습은 자음 비읍, ㅂ입니다. 4번과 5번 점을 올려주세요.',
      dotPatterns: [[0,0,0,1,1,0]],
    ),
    CurriculumItem(
      id: 'BEG_007', character: 'ㅅ', name: '시옷',
      description: '초성 ㅅ. 점형: 6번 점 단독',
      ttsGuide: '이번 학습은 자음 시옷, ㅅ입니다. 6번 점만 올려주세요.',
      dotPatterns: [[0,0,0,0,0,1]],
    ),
    CurriculumItem(
      id: 'BEG_008', character: 'ㅇ', name: '이응',
      description: '초성 ㅇ은 점자에서 무음 처리. 6점 모두 내린 상태 [0,0,0,0,0,0]',
      ttsGuide: '이번 학습은 자음 이응, ㅇ입니다. 초성 이응은 점자에서 표기하지 않습니다. 빈 셀로 두세요.',
      dotPatterns: [[0,0,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'BEG_009', character: 'ㅈ', name: '지읒',
      description: '초성 ㅈ. 점형: 4·6번 점',
      ttsGuide: '이번 학습은 자음 지읒, ㅈ입니다. 4번과 6번 점을 올려주세요.',
      dotPatterns: [[0,0,0,1,0,1]],
    ),
    CurriculumItem(
      id: 'BEG_010', character: 'ㅊ', name: '치읓',
      description: '초성 ㅊ. 점형: 5·6번 점',
      ttsGuide: '이번 학습은 자음 치읓, ㅊ입니다. 5번과 6번 점을 올려주세요.',
      dotPatterns: [[0,0,0,0,1,1]],
    ),
    CurriculumItem(
      id: 'BEG_011', character: 'ㅋ', name: '키읔',
      description: '초성 ㅋ. 점형: 1·2·4번 점',
      ttsGuide: '이번 학습은 자음 키읔, ㅋ입니다. 1번과 2번과 4번 점을 올려주세요.',
      dotPatterns: [[1,1,0,1,0,0]],
    ),
    CurriculumItem(
      id: 'BEG_012', character: 'ㅌ', name: '티읕',
      description: '초성 ㅌ. 점형: 1·2·5번 점',
      ttsGuide: '이번 학습은 자음 티읕, ㅌ입니다. 1번과 2번과 5번 점을 올려주세요.',
      dotPatterns: [[1,1,0,0,1,0]],
    ),
    CurriculumItem(
      id: 'BEG_013', character: 'ㅍ', name: '피읖',
      description: '초성 ㅍ. 점형: 1·4·5번 점',
      ttsGuide: '이번 학습은 자음 피읖, ㅍ입니다. 1번과 4번과 5번 점을 올려주세요.',
      dotPatterns: [[1,0,0,1,1,0]],
    ),
    CurriculumItem(
      id: 'BEG_014', character: 'ㅎ', name: '히읗',
      description: '초성 ㅎ. 점형: 2·4·5번 점',
      ttsGuide: '이번 학습은 자음 히읗, ㅎ입니다. 2번과 4번과 5번 점을 올려주세요.',
      dotPatterns: [[0,1,0,1,1,0]],
    ),
  ],

  // ─────────────────────────────────────────────
  // 🔵 초급 모음  |  기본 모음 10개
  // ─────────────────────────────────────────────
  'BEG_2': [
    CurriculumItem(
      id: 'BEG_015', character: 'ㅏ', name: '아',
      description: '모음 ㅏ. 점형: 1·2·6번 점',
      ttsGuide: '이번 학습은 모음 아, ㅏ입니다. 1번과 2번과 6번 점을 올려주세요.',
      dotPatterns: [[1,1,0,0,0,1]],
    ),
    CurriculumItem(
      id: 'BEG_016', character: 'ㅑ', name: '야',
      description: '모음 ㅑ. 점형: 3·4·5번 점',
      ttsGuide: '이번 학습은 모음 야, ㅑ입니다. 3번과 4번과 5번 점을 올려주세요.',
      dotPatterns: [[0,0,1,1,1,0]],
    ),
    CurriculumItem(
      id: 'BEG_017', character: 'ㅓ', name: '어',
      description: '모음 ㅓ. 점형: 2·3·4번 점',
      ttsGuide: '이번 학습은 모음 어, ㅓ입니다. 2번과 3번과 4번 점을 올려주세요.',
      dotPatterns: [[0,1,1,1,0,0]],
    ),
    CurriculumItem(
      id: 'BEG_018', character: 'ㅕ', name: '여',
      description: '모음 ㅕ. 점형: 1·5·6번 점',
      ttsGuide: '이번 학습은 모음 여, ㅕ입니다. 1번과 5번과 6번 점을 올려주세요.',
      dotPatterns: [[1,0,0,0,1,1]],
    ),
    CurriculumItem(
      id: 'BEG_019', character: 'ㅗ', name: '오',
      description: '모음 ㅗ. 점형: 1·3·6번 점',
      ttsGuide: '이번 학습은 모음 오, ㅗ입니다. 1번과 3번과 6번 점을 올려주세요.',
      dotPatterns: [[1,0,1,0,0,1]],
    ),
    CurriculumItem(
      id: 'BEG_020', character: 'ㅛ', name: '요',
      description: '모음 ㅛ. 점형: 3·4·6번 점',
      ttsGuide: '이번 학습은 모음 요, ㅛ입니다. 3번과 4번과 6번 점을 올려주세요.',
      dotPatterns: [[0,0,1,1,0,1]],
    ),
    CurriculumItem(
      id: 'BEG_021', character: 'ㅜ', name: '우',
      description: '모음 ㅜ. 점형: 1·3·4번 점',
      ttsGuide: '이번 학습은 모음 우, ㅜ입니다. 1번과 3번과 4번 점을 올려주세요.',
      dotPatterns: [[1,0,1,1,0,0]],
    ),
    CurriculumItem(
      id: 'BEG_022', character: 'ㅠ', name: '유',
      description: '모음 ㅠ. 점형: 1·4·6번 점',
      ttsGuide: '이번 학습은 모음 유, ㅠ입니다. 1번과 4번과 6번 점을 올려주세요.',
      dotPatterns: [[1,0,0,1,0,1]],
    ),
    CurriculumItem(
      id: 'BEG_023', character: 'ㅡ', name: '으',
      description: '모음 ㅡ. 점형: 2·4·6번 점',
      ttsGuide: '이번 학습은 모음 으, ㅡ입니다. 2번과 4번과 6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,1,0,1]],
    ),
    CurriculumItem(
      id: 'BEG_024', character: 'ㅣ', name: '이',
      description: '모음 ㅣ. 점형: 1·3·5번 점',
      ttsGuide: '이번 학습은 모음 이, ㅣ입니다. 1번과 3번과 5번 점을 올려주세요.',
      dotPatterns: [[1,0,1,0,1,0]],
    ),
  ],

  // ─────────────────────────────────────────────
  // 🟢 중급 — 된소리(5) + 복합모음(11)  |  16개
  // ─────────────────────────────────────────────
  'INT_1': [
    CurriculumItem(
      id: 'INT_001', character: 'ㄲ', name: '쌍기역',
      description: '초성 ㄲ. 2셀 구성. 셀1(된소리표) / 셀2(ㄱ 초성)',
      ttsGuide: '이번 학습은 된소리 쌍기역, ㄲ입니다. 셀 2개를 사용합니다. 첫 번째 셀: 6번 점만 올려주세요. 두 번째 셀: 4번 점을 올려주세요.',
      dotPatterns: [[0,0,0,0,0,1],[0,0,0,1,0,0]],
    ),
    CurriculumItem(
      id: 'INT_002', character: 'ㄸ', name: '쌍디귿',
      description: '초성 ㄸ. 2셀 구성. 셀1(된소리표) / 셀2(ㄷ 초성)',
      ttsGuide: '이번 학습은 된소리 쌍디귿, ㄸ입니다. 첫 번째 셀: 6번 점. 두 번째 셀: 2·4번 점을 올려주세요.',
      dotPatterns: [[0,0,0,0,0,1],[0,1,0,1,0,0]],
    ),
    CurriculumItem(
      id: 'INT_003', character: 'ㅃ', name: '쌍비읍',
      description: '초성 ㅃ. 2셀 구성. 셀1(된소리표) / 셀2(ㅂ 초성)',
      ttsGuide: '이번 학습은 된소리 쌍비읍, ㅃ입니다. 첫 번째 셀: 6번 점. 두 번째 셀: 4·5번 점을 올려주세요.',
      dotPatterns: [[0,0,0,0,0,1],[0,0,0,1,1,0]],
    ),
    CurriculumItem(
      id: 'INT_004', character: 'ㅆ', name: '쌍시옷',
      description: '초성 ㅆ. 2셀 구성. 셀1(된소리표) / 셀2(ㅅ 초성)',
      ttsGuide: '이번 학습은 된소리 쌍시옷, ㅆ입니다. 두 셀 모두 6번 점만 올려주세요.',
      dotPatterns: [[0,0,0,0,0,1],[0,0,0,0,0,1]],
    ),
    CurriculumItem(
      id: 'INT_005', character: 'ㅉ', name: '쌍지읒',
      description: '초성 ㅉ. 2셀 구성. 셀1(된소리표) / 셀2(ㅈ 초성)',
      ttsGuide: '이번 학습은 된소리 쌍지읒, ㅉ입니다. 첫 번째 셀: 6번 점. 두 번째 셀: 4·6번 점을 올려주세요.',
      dotPatterns: [[0,0,0,0,0,1],[0,0,0,1,0,1]],
    ),
    CurriculumItem(
      id: 'INT_006', character: 'ㅐ', name: '애',
      description: '모음 ㅐ. 점형: 1·2·3·5번 점',
      ttsGuide: '이번 학습은 모음 애, ㅐ입니다. 1·2·3·5번 점을 올려주세요.',
      dotPatterns: [[1,1,1,0,1,0]],
    ),
    CurriculumItem(
      id: 'INT_007', character: 'ㅒ', name: '얘',
      description: '모음 ㅒ. 2셀 구성. 사용 빈도 낮음',
      ttsGuide: '이번 학습은 모음 얘, ㅒ입니다. 셀 2개를 사용합니다. 첫 번째 셀: 3·4·5번 점, 두 번째 셀: 1·2·3·5번 점을 올려주세요.',
      dotPatterns: [[0,0,1,1,1,0],[1,1,1,0,1,0]],
    ),
    CurriculumItem(
      id: 'INT_008', character: 'ㅔ', name: '에',
      description: '모음 ㅔ. 점형: 1·3·4·5번 점',
      ttsGuide: '이번 학습은 모음 에, ㅔ입니다. 1·3·4·5번 점을 올려주세요.',
      dotPatterns: [[1,0,1,1,1,0]],
    ),
    CurriculumItem(
      id: 'INT_009', character: 'ㅖ', name: '예',
      description: '모음 ㅖ. 점형: 3·4번 점. 사용 빈도 낮음',
      ttsGuide: '이번 학습은 모음 예, ㅖ입니다. 3번과 4번 점을 올려주세요.',
      dotPatterns: [[0,0,1,1,0,0]],
    ),
    CurriculumItem(
      id: 'INT_010', character: 'ㅘ', name: '와',
      description: '모음 ㅘ. 점형: 1·2·3·6번 점',
      ttsGuide: '이번 학습은 모음 와, ㅘ입니다. 1·2·3·6번 점을 올려주세요.',
      dotPatterns: [[1,1,1,0,0,1]],
    ),
    CurriculumItem(
      id: 'INT_011', character: 'ㅙ', name: '왜',
      description: '모음 ㅙ. 2셀 구성. 사용 빈도 낮음',
      ttsGuide: '이번 학습은 모음 왜, ㅙ입니다. 셀 2개를 사용합니다. 첫 번째 셀: 1·2·3·6번 점, 두 번째 셀: 1·2·3·5번 점을 올려주세요.',
      dotPatterns: [[1,1,1,0,0,1],[1,1,1,0,1,0]],
    ),
    CurriculumItem(
      id: 'INT_012', character: 'ㅚ', name: '외',
      description: '모음 ㅚ. 점형: 1·3·4·5·6번 점',
      ttsGuide: '이번 학습은 모음 외, ㅚ입니다. 1·3·4·5·6번 점을 올려주세요.',
      dotPatterns: [[1,0,1,1,1,1]],
    ),
    CurriculumItem(
      id: 'INT_013', character: 'ㅝ', name: '워',
      description: '모음 ㅝ. 점형: 1·2·3·4번 점',
      ttsGuide: '이번 학습은 모음 워, ㅝ입니다. 1·2·3·4번 점을 올려주세요.',
      dotPatterns: [[1,1,1,1,0,0]],
    ),
    CurriculumItem(
      id: 'INT_014', character: 'ㅞ', name: '웨',
      description: '모음 ㅞ. 2셀 구성. 사용 빈도 낮음',
      ttsGuide: '이번 학습은 모음 웨, ㅞ입니다. 셀 2개를 사용합니다. 첫 번째 셀: 1·2·3·4번 점, 두 번째 셀: 1·2·3·5번 점을 올려주세요.',
      dotPatterns: [[1,1,1,1,0,0],[1,1,1,0,1,0]],
    ),
    CurriculumItem(
      id: 'INT_015', character: 'ㅟ', name: '위',
      description: '모음 ㅟ. 2셀 구성. 사용 빈도 낮음',
      ttsGuide: '이번 학습은 모음 위, ㅟ입니다. 셀 2개를 사용합니다. 첫 번째 셀: 1·3·4번 점, 두 번째 셀: 1·2·3·5번 점을 올려주세요.',
      dotPatterns: [[1,0,1,1,0,0],[1,1,1,0,1,0]],
    ),
    CurriculumItem(
      id: 'INT_016', character: 'ㅢ', name: '의',
      description: '모음 ㅢ. 점형: 2·4·5·6번 점',
      ttsGuide: '이번 학습은 모음 의, ㅢ입니다. 2·4·5·6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,1,1,1]],
    ),
  ],

  // ─────────────────────────────────────────────
  // 🟢 중급 — 기본 받침 단자음  |  10개
  // ─────────────────────────────────────────────
  'INT_2': [
    CurriculumItem(
      id: 'INT_017', character: 'ㄱ받침', name: '받침 기역',
      description: '종성 ㄱ. 점형: 1번 점 단독. 초성 ㄱ과 다름 주의',
      ttsGuide: '이번 학습은 받침 기역입니다. 1번 점만 올려주세요.',
      dotPatterns: [[1,0,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'INT_018', character: 'ㄴ받침', name: '받침 니은',
      description: '종성 ㄴ. 점형: 2·5번 점',
      ttsGuide: '이번 학습은 받침 니은입니다. 2번과 5번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,1,0]],
    ),
    CurriculumItem(
      id: 'INT_019', character: 'ㄷ받침', name: '받침 디귿',
      description: '종성 ㄷ. 점형: 3·5번 점',
      ttsGuide: '이번 학습은 받침 디귿입니다. 3번과 5번 점을 올려주세요.',
      dotPatterns: [[0,0,1,0,1,0]],
    ),
    CurriculumItem(
      id: 'INT_020', character: 'ㄹ받침', name: '받침 리을',
      description: '종성 ㄹ. 점형: 2번 점 단독',
      ttsGuide: '이번 학습은 받침 리을입니다. 2번 점만 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'INT_021', character: 'ㅁ받침', name: '받침 미음',
      description: '종성 ㅁ. 점형: 2·6번 점',
      ttsGuide: '이번 학습은 받침 미음입니다. 2번과 6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,1]],
    ),
    CurriculumItem(
      id: 'INT_022', character: 'ㅂ받침', name: '받침 비읍',
      description: '종성 ㅂ. 점형: 1·2번 점',
      ttsGuide: '이번 학습은 받침 비읍입니다. 1번과 2번 점을 올려주세요.',
      dotPatterns: [[1,1,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'INT_023', character: 'ㅅ받침', name: '받침 시옷',
      description: '종성 ㅅ. 점형: 3번 점 단독',
      ttsGuide: '이번 학습은 받침 시옷입니다. 3번 점만 올려주세요.',
      dotPatterns: [[0,0,1,0,0,0]],
    ),
    CurriculumItem(
      id: 'INT_024', character: 'ㅇ받침', name: '받침 이응',
      description: '종성 ㅇ. 점형: 2·3·5·6번 점. 초성 ㅇ과 달리 받침 ㅇ은 점형 있음',
      ttsGuide: '이번 학습은 받침 이응입니다. 2·3·5·6번 점을 올려주세요.',
      dotPatterns: [[0,1,1,0,1,1]],
    ),
    CurriculumItem(
      id: 'INT_025', character: 'ㅈ받침', name: '받침 지읒',
      description: '종성 ㅈ. 점형: 1·3번 점',
      ttsGuide: '이번 학습은 받침 지읒입니다. 1번과 3번 점을 올려주세요.',
      dotPatterns: [[1,0,1,0,0,0]],
    ),
    CurriculumItem(
      id: 'INT_026', character: 'ㅎ받침', name: '받침 히읗',
      description: '종성 ㅎ. 점형: 3·5·6번 점',
      ttsGuide: '이번 학습은 받침 히읗입니다. 3·5·6번 점을 올려주세요.',
      dotPatterns: [[0,0,1,0,1,1]],
    ),
  ],

  // ─────────────────────────────────────────────
  // 🔴 고급 — 나머지 받침(6) + 겹받침(11)  |  17개
  // ─────────────────────────────────────────────
  'ADV_1': [
    CurriculumItem(
      id: 'ADV_001', character: 'ㄲ받침', name: '받침 쌍기역',
      description: '종성 ㄲ. 2셀 구성. 셀1(ㄱ) / 셀2(ㄱ)',
      ttsGuide: '이번 학습은 받침 쌍기역, ㄲ입니다. 두 셀 모두 1번 점만 올려주세요.',
      dotPatterns: [[1,0,0,0,0,0],[1,0,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_002', character: 'ㅊ받침', name: '받침 치읓',
      description: '종성 ㅊ. 점형: 2·3번 점',
      ttsGuide: '이번 학습은 받침 치읓입니다. 2번과 3번 점을 올려주세요.',
      dotPatterns: [[0,1,1,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_003', character: 'ㅋ받침', name: '받침 키읔',
      description: '종성 ㅋ. 점형: 2·3·5번 점',
      ttsGuide: '이번 학습은 받침 키읔입니다. 2·3·5번 점을 올려주세요.',
      dotPatterns: [[0,1,1,0,1,0]],
    ),
    CurriculumItem(
      id: 'ADV_004', character: 'ㅌ받침', name: '받침 티읕',
      description: '종성 ㅌ. 점형: 2·3·6번 점',
      ttsGuide: '이번 학습은 받침 티읕입니다. 2·3·6번 점을 올려주세요.',
      dotPatterns: [[0,1,1,0,0,1]],
    ),
    CurriculumItem(
      id: 'ADV_005', character: 'ㅍ받침', name: '받침 피읖',
      description: '종성 ㅍ. 점형: 2·5·6번 점',
      ttsGuide: '이번 학습은 받침 피읖입니다. 2·5·6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,1,1]],
    ),
    CurriculumItem(
      id: 'ADV_006', character: 'ㅆ받침', name: '받침 쌍시옷',
      description: '종성 ㅆ. 점형: 3·4번 점',
      ttsGuide: '이번 학습은 받침 쌍시옷, ㅆ입니다. 3번과 4번 점을 올려주세요.',
      dotPatterns: [[0,0,1,1,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_007', character: 'ㄳ받침', name: '받침 기역시옷',
      description: '종성 ㄳ. 2셀: 셀1(ㄱ) / 셀2(ㅅ)',
      ttsGuide: '이번 학습은 겹받침 기역시옷, ㄳ입니다. 첫 번째 셀: 1번 점, 두 번째 셀: 3번 점을 올려주세요.',
      dotPatterns: [[1,0,0,0,0,0],[0,0,1,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_008', character: 'ㄵ받침', name: '받침 니은지읒',
      description: '종성 ㄵ. 2셀: 셀1(ㄴ) / 셀2(ㅈ)',
      ttsGuide: '이번 학습은 겹받침 니은지읒, ㄵ입니다. 첫 번째 셀: 2·5번 점, 두 번째 셀: 1·3번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,1,0],[1,0,1,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_009', character: 'ㄶ받침', name: '받침 니은히읗',
      description: '종성 ㄶ. 2셀: 셀1(ㄴ) / 셀2(ㅎ)',
      ttsGuide: '이번 학습은 겹받침 니은히읗, ㄶ입니다. 첫 번째 셀: 2·5번 점, 두 번째 셀: 3·5·6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,1,0],[0,0,1,0,1,1]],
    ),
    CurriculumItem(
      id: 'ADV_010', character: 'ㄺ받침', name: '받침 리을기역',
      description: '종성 ㄺ. 2셀: 셀1(ㄹ) / 셀2(ㄱ)',
      ttsGuide: '이번 학습은 겹받침 리을기역, ㄺ입니다. 첫 번째 셀: 2번 점, 두 번째 셀: 1번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0],[1,0,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_011', character: 'ㄻ받침', name: '받침 리을미음',
      description: '종성 ㄻ. 2셀: 셀1(ㄹ) / 셀2(ㅁ)',
      ttsGuide: '이번 학습은 겹받침 리을미음, ㄻ입니다. 첫 번째 셀: 2번 점, 두 번째 셀: 2·6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0],[0,1,0,0,0,1]],
    ),
    CurriculumItem(
      id: 'ADV_012', character: 'ㄼ받침', name: '받침 리을비읍',
      description: '종성 ㄼ. 2셀: 셀1(ㄹ) / 셀2(ㅂ)',
      ttsGuide: '이번 학습은 겹받침 리을비읍, ㄼ입니다. 첫 번째 셀: 2번 점, 두 번째 셀: 1·2번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0],[1,1,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_013', character: 'ㄽ받침', name: '받침 리을시옷',
      description: '종성 ㄽ. 2셀: 셀1(ㄹ) / 셀2(ㅅ)',
      ttsGuide: '이번 학습은 겹받침 리을시옷, ㄽ입니다. 첫 번째 셀: 2번 점, 두 번째 셀: 3번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0],[0,0,1,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_014', character: 'ㄾ받침', name: '받침 리을티읕',
      description: '종성 ㄾ. 2셀: 셀1(ㄹ) / 셀2(ㅌ)',
      ttsGuide: '이번 학습은 겹받침 리을티읕, ㄾ입니다. 첫 번째 셀: 2번 점, 두 번째 셀: 2·3·6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0],[0,1,1,0,0,1]],
    ),
    CurriculumItem(
      id: 'ADV_015', character: 'ㄿ받침', name: '받침 리을피읖',
      description: '종성 ㄿ. 2셀: 셀1(ㄹ) / 셀2(ㅍ)',
      ttsGuide: '이번 학습은 겹받침 리을피읖, ㄿ입니다. 첫 번째 셀: 2번 점, 두 번째 셀: 2·5·6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0],[0,1,0,0,1,1]],
    ),
    CurriculumItem(
      id: 'ADV_016', character: 'ㅀ받침', name: '받침 리을히읗',
      description: '종성 ㅀ. 2셀: 셀1(ㄹ) / 셀2(ㅎ)',
      ttsGuide: '이번 학습은 겹받침 리을히읗, ㅀ입니다. 첫 번째 셀: 2번 점, 두 번째 셀: 3·5·6번 점을 올려주세요.',
      dotPatterns: [[0,1,0,0,0,0],[0,0,1,0,1,1]],
    ),
    CurriculumItem(
      id: 'ADV_017', character: 'ㅄ받침', name: '받침 비읍시옷',
      description: '종성 ㅄ. 2셀: 셀1(ㅂ) / 셀2(ㅅ)',
      ttsGuide: '이번 학습은 겹받침 비읍시옷, ㅄ입니다. 첫 번째 셀: 1·2번 점, 두 번째 셀: 3번 점을 올려주세요.',
      dotPatterns: [[1,1,0,0,0,0],[0,0,1,0,0,0]],
    ),
  ],

  // ─────────────────────────────────────────────
  // 🔴 고급 — 숫자  |  5개
  // ─────────────────────────────────────────────
  'ADV_2': [
    CurriculumItem(
      id: 'ADV_018', character: '1·2·3', name: '숫자 1, 2, 3',
      description: '숫자는 앞에 숫자 표시(3·4·5·6번점)가 붙음. 1=[1,0,0,0,0,0] / 2=[1,1,0,0,0,0] / 3=[1,0,0,1,0,0]',
      ttsGuide: '이번 학습은 숫자 1, 2, 3입니다. 숫자 표시 후 해당 점형을 올려주세요.',
      dotPatterns: [[1,0,0,0,0,0]],
    ),
    CurriculumItem(
      id: 'ADV_019', character: '4·5·6', name: '숫자 4, 5, 6',
      description: '4=[1,0,0,1,1,0] / 5=[1,0,0,0,1,0] / 6=[1,1,0,1,0,0]',
      ttsGuide: '이번 학습은 숫자 4, 5, 6입니다. 해당 점형을 올려주세요.',
      dotPatterns: [[1,0,0,1,1,0]],
    ),
    CurriculumItem(
      id: 'ADV_020', character: '7·8·9', name: '숫자 7, 8, 9',
      description: '7=[1,1,0,1,1,0] / 8=[1,1,0,0,1,0] / 9=[0,1,0,1,0,0]',
      ttsGuide: '이번 학습은 숫자 7, 8, 9입니다. 해당 점형을 올려주세요.',
      dotPatterns: [[1,1,0,1,1,0]],
    ),
    CurriculumItem(
      id: 'ADV_021', character: '0', name: '숫자 0',
      description: '숫자 0 점형: [0,1,0,1,1,0]',
      ttsGuide: '이번 학습은 숫자 0입니다. 해당 점형을 올려주세요.',
      dotPatterns: [[0,1,0,1,1,0]],
    ),
    CurriculumItem(
      id: 'ADV_022', character: '혼합', name: '숫자 혼합 연습',
      description: '0~9 중 랜덤 출제. 숫자 표시 포함 연습',
      ttsGuide: '숫자 혼합 연습입니다. 화면에 나오는 숫자의 점형을 올려주세요.',
      dotPatterns: [[0,1,0,1,1,0]],
    ),
  ],
};

/// 레벨 ID별 표시 정보
const Map<String, Map<String, String>> levelInfo = {
  'ENT_1': {'title': '입문', 'subtitle': '점 위치 번호 익히기', 'group': 'intro'},
  'BEG_1': {'title': '초급 — 자음', 'subtitle': '자음 초성 14개', 'group': 'beginner'},
  'BEG_2': {'title': '초급 — 모음', 'subtitle': '기본 모음 10개', 'group': 'beginner'},
  'INT_1': {'title': '중급 — 된소리·복합모음', 'subtitle': '된소리 5개 + 복합모음 11개', 'group': 'intermediate'},
  'INT_2': {'title': '중급 — 받침', 'subtitle': '기본 받침 단자음 10개', 'group': 'intermediate'},
  'ADV_1': {'title': '고급 — 겹받침', 'subtitle': '나머지·겹받침 17개', 'group': 'advanced'},
  'ADV_2': {'title': '고급 — 숫자', 'subtitle': '숫자 0~9', 'group': 'advanced'},
};