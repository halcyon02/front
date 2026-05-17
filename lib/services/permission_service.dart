import 'package:permission_handler/permission_handler.dart';

/// 카메라 권한 요청 및 상태 확인 (PERM_001·002).
abstract class PermissionService {
  PermissionService._();

  /// 권한 요청 후 허용 여부 반환.
  /// permanentlyDenied 포함 모든 거부 상태 → false.
  static Future<bool> requestCamera() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// 현재 권한 상태만 확인 (요청 없음).
  static Future<bool> checkCamera() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  /// 앱 설정 화면 열기 (permanentlyDenied 시 사용).
  static Future<void> openSettings() => openAppSettings();
}