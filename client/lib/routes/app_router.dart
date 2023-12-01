import 'package:client/screens/connect_to_server_screen/connect_to_server_screen.dart';
import 'package:client/screens/home_screen/home_screen.dart';
import 'package:client/screens/login_screen/login_screen.dart';
import 'package:client/screens/profile_screen.dart/profile_screen.dart';
import 'package:client/screens/register_screen/register_screen.dart';
import 'package:client/screens/splash_screen/splash_screen.dart';
import 'package:client/screens/update_profile_screen/update_profile_screen.dart';
import 'package:flutter/material.dart';

import '../screens/main_screen/main_screen.dart';

class Routes {
  static String splash = "/splash";
  static String connectToServer = "/connect-to-server";
  static String main = "/main";
  static String home = "/home";
  static String account = "/account";
  static String login = "/login";
  static String register = "/register";
  static String profileScreen = "/profile-screen";
  static String updateProfileScreen = "/update-profile-screen";

  static final Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) {
      return SplashScreen();
    },
    connectToServer: (context) {
      return ConnectToServerScreen();
    },
    main: (context) {
      return const MainScreen();
    },
    home: (context) => HomeScreen(),
    login: (context) => LoginScreen(),
    register: (context) => RegisterScreen(),
    profileScreen: (context) => const ProfileScreen(),
    updateProfileScreen: (context) {
      String userId = ModalRoute.of(context)?.settings.arguments as String;
      return UpdateProfileScreen(userId: userId);
    }
  };
}
