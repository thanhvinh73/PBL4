import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPR {
  late final SharedPreferences prefs;

  String? get baseApi => prefs.getString('base_api');
  String? get accessToken => prefs.getString('access_token');
  bool get loggedBefore => prefs.getBool('logged_before') ?? false;
  set loggedBefore(bool value) => prefs.setBool('logged_before', value);
  String? get refreshToken => prefs.getString('refresh_token');

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future setToken(String accessToken, String refreshToken) async {
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future clear() async {
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }
}

AppSharedPR sp = AppSharedPR();
