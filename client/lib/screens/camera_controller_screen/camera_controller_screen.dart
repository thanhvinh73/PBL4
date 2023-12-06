import 'package:client/generated/assets.gen.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/helpers/banner.helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_mjpeg.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/arrow_navigation_widget.dart';
import 'cubit/camera_controller_screen_cubit.dart';

class CameraControllerScreen extends StatelessWidget {
  const CameraControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentCameraUrl =
        context.read<AppUserCubit>().state.currentCameraUrl;

    return BlocProvider(
      create: (context) => CameraControllerScreenCubit(currentCameraUrl),
      child: MultiBlocListener(
        listeners: [
          BlocListener<CameraControllerScreenCubit,
                  CameraControllerScreenState>(
              listenWhen: (previous, current) =>
                  previous.pan != current.pan || previous.tilt != current.tilt,
              listener: (context, state) {
                context.read<CameraControllerScreenCubit>().rotatePan();
                context.read<CameraControllerScreenCubit>().rotateTilt();
              }),
          BlocListener<CameraControllerScreenCubit,
                  CameraControllerScreenState>(
              listenWhen: (previous, current) =>
                  previous.errorMessage != current.errorMessage &&
                  current.errorMessage != null,
              listener: (context, state) {
                showErrorBanner(content: state.errorMessage ?? "");
                context
                    .read<CameraControllerScreenCubit>()
                    .updateState((p0) => p0.copyWith(errorMessage: null));
              }),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: AppContainer(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(runSpacing: 16, children: [
                    if (currentCameraUrl == null)
                      Wrap(
                        runSpacing: 4,
                        children: [
                          AppText(
                            "Hiện tại bạn chưa chọn đường dẫn camera nào nên không thể sử dụng tính năng này!",
                            fontSize: 18,
                            textAlign: TextAlign.center,
                            color: AppColors.titleText,
                          ),
                          Assets.icons.pcHintCameraSelectUrl.svg(),
                        ],
                      )
                    else ...[
                      AppMjpeg(
                        url: currentCameraUrl.url!,
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ArrowNavigationWidget(
                          onChangedPan: (pan) {
                            context
                                .read<CameraControllerScreenCubit>()
                                .updateState((p0) => p0.copyWith(pan: pan));
                          },
                          onChangedTilt: (tilt) {
                            context
                                .read<CameraControllerScreenCubit>()
                                .updateState((p0) => p0.copyWith(tilt: tilt));
                          },
                        ),
                      )
                    ]
                  ]),
                  if (currentCameraUrl != null)
                    BlocBuilder<CameraControllerScreenCubit,
                        CameraControllerScreenState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              "Trục ngang: ${state.pan}",
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              fontSize: 15,
                            ),
                            AppText(
                              "Trục dọc: ${state.tilt}",
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              fontSize: 15,
                            )
                          ],
                        );
                      },
                    )
                  else
                    AppButton(
                        title: "Vui lòng chọn đường dẫn tại đây",
                        onPressed: () {
                          context
                              .read<MainScreenCubit>()
                              .changeTab(MainTabs.home);
                        }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
