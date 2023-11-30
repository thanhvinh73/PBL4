import 'package:client/generated/translations.g.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../public_providers/app_user_cubit/app_user_cubit.dart';
import '../../routes/app_router.dart';
import '../../shared/helpers/dialog_helper.dart';
import '../../shared/utils/app_colors.dart';
import '../../shared/widgets/app_container.dart';
import '../../shared/widgets/app_text.dart';
import 'components/row_item.dart';
import 'cubit/drawer_cubit.dart';

class DrawerItems extends StatefulWidget {
  const DrawerItems({Key? key}) : super(key: key);

  @override
  State<DrawerItems> createState() => _DrawerItemsState();
}

class _DrawerItemsState extends State<DrawerItems> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColors.primaryColor,
        child: BlocProvider<DrawerCubit>(
            create: (_) => DrawerCubit(),
            child: MultiBlocListener(
              listeners: [
                BlocListener<DrawerCubit, DrawerState>(
                  listenWhen: (previous, current) =>
                      previous.errorMessage != current.errorMessage &&
                      current.errorMessage != null,
                  listener: (context, state) {
                    showErrorDialog(context,
                            title: tr(LocaleKeys.Auth_Error),
                            content: state.errorMessage)
                        .then((value) {
                      context
                          .read<DrawerCubit>()
                          .updateState((p0) => p0.copyWith(errorMessage: null));
                    });
                  },
                ),
                BlocListener<DrawerCubit, DrawerState>(
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  listener: (context, state) {
                    if (state.status == ScreenStatus.success) {
                      Get.toNamed(Routes.login);
                    }
                  },
                ),
              ],
              child: BlocBuilder<AppUserCubit, AppUserState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            AppContainer(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(tr(LocaleKeys.App_Menu),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white),
                                    GestureDetector(
                                      onTap: Navigator.of(context).pop,
                                      child: const Icon(
                                        Icons.close,
                                        size: 24,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              color: AppColors.white,
                              child: Wrap(
                                runSpacing: 8,
                                children: [
                                  RowItem(
                                    title: tr(LocaleKeys.App_Account),
                                    leading: const Icon(
                                      Icons.account_circle,
                                      size: 25,
                                    ),
                                    onTap: () {
                                      Get.toNamed(Routes.profileScreen);
                                    },
                                  ),
                                  const Divider(thickness: 1),
                                  RowItem(
                                    title: tr(LocaleKeys.App_Home),
                                    leading: const Icon(
                                      Icons.home_filled,
                                      size: 25,
                                    ),
                                    onTap: () {
                                      context
                                          .read<MainScreenCubit>()
                                          .changeTab(MainTabs.home);
                                      Get.back();
                                    },
                                  ),
                                  RowItem(
                                    title: tr(LocaleKeys.App_SettingController),
                                    leading: const Icon(
                                      Icons.settings,
                                      size: 25,
                                    ),
                                    onTap: () {
                                      context.read<MainScreenCubit>().changeTab(
                                          MainTabs.settingController);
                                      Get.back();
                                    },
                                  ),
                                  const Divider(thickness: 1),
                                  RowItem(
                                    title: tr(LocaleKeys.App_Setting),
                                    leading: const Icon(
                                      Icons.settings,
                                      size: 25,
                                    ),
                                    onTap: () {},
                                  ),
                                  RowItem(
                                    title: tr(LocaleKeys.App_Tutorial),
                                    leading: const Icon(
                                      Icons.wb_incandescent_sharp,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: AppColors.white,
                        padding: const EdgeInsets.all(60),
                        child: GestureDetector(
                          onTap: () => showConfirmDialog(
                            context,
                            title: tr(LocaleKeys.App_Logout),
                            content: tr(LocaleKeys.App_LogoutConfirm),
                            onReject: () {},
                            onAccept: () async {
                              context.read<DrawerCubit>().logout();
                            },
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.power_settings_new,
                                        color: AppColors.darkPurple,
                                      ),
                                      const SizedBox(width: 12),
                                      AppText(tr(LocaleKeys.App_Logout),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor),
                                    ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )));
  }
}
