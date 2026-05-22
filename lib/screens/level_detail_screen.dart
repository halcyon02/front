import 'package:flutter/material.dart';

// [TODO]
// 이 파일은 학습 화면 연동 테스트를 위한 임시 파일입니다.
// 유나님이 작업하신 실제 '학습하기' 파일과 합친 후, 이 파일은 삭제하거나 해당 파일로 완전히 교체해 주세요.

class LevelDetailScreen extends StatelessWidget {
  final String levelId;
  final String stageTitle;
  final String stageDescription;

  const LevelDetailScreen({
    super.key,
    required this.levelId,
    required this.stageTitle,
    required this.stageDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$stageTitle Level')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Level ID: $levelId',
                style: const TextStyle(fontSize: 14, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),
              Text(
                stageTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                stageDescription,
                style: const TextStyle(fontSize: 16, color: Color(0xFF475569)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Detailed content for this level will be added soon.',
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Semantics(
                button: true,
                label: 'Start level button',
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    // [TODO] 현재는 테스트용으로 단순 pop 처리되어 있습니다.
                    // 실제 학습 위젯으로 내비게이션을 변경해 주세요.
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Start Learning',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
