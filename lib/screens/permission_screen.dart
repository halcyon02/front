import 'package:flutter/material.dart';
import 'package:puzzle_dot/services/app_tts_service.dart';
import 'package:puzzle_dot/services/permission_service.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final AppTtsService _tts = AppTtsService();

  @override
  void initState() {
    super.initState();
    _tts.speak('카메라 권한이 필요합니다. 설정에서 카메라 권한을 허용해주세요.');
  }

  @override
  void dispose() {
    _tts.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                size: 72,
                color: Color(0xFF94A3B8),
              ),
              const SizedBox(height: 28),
              const Text(
                '카메라 권한이 필요합니다',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                '점자 학습을 위해 카메라 접근 권한이 필요합니다.\n설정에서 카메라 권한을 허용해주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 40),
              Semantics(
                button: true,
                label: '설정으로 이동, 버튼',
                child: SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      await PermissionService.openSettings();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    child: const Text(
                      '설정으로 이동',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Semantics(
                button: true,
                label: '홈으로 돌아가기, 버튼',
                child: SizedBox(
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.popUntil(context, (r) => r.isFirst),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Color(0xFF2563EB), width: 1.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    child: const Text(
                      '홈으로 돌아가기',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2563EB)),
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