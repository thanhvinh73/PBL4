import 'package:client/generated/translations.g.dart';
import 'package:client/screens/home_screen/home_screen.dart';
import 'package:client/screens/list_actions_screen/list_actions_screen.dart';
import 'package:client/screens/my_page_screen/my_page_screen.dart';
import 'package:client/screens/setting_controller_screen/setting_controller_screen.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MainTabs { home, settingController, action, account }

extension MainTabsExt on MainTabs {
  Widget get widget => {
        MainTabs.home: HomeScreen(),
        MainTabs.settingController: const SettingControllerScreen(),
        MainTabs.action: const ListActionsScreen(),
        MainTabs.account: const MyPageScreen(),
      }[this]!;

  IconData get icon => {
        MainTabs.home: Icons.home_filled,
        MainTabs.settingController: Icons.settings,
        MainTabs.action: Icons.change_circle_rounded,
        MainTabs.account: Icons.account_circle_outlined,
      }[this]!;

  String get label => {
        MainTabs.home: tr(LocaleKeys.App_Home),
        MainTabs.settingController: tr(LocaleKeys.App_SettingController),
        MainTabs.action: tr(LocaleKeys.App_ChangeAction),
        MainTabs.account: tr(LocaleKeys.App_Account),
      }[this]!;
  Widget? action(BuildContext context) {
    return {
      MainTabs.home: AppIconButton(
        onTap: () {
          showHintLiveCameraDialog(context);
        },
        padding: const EdgeInsets.symmetric(horizontal: 16),
        icon: CupertinoIcons.lightbulb_fill,
      ),
      MainTabs.settingController: null,
      MainTabs.action: null,
      MainTabs.account: null,
    }[this];
  }
}
