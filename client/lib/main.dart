import 'package:bot_toast/bot_toast.dart';
import 'package:client/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final botToastBuilder = BotToastInit();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        initialRoute: Routes.splash,
        routes: Routes.routes,
        builder: (context, child) => botToastBuilder(context, child),
        navigatorObservers: [BotToastNavigatorObserver()],
      );
    });
  }
}
