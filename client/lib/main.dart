import 'package:bot_toast/bot_toast.dart';
import 'package:client/routes/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      startLocale: const Locale('vi'),
      fallbackLocale: const Locale('vi'),
      path: "assets/translations",
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final botToastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        initialRoute: Routes.splash,
        routes: Routes.routes,
        builder: (context, child) => botToastBuilder(context, child),
        navigatorObservers: [BotToastNavigatorObserver()],
      );
    });
  }
}
