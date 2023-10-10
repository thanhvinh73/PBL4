import 'package:client/generated/translations.g.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/my_page_screen/components/my_page_row.dart';
import 'package:client/screens/my_page_screen/cubit/my_page_screen_cubit.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyPageScreenCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<MyPageScreenCubit, MyPageScreenState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage &&
                current.errorMessage != null,
            listener: (context, state) {
              showErrorDialog(context, content: state.errorMessage)
                  .then((value) {
                context
                    .read<MyPageScreenCubit>()
                    .updateState((p0) => p0.copyWith(errorMessage: null));
              });
            },
          ),
          BlocListener<MyPageScreenCubit, MyPageScreenState>(
            listenWhen: (previous, current) =>
                previous.isLogout != current.isLogout,
            listener: (context, state) {
              if (state.isLogout) {
                context.read<AppUserCubit>().updateUser(null);
                Get.toNamed(Routes.login);
              }
            },
          ),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) => AppDismissKeyboard(
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
                      onTap: context.read<MyPageScreenCubit>().logout,
                      svgUrl: "assets/icons/ic_logout.svg",
                      title: tr(LocaleKeys.App_Logout)),
                  const Divider(
                    thickness: 0.5,
                    color: AppColors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
