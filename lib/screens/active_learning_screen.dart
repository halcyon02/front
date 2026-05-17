import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:puzzle_dot/core/constants/prefs_keys.dart';
import 'package:puzzle_dot/models/curriculum_item.dart';
import 'package:puzzle_dot/services/app_tts_service.dart';
import 'package:puzzle_dot/services/camera_service.dart';
import 'package:puzzle_dot/services/hint_service.dart';
import 'package:puzzle_dot/services/permission_service.dart';
import 'package:puzzle_dot/services/progress_service.dart';
import 'package:puzzle_dot/screens/camera_guide_screen.dart';
import 'package:puzzle_dot/screens/level_completion_screen.dart';
import 'package:puzzle_dot/screens/permission_screen.dart';

class ActiveLearningScreen extends StatefulWidget {
  final CurriculumItem item;
  final String levelId;
  final String levelName;
  final List<CurriculumItem> allItems;
  final int currentIndex;

  const ActiveLearningScreen({
    super.key,
    required this.item,
    required this.levelId,
    required this.levelName,
    required this.allItems,
    required this.currentIndex,
  });

  @override
  State<ActiveLearningScreen> createState() =>
      _ActiveLearningScreenState();
}

class _ActiveLearningScreenState
    extends State<ActiveLearningScreen> {
  // DIP: 추상에 의존
  final AppTtsService _tts = AppTtsService();
  final CameraService _camera = CameraService();

  bool _showGuide = false;    // 카메라 거치 가이드 표시 여부
  bool _cameraReady = false;
  bool _isCapturing = false;
  int _wrongCount = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // 1. 권한 확인 (PERM_001)
    final hasPermission = await PermissionService.requestCamera();
    if (!hasPermission) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => const PermissionScreen()),
        );
      }
      return;
    }

    // 2. 카메라 거치 가이드 최초 1회 확인
    final prefs = await SharedPreferences.getInstance();
    final guideKey =
        '${PrefsKeys.cameraGuidePrefix}${widget.levelId}';
    final guideSeen = prefs.getBool(guideKey) ?? false;

    if (!guideSeen && mounted) {
      setState(() => _showGuide = true);
      return; // 가이드 확인 후 _onGuideConfirmed 호출됨
    }

    await _startCamera();
  }

  Future<void> _onGuideConfirmed() async {
    if (mounted) setState(() => _showGuide = false);
    await _startCamera();
  }

  Future<void> _startCamera() async {
    final ok = await _camera.initialize();
    if (mounted) setState(() => _cameraReady = ok);
    if (ok) {
      // EDU_001b: 카메라 준비 완료 안내
      await _tts.speak(
          '카메라가 점자판 위에 위치했나요? 준비되면 촬영 버튼을 눌러주세요.');
      await Future.delayed(const Duration(milliseconds: 500));
      // EDU_002: 학습 항목 TTS 안내
      await _tts.speak(widget.item.ttsGuide);
    }
  }

  // ── 촬영 ──────────────────────────────────────
  Future<void> _capture() async {
    if (!_cameraReady || _isCapturing) return;
    setState(() => _isCapturing = true);

    // EDU_003: 분석 중 안내
    await _tts.speak('분석 중입니다. 잠시 기다려주세요.');

    final imagePath = await _camera.capture();
    if (imagePath == null) {
      await _tts.speak(HintService.recognitionFailed);
      if (mounted) setState(() => _isCapturing = false);
      return;
    }

    await _analyze(imagePath);
  }

  Future<void> _analyze(String imagePath) async {
    // 실제 AI 연동 시 python_bridge.call(imagePath) 교체
    await Future.delayed(const Duration(milliseconds: 600));

    final answer = widget.item.dotPatterns[0];
    final resultVector = _simulateVector(answer);

    // 인식 실패: 빈 벡터이면서 BEG_008이 아닌 경우 (⑦-5)
    if (resultVector.every((v) => v == 0) &&
        widget.item.id != 'BEG_008') {
      await _tts.speak(HintService.recognitionFailed);
      if (mounted) setState(() => _isCapturing = false);
      return;
    }

    final isCorrect =
        _vectorsEqual(answer, resultVector);

    if (isCorrect) {
      await _handleCorrect();
    } else {
      await _handleWrong(answer, resultVector);
    }
  }

  Future<void> _handleCorrect() async {
    await ProgressService.markCompleted(widget.item.id);
    // EDU_004: 정답 안내 + 1.5초 후 자동 이동
    await _tts.speak('정답입니다!');
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;
    _goToNext();
  }

  Future<void> _handleWrong(
      List<int> answer, List<int> result) async {
    _wrongCount++;
    // EDU_005: 오답 힌트 TTS (HintService)
    final hint = HintService.generateHint(
      answer: answer,
      result: result,
      wrongCount: _wrongCount,
    );
    await _tts.speak(hint);
    if (mounted) setState(() => _isCapturing = false);
  }

  void _goToNext() {
    final nextIndex = widget.currentIndex + 1;
    final hasNext = nextIndex < widget.allItems.length;

    if (hasNext) {
      // 다음 항목으로 자동 이동 (EDU_004)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ActiveLearningScreen(
            item: widget.allItems[nextIndex],
            levelId: widget.levelId,
            levelName: widget.levelName,
            allItems: widget.allItems,
            currentIndex: nextIndex,
          ),
        ),
      );
    } else {
      // 마지막 항목 → 학습 완료 (EDU_006)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => LevelCompletionScreen(
            levelId: widget.levelId,
            levelName: widget.levelName,
            itemName: widget.item.name,
          ),
        ),
      );
    }
  }

  // ── 시뮬레이션 (AI 연동 전 임시) ───────────────
  List<int> _simulateVector(List<int> answer) {
    // 70% 정답
    if (DateTime.now().millisecond % 10 < 7) {
      return List.from(answer);
    }
    final wrong = List<int>.from(answer);
    wrong[DateTime.now().millisecond % 6] ^= 1;
    return wrong;
  }

  bool _vectorsEqual(List<int> a, List<int> b) {
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  void dispose() {
    _tts.dispose();
    _camera.dispose();
    super.dispose();
  }

  // ── UI ────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    // 카메라 거치 가이드 (최초 1회)
    if (_showGuide) {
      return CameraGuideScreen(
        levelId: widget.levelId,
        onConfirm: _onGuideConfirmed,
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // ── 카메라 프리뷰 ──────────────────
            if (_cameraReady && _camera.controller != null)
              Positioned.fill(
                child: CameraPreview(_camera.controller!),
              )
            else
              const Center(
                child: CircularProgressIndicator(
                    color: Colors.white),
              ),

            // ── 상단 HUD ──────────────────────
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                    20, 16, 20, 16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black87, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // 뒤로가기
                        IconButton(
                          icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20),
                          onPressed: () =>
                              Navigator.maybePop(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${widget.levelName}  ${widget.currentIndex + 1}/${widget.allItems.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // 다시 듣기
                        Semantics(
                          button: true,
                          label: '안내 다시 듣기',
                          child: IconButton(
                            icon: const Icon(Icons.volume_up,
                                color: Colors.white70),
                            onPressed: () =>
                                _tts.speak(widget.item.ttsGuide),
                          ),
                        ),
                      ],
                    ),
                    // 학습 목표
                    Container(
                      margin: const EdgeInsets.only(
                          left: 8, top: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${widget.item.character}  ${widget.item.name}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── 하단 컨트롤 ───────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                    24, 24, 24, 36),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    // 오답 카운터
                    if (_wrongCount > 0)
                      Padding(
                        padding:
                            const EdgeInsets.only(bottom: 16),
                        child: Text(
                          '오답 $_wrongCount회',
                          style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    // 촬영 버튼
                    Semantics(
                      button: true,
                      label: '촬영 버튼',
                      child: GestureDetector(
                        onTap: _capture,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isCapturing
                                ? Colors.white38
                                : Colors.white,
                            border: Border.all(
                                color: Colors.white54,
                                width: 4),
                          ),
                          child: _isCapturing
                              ? const Padding(
                                  padding:
                                      EdgeInsets.all(20),
                                  child:
                                      CircularProgressIndicator(
                                    color: Colors.black54,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Icon(
                                  Icons.camera_alt,
                                  size: 36,
                                  color: Colors.black87,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '점자판 완성 후 촬영 버튼을 누르세요',
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}