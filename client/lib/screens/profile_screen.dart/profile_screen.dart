import 'package:client/generated/translations.g.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/profile_screen.dart/components/profile_row_item.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_image.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        final user = state.user;
        return AppLayout(
          onWillPop: () => Future.value(true),
          useSafeArea: true,
          title: "",
          child: user == null
              ? const SizedBox.shrink()
              : LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: AppContainer(
                      padding: const EdgeInsets.all(16),
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Wrap(
                        runSpacing: 16,
                        children: [
                          AppText(
                            tr(LocaleKeys.App_Profile),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppImage(
                                width: 75,
                                height: 75,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              AppContainer(
                                color: AppColors.primaryColor,
                                padding: const EdgeInsets.all(0),
                                borderRadius: BorderRadius.circular(6),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.toNamed(Routes.updateProfileScreen,
                                          arguments: user.id!);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: AppColors.white,
                                    )),
                              )
                            ],
                          ),
                          if (user.name.isEmptyOrNull)
                            AppContainer(
                              color: AppColors.bgPurple,
                              padding: const EdgeInsets.all(16),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.lightPurple),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.info_rounded,
                                    color: AppColors.lightPurple,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: AppText(
                                    tr(LocaleKeys.Profile_NotUpdate),
                                    fontSize: 16,
                                  ))
                                ],
                              ),
                            ),
                          ProfileRowItem(
                            content: user.name.isNotEmptyOrNull
                                ? user.name
                                : tr(LocaleKeys.App_NotUpdate),
                            icon: Icons.person,
                          ),
                          ProfileRowItem(
                            content: user.email.isNotEmptyOrNull
                                ? user.email
                                : tr(LocaleKeys.App_NotUpdate),
                            icon: Icons.email_rounded,
                          ),
                          const Divider(),
                          ProfileRowItem(
                            content: user.username.isNotEmptyOrNull
                                ? user.username
                                : tr(LocaleKeys.App_NotUpdate),
                            title: tr(LocaleKeys.Auth_Username),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
