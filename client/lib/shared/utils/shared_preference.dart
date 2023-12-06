import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPR {
  late final SharedPreferences prefs;
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? get accessToken => prefs.getString('access_token');
  String? get refreshToken => prefs.getString('refresh_token');
  bool get isRefreshToken => prefs.getBool("is_refresh_token") ?? false;
  bool get isShowCameraUrlHint =>
      prefs.getBool('is_show_camera_url_hint') ?? false;
  bool get isShowCameraControllerHint =>
      prefs.getBool('is_show_camera_controller_hint') ?? false;
  bool get isShowLabelActionHint =>
      prefs.getBool('is_show_label_action_hint') ?? false;

  void setIsShowCameraUrlHint() async {
    await prefs.setBool('is_show_camera_url_hint', true);
  }

  void setIsShowCameraControllerHint() async {
    await prefs.setBool('is_show_camera_controller_hint', true);
  }

  void setIsShowLabelActionHint() async {
    await prefs.setBool('is_show_label_action_hint', true);
  }

  Future setToken(String accessToken, String refreshToken) async {
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future clear() async {
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('is_refresh_token');
  }
}

AppSharedPR sp = AppSharedPR();
