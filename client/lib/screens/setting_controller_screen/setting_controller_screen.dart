import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class SettingControllerScreen extends StatelessWidget {
  const SettingControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
        child: Center(
          child: AppText("Hello from setting controller page"),
        ),
        onWillPop: false);
  }
}
