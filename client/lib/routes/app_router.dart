import 'package:client/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../screens/main_screen/main_screen.dart';

class Routes {
  static String splash = "/splash";
  static String main = "/main";

  static final Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) {
      return SplashScreen();
    },
    main: (context) {
      String baseUrl = ModalRoute.of(context)?.settings.arguments as String;
      return MainScreen(baseUrl: baseUrl);
    }
  };
}
