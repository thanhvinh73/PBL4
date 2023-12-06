import 'package:client/generated/translations.g.dart';
import 'package:client/screens/home_screen/home_screen.dart';
import 'package:client/screens/list_actions_screen/list_actions_screen.dart';
import 'package:client/screens/my_page_screen/my_page_screen.dart';
import 'package:client/screens/tutorial_screen/tutorial_screen.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/camera_controller_screen/camera_controller_screen.dart';

enum MainTabs { home, cameraController, action, account, tutorial }

extension MainTabsExt on MainTabs {
  Widget get widget => {
        MainTabs.home: const HomeScreen(),
        MainTabs.cameraController: const CameraControllerScreen(),
        MainTabs.action: const ListActionsScreen(),
        MainTabs.account: const MyPageScreen(),
        MainTabs.tutorial: const TutorialScreen()
      }[this]!;

  IconData get icon => {
        MainTabs.home: Icons.home_filled,
        MainTabs.cameraController: Icons.settings,
        MainTabs.action: Icons.change_circle_rounded,
        MainTabs.account: Icons.account_circle_outlined,
        MainTabs.tutorial: Icons.wb_incandescent_sharp
      }[this]!;

  String get label => {
        MainTabs.home: tr(LocaleKeys.App_Home),
        MainTabs.cameraController: tr(LocaleKeys.App_SettingController),
        MainTabs.action: tr(LocaleKeys.App_ChangeAction),
        MainTabs.account: tr(LocaleKeys.App_Account),
        MainTabs.tutorial: tr(LocaleKeys.App_Tutorial)
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
      MainTabs.cameraController: AppIconButton(
        onTap: () {
          showHintCameraControllerDialog(context);
        },
        padding: const EdgeInsets.symmetric(horizontal: 16),
        icon: CupertinoIcons.lightbulb_fill,
      ),
      MainTabs.action: AppIconButton(
        onTap: () {
          showHintLabelActionDialog(context);
        },
        padding: const EdgeInsets.symmetric(horizontal: 16),
        icon: CupertinoIcons.lightbulb_fill,
      ),
      MainTabs.account: null,
      MainTabs.tutorial: null
    }[this];
  }
}
