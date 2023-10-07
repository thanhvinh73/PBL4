import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  static Future<bool> requestCamera() async {
    var status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }
}
