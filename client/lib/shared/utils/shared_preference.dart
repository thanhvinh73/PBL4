import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPR {
  late final SharedPreferences prefs;
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? get accessToken => prefs.getString('access_token');
  String? get refreshToken => prefs.getString('refresh_token');
  bool get isRefreshToken => prefs.getBool("is_refresh_token") ?? false;
  bool get isLogInBefore => prefs.getBool('is_log_in_before') ?? false;

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
