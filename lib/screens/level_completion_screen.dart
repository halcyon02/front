import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:puzzle_dot/services/tts_manager.dart';
import 'home_screen.dart';
import 'level_detail_screen.dart';

class LevelCompletionScreen extends StatefulWidget {
  //
  // 현재 아래 변수들은 학습 완료 창 테스트를 위한 더미 데이터입니다.
  // 실제 학습 화면과 연동 시, 해당 화면에서 계산된  결과값을 생성자 매개변수로 넘겨받도록 해야 합니다.

  final String levelId;
  final String levelName;
  final String nextLevelId;
  final String nextLevelName;
  final int correctCount;
  final int totalCount;

  const LevelCompletionScreen({
    super.key,
    // [TODO] 학습 창에서 실제 데이터가 넘어오면 기본값 제거
    this.levelId = 'ENT_001',
    this.levelName = '입문 1',
    this.nextLevelId = 'BAS_001',
    this.nextLevelName = '초급',
    this.correctCount = 5,
    this.totalCount = 10,
  });

  @override
  State<LevelCompletionScreen> createState() => _LevelCompletionScreenState();
}

class _LevelCompletionScreenState extends State<LevelCompletionScreen> {
  // 변수 및 컨트롤러 관리
  final FlutterTts _tts = FlutterTts();
  bool _isSpeaking = false;

  // 포커스 이동을 위한 노드 관리
  final FocusNode _replayFocus = FocusNode();
  final FocusNode _nextButtonFocus = FocusNode();
  final FocusNode _retryButtonFocus = FocusNode();
  final FocusNode _homeButtonFocus = FocusNode();

  // 학습 상태 체크 로직
  bool get _isSuccess => widget.correctCount >= 5;
  bool get _isReviewRecommended =>
      (widget.correctCount / widget.totalCount) < 0.8;

  // 생명주기 및 초기화 로직

  @override
  void initState() {
    super.initState();
    TtsManager.instance.register(_tts);
    _initializeTts();

    // 성공 시 완료 데이터 기록
    if (_isSuccess) {
      _markLevelCompleted();
    }
    // 결과 음성 안내 시작
    _speakCompletionMessage();
  }

  // 비즈니스 로직 (데이터, TTS, 내비게이션)

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

    // UI 렌더링 후 포커스 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) FocusScope.of(context).requestFocus(_replayFocus);
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
    if (mounted) setState(() => _isSpeaking = false);
  }

  // 화면 이동 로직들
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
      // [TODO] 현재는 더미 파일인 LevelDetailScreen으로 임시 연결되어 있습니다.
      // 파일 동기화 후, 유나님이 작업한 실제 '학습하기' 창이랑 교체해 주세요.
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
      // [TODO]
      // '학습 다시하기'와 마찬가지로, 파일 동기화 후 유나님이 작업한 '학습하기' 창으로 연동해 주세요.
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

  // UI 빌드
  @override
  Widget build(BuildContext context) {
    final double progressValue = widget.correctCount / widget.totalCount;
    final int progressPercent = (progressValue * 100).toInt();

    // 상태에 따른 UI 구성 요소 결정
    String recommendationTitle = '';
    String recommendationText = '';
    Gradient boxGradient;
    IconData boxIcon;

    if (_isSuccess) {
      if (_isReviewRecommended) {
        recommendationTitle = '한 번 더 복습하기';
        recommendationText = '정확도를 높이기 위해 한 번 더 연습하면 실력이 더 탄탄해져요.';
        boxGradient = const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF4ADE80)],
        );
        boxIcon = Icons.star_rounded;
      } else {
        recommendationTitle = '다음 단계 학습하기';
        recommendationText = '훌륭한 실력이에요! 흐름을 이어 바로 다음 단계로 넘어가 볼까요?';
        boxGradient = const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
        );
        boxIcon = Icons.forward_rounded;
      }
    } else {
      recommendationTitle = '다시 학습하기';
      recommendationText = '통과 기준(5개)에 아쉽게 미치지 못했습니다. 다시 시작해 보세요.';
      boxGradient = const LinearGradient(
        colors: [Color(0xFFF87171), Color(0xFFDC2626)],
      );
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCustomAppBar(),
                const SizedBox(height: 16),
                _buildResultContentStack(
                  boxGradient,
                  boxIcon,
                  recommendationTitle,
                  recommendationText,
                  progressValue,
                  progressPercent,
                ),
                const SizedBox(height: 20),
                _buildActionButtons(recommendationTitle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 모듈화된 UI 컴포넌트들
  Widget _buildCustomAppBar() {
    return Row(
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
                  BoxShadow(color: Color(0x14000000), blurRadius: 18),
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
    );
  }

  Widget _buildResultContentStack(
    Gradient grad,
    IconData icon,
    String title,
    String text,
    double progress,
    int percent,
  ) {
    return Stack(
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
              _buildResultIcon(grad, icon),
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
              _buildRecommendationBox(grad, icon, title, text),
              const SizedBox(height: 16),
              _buildProgressBar(progress),
              const SizedBox(height: 20),
              _buildSyncLabel(percent),
            ],
          ),
        ),
        _buildReplayButton(),
      ],
    );
  }

  Widget _buildResultIcon(Gradient grad, IconData icon) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: grad),
      child: Icon(
        _isSuccess ? Icons.emoji_events : Icons.sentiment_very_dissatisfied,
        size: 32,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRecommendationBox(
    Gradient grad,
    IconData icon,
    String title,
    String text,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: grad,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: _isSuccess
                ? const Color(0x333B82F6)
                : const Color(0x33DC2626),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.95),
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        backgroundColor: _isSuccess
            ? const Color(0xFFE0F2FE)
            : const Color(0xFFFEE2E2),
        valueColor: AlwaysStoppedAnimation<Color>(
          _isSuccess ? const Color(0xFF3B82F6) : const Color(0xFFEF4444),
        ),
      ),
    );
  }

  Widget _buildSyncLabel(int percent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sync, color: Color(0xFF64748B), size: 16),
          const SizedBox(width: 8),
          Text(
            '학습 진도 동기화 완료 ($percent%)',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplayButton() {
    return Positioned(
      right: 16,
      top: 16,
      child: Semantics(
        button: true,
        label: '음성 다시 듣기',
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _speakCompletionMessage,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Focus(
              focusNode: _replayFocus,
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
    );
  }

  Widget _buildActionButtons(String title) {
    return Column(
      children: [
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
                    colors: [Color(0xFF3B82F6), Color(0xFF4ADE80)],
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
