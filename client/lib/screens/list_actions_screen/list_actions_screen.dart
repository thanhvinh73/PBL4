import 'package:client/models/camera_url/camera_url.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/routes/app_router.dart';
import 'package:client/screens/list_actions_screen/components/list_action_item.dart';
import 'package:client/screens/list_actions_screen/cubit/list_actions_screen_cubit.dart';
import 'package:client/shared/enum/screen_status.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/helpers/banner.helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../generated/translations.g.dart';
import '../../shared/enum/main_tabs.dart';
import '../../shared/helpers/dialog_helper.dart';
import '../main_screen/cubit/main_screen_cubit.dart';

class ListActionsScreen extends StatelessWidget {
  const ListActionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ListActionsScreenCubit(context.read<AppUserCubit>().state.user!.id!)
            ..getLabels(),
      child: MultiBlocListener(
          listeners: [
            BlocListener<ListActionsScreenCubit, ListActionsScreenState>(
                listenWhen: (previous, current) =>
                    previous.errorMessage != current.errorMessage &&
                    current.errorMessage != null,
                listener: (context, state) {
                  showErrorDialog(context,
                          title: tr(LocaleKeys.Auth_Error),
                          content: state.errorMessage)
                      .then((value) =>
                          context.read<ListActionsScreenCubit>().updateState(
                                (p0) => p0.copyWith(errorMessage: null),
                              ));
                }),
            BlocListener<ListActionsScreenCubit, ListActionsScreenState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == ScreenStatus.success) {
                    showSuccessBanner(
                        content: "Thay đổi thứ tự nhãn hành động thành công!");
                    context.read<ListActionsScreenCubit>().updateState(
                        (p0) => p0.copyWith(status: ScreenStatus.loading));
                    context.read<ListActionsScreenCubit>().getLabels();
                  }
                }),
          ],
          child: LayoutBuilder(builder: (context, constraints) {
            return RefreshIndicator(
              color: AppColors.darkPurple,
              onRefresh: () =>
                  context.read<ListActionsScreenCubit>().getLabels(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: AppContainer(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<ListActionsScreenCubit,
                          ListActionsScreenState>(
                        builder: (context, state) {
                          return Wrap(
                            runSpacing: 16,
                            children: [
                              AppText(
                                "LỆNH ĐIỀU KHIỂN SLIDE",
                                color: AppColors.darkPurple,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              ...(state.labelOrders ?? [])
                                  .map((item) =>
                                      ListActionItem(labelOrder: item))
                                  .toList()
                            ],
                          );
                        },
                      ),
                      AppButton(
                          title: "Nhận diện",
                          onPressed: () {
                            if ((context
                                        .read<AppUserCubit>()
                                        .state
                                        .currentCameraUrl ??
                                    const CameraUrl())
                                .url
                                .isEmptyOrNull) {
                              showInfoDialog(context,
                                      title: "Chưa có đường dẫn camera",
                                      content:
                                          "Bạn chưa sử dụng đường dẫn camera nào, vui lòng chọn đường dẫn ở trang hiển thị video.")
                                  .then((value) {
                                context
                                    .read<MainScreenCubit>()
                                    .changeTab(MainTabs.home);
                              });
                              return;
                            }
                            showConfirmDialog(context,
                                title: "Nhận diện hành động",
                                content:
                                    "Khi vào chế độ nhận điện bạn sẽ không thể thực hiện các tính năng khác",
                                onAccept: () {
                              Get.toNamed(Routes.detectionScreen);
                            });
                          })
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
