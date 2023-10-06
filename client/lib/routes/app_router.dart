import 'package:client/screens/home_screen/home_screen.dart';
import 'package:client/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

import '../screens/main_screen/main_screen.dart';

class Routes {
  static String splash = "/splash";
  static String main = "/main";
  static String home = "/home";
  static String account = "/account";

  static final Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) {
      return SplashScreen();
    },
    main: (context) {
      return MainScreen();
    },
    home: (context) => HomeScreen()
  };
}
