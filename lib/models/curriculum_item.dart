class CurriculumItem {
  final String id;
  final String character; // 글자 표기 (①, ㄱ, ㅏ ...)
  final String name;      // 이름/읽기 (1번 점, 기역 ...)
  final String description;
  final String ttsGuide;
  final List<List<int>> dotPatterns; // 셀별 6점 벡터

  const CurriculumItem({
    required this.id,
    required this.character,
    required this.name,
    required this.description,
    required this.ttsGuide,
    required this.dotPatterns,
  });

  bool get isMultiCell => dotPatterns.length > 1;

  String get dotLabel {
    if (isMultiCell) {
      return dotPatterns
          .asMap()
          .entries
          .map((e) => '셀${e.key + 1}: ${_vec(e.value)}')
          .join(' / ');
    }
    return _vec(dotPatterns[0]);
  }

  static String _vec(List<int> d) {
    final on = [for (int i = 0; i < d.length; i++) if (d[i] == 1) i + 1];
    if (on.isEmpty) return '빈 셀 (없음)';
    return on.map((n) => '$n번').join('·') + ' 점';
  }
}