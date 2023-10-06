import 'package:client/generated/translations.g.dart';
import 'package:client/screens/my_page_screen/components/my_page_row.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDismissKeyboard(
      onWillPop: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          children: [
            MyPageRow(
                svgUrl: "assets/icons/ic_profile.svg",
                title: tr(LocaleKeys.App_Profile)),
            MyPageRow(
                svgUrl: "assets/icons/ic_setting.svg",
                title: tr(LocaleKeys.App_Setting)),
            MyPageRow(
                svgUrl: "assets/icons/ic_logout.svg",
                title: tr(LocaleKeys.App_Logout)),
            const Divider(
              thickness: 0.5,
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
