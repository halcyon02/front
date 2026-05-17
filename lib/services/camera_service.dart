import 'package:camera/camera.dart';

/// 카메라 초기화·캡처·해제를 캡슐화합니다.
/// 화면은 이 서비스를 통해서만 카메라에 접근합니다 (DIP).
class CameraService {
  CameraController? _controller;

  bool get isReady => _controller?.value.isInitialized == true;
  CameraController? get controller => _controller;

  /// 후면 카메라 초기화. 실패 시 false 반환.
  Future<bool> initialize() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return false;

      // 후면 카메라 우선 선택
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await _controller!.initialize();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 정지 이미지 캡처. 실패 시 null 반환.
  Future<String?> capture() async {
    if (!isReady) return null;
    try {
      final file = await _controller!.takePicture();
      return file.path;
    } catch (_) {
      return null;
    }
  }

  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}