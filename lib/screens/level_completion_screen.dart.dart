import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:puzzle_dot/services/tts_manager.dart';
import 'home_screen.dart';
import 'level_detail_screen.dart';

class LevelCompletionScreen extends StatefulWidget {
  final String levelId;
  final String levelName;
  final String nextLevelId;
  final String nextLevelName;
  final int correctCount;
  final int totalCount;

  const LevelCompletionScreen({
    super.key,
    this.levelId = 'ENT_001',
    this.levelName = '입문 1',
    this.nextLevelId = 'BAS_001',
    this.nextLevelName = '초급',
    this.correctCount = 4,
    this.totalCount = 10,
  });

  @override
  State<LevelCompletionScreen> createState() => _LevelCompletionScreenState();
}

class _LevelCompletionScreenState extends State<LevelCompletionScreen> {
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;
  final FocusNode _replayFocus = FocusNode();
  final FocusNode _nextButtonFocus = FocusNode();
  final FocusNode _retryButtonFocus = FocusNode();
  final FocusNode _homeButtonFocus = FocusNode();

  bool get _isSuccess => widget.correctCount >= 5;
  bool get _isReviewRecommended =>
      (widget.correctCount / widget.totalCount) < 0.8;

  @override
  void initState() {
    super.initState();
    TtsManager.instance.register(_tts);
    _initializeTts();
    if (_isSuccess) {
      _markLevelCompleted();
    }
    _speakCompletionMessage();
  }

  Future<void> _initializeTts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      double savedSpeed = prefs.getDouble('tts_speed') ?? 0.45;
      double savedVolume = prefs.getDouble('tts_volume') ?? 1.0;

      await _tts.setLanguage('ko-KR');
      await _tts.setSpeechRate(savedSpeed);
      await _tts.setVolume(savedVolume);
      await _tts.setPitch(1.0);
    } catch (_) {}
  }

  Future<void> _markLevelCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('done_${widget.levelId}', true);
  }

  Future<void> _speakCompletionMessage() async {
    String message = '';
    if (_isSuccess) {
      final levelMessage = '${widget.levelName} 학습을 완료했습니다.';
      message = _isReviewRecommended
          ? '$levelMessage 정확도를 높이기 위해 한 번 더 연습하면 실력이 더 탄탄해져요. 학습 다시하기 버튼을 눌러 복습을 시작해 보세요.'
          : '$levelMessage 훌륭한 실력이에요! 다음 학습 버튼을 눌러 바로 다음 단계로 넘어가 보세요.';
    } else {
      message =
          '${widget.levelName} 학습에 실패했습니다. 통과 기준에 아쉽게 미치지 못했습니다. 학습 다시하기 버튼을 눌러 재도전해 보세요.';
    }

    setState(() => _isSpeaking = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(_replayFocus);
      }
    });

    try {
      await _tts.speak(message);
    } catch (_) {}

    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      setState(() => _isSpeaking = false);
      _focusRecommendedAction();
    }
  }

  void _focusRecommendedAction() {
    if (!mounted) return;
    final focusNode = (!_isSuccess || _isReviewRecommended)
        ? _retryButtonFocus
        : _nextButtonFocus;
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> _stopTts() async {
    try {
      _tts.stop();
    } catch (_) {}
    if (mounted) {
      setState(() => _isSpeaking = false);
    }
  }

  Future<void> _goHome() async {
    await _stopTts();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
        (route) => false,
      );
    }
  }

  Future<void> _retryLearning() async {
    await _stopTts();
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LevelDetailScreen(
            levelId: widget.levelId,
            stageTitle: widget.levelName,
            stageDescription: '${widget.levelName} 단계를 다시 시작합니다.',
          ),
        ),
      );
    }
  }

  Future<void> _goNextLearning() async {
    if (!_isSuccess) return;
    await _stopTts();
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LevelDetailScreen(
            levelId: widget.nextLevelId,
            stageTitle: widget.nextLevelName,
            stageDescription: '${widget.nextLevelName} 단계를 시작합니다.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progressValue = widget.correctCount / widget.totalCount;
    final int progressPercent = (progressValue * 100).toInt();

    String recommendationTitle = '';
    String recommendationText = '';
    Gradient boxGradient;
    Color textColor = const Color(0xFF1E293B); // 기본 어두운 글자색
    IconData boxIcon;

    if (_isSuccess) {
      if (_isReviewRecommended) {
        recommendationTitle = '한 번 더 복습하기';
        recommendationText = '정확도를 높이기 위해 한 번 더 연습하면 실력이 더 탄탄해져요.';
        // 연한 파스텔톤 블루
        boxGradient = const LinearGradient(
          colors: [Color(0xFFE0F2FE), Color(0xFFDBEAFE)],
        );
        boxIcon = Icons.star_rounded;
      } else {
        recommendationTitle = '다음 단계 학습하기';
        recommendationText = '훌륭한 실력이에요! 흐름을 이어 바로 다음 단계로 넘어가 볼까요?';
        // 연한 파스텔톤 그린
        boxGradient = const LinearGradient(
          colors: [Color(0xFFDCFCE7), Color(0xFFD1FAE5)],
        );
        boxIcon = Icons.forward_rounded;
      }
    } else {
      recommendationTitle = '다시 학습하기';
      recommendationText = '통과 기준(5개)에 아쉽게 미치지 못했습니다. 다시 시작해 보세요.';
      // 연한 파스텔톤 레드
      boxGradient = const LinearGradient(
        colors: [Color(0xFFFEE2E2), Color(0xFFFDE6E8)],
      );
      textColor = const Color(0xFF450A0A); // 실패 시 살짝 더 붉은 톤 글자색
      boxIcon = Icons.refresh_rounded;
    }

    return WillPopScope(
      onWillPop: () async {
        await _stopTts();
        return true;
      },
      child: Scaffold(
        backgroundColor: _isSuccess
            ? const Color(0xFFE8F4FF)
            : const Color(0xFFFFF1F1),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Semantics(
                        button: true,
                        label: '뒤로가기',
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            await _stopTts();
                            if (mounted) Navigator.maybePop(context);
                          },
                          child: Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x14000000),
                                  blurRadius: 18,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: _isSuccess
                                  ? const Color(0xFF2563EB)
                                  : const Color(0xFFDC2626),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          _isSuccess ? '학습 완료' : '학습 실패',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x10000000),
                              blurRadius: 30,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: _isSuccess
                                      ? [
                                          const Color(0xFF60A5FA),
                                          const Color(0xFF3B82F6),
                                        ]
                                      : [
                                          const Color(0xFFF87171),
                                          const Color(0xFFDC2626),
                                        ],
                                ),
                              ),
                              child: Icon(
                                _isSuccess
                                    ? Icons.emoji_events
                                    : Icons.sentiment_very_dissatisfied,
                                size: 32,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _isSuccess
                                  ? '${widget.levelName} 학습을\n완료했습니다.'
                                  : '${widget.levelName} 학습에\n실패했습니다.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '결과: ${widget.correctCount} / ${widget.totalCount} 문제 맞춤',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: _isSuccess
                                    ? const Color(0xFF2563EB)
                                    : const Color(0xFFDC2626),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                gradient: boxGradient,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(boxIcon, color: textColor, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        recommendationTitle,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    recommendationText,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: textColor.withOpacity(0.8),
                                      height: 1.4,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                minHeight: 8,
                                backgroundColor: _isSuccess
                                    ? const Color(0xFFE0F2FE)
                                    : const Color(0xFFFEE2E2),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _isSuccess
                                      ? const Color(0xFF3B82F6)
                                      : const Color(0xFFEF4444),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: Semantics(
                          button: true,
                          label: '음성 다시 듣기',
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: _speakCompletionMessage,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.volume_up,
                                    size: 18,
                                    color: _isSpeaking
                                        ? const Color(0xFF22C55E)
                                        : const Color(0xFF1E293B),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    '다시 듣기',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOutlineButton(
                          label: '학습 다시하기',
                          onPressed: _retryLearning,
                          focusNode: _retryButtonFocus,
                          borderColor: _isSuccess
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFDC2626),
                          textColor: _isSuccess
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFDC2626),
                        ),
                      ),
                      if (_isSuccess) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildGradientButton(
                            label: '다음 학습',
                            onPressed: _goNextLearning,
                            focusNode: _nextButtonFocus,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF22C55E)],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildOutlineButton(
                    label: '홈으로 가기',
                    onPressed: _goHome,
                    focusNode: _homeButtonFocus,
                    borderColor: _isSuccess
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFDC2626),
                    textColor: _isSuccess
                        ? const Color(0xFF2563EB)
                        : const Color(0xFFDC2626),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String label,
    required VoidCallback onPressed,
    required Gradient gradient,
    FocusNode? focusNode,
  }) {
    return SizedBox(
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(28),
        ),
        child: ElevatedButton(
          focusNode: focusNode,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton({
    required String label,
    required VoidCallback onPressed,
    required Color borderColor,
    required Color textColor,
    FocusNode? focusNode,
  }) {
    return SizedBox(
      height: 56,
      child: OutlinedButton(
        focusNode: focusNode,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 1.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
