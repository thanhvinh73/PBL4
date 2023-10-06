import 'package:client/generated/translations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum BottomTabs { Home, SettingController, Account }

extension BottomTabsExt on BottomTabs {
  IconData get icon => {
        BottomTabs.Home: Icons.home_filled,
        BottomTabs.SettingController: Icons.settings,
        BottomTabs.Account: Icons.account_circle_outlined,
      }[this]!;

  String get label => {
        BottomTabs.Home: tr(LocaleKeys.App_Home),
        BottomTabs.SettingController: tr(LocaleKeys.App_SettingController),
        BottomTabs.Account: tr(LocaleKeys.App_Account),
      }[this]!;
  Widget? action(BuildContext context) {
    return {
      BottomTabs.Home: null,
      BottomTabs.SettingController: null,
      BottomTabs.Account: null,
    }[this];
  }
}
