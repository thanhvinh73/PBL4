import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/screens/camera_controller_screen/components/arrow_navigation_widget.dart';
import 'package:client/screens/detection_screen/cubit/detection_screen_cubit.dart';
import 'package:client/shared/helpers/banner.helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_button.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_dismiss_keyboard.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppUserState appUserState = context.read<AppUserCubit>().state;
    return BlocProvider(
      create: (context) => DetectionScreenCubit(
          url: appUserState.currentCameraUrl?.url ?? "",
          userId: appUserState.user!.id!)
        ..detect(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<DetectionScreenCubit, DetectionScreenState>(
            listenWhen: (previous, current) =>
                previous.errorMessage != current.errorMessage &&
                current.errorMessage != null,
            listener: (context, state) {
              showErrorBanner(content: state.errorMessage ?? "");
              context
                  .read<DetectionScreenCubit>()
                  .updateState((p0) => p0.copyWith(errorMessage: null));
            },
          ),
          BlocListener<DetectionScreenCubit, DetectionScreenState>(
              listenWhen: (previous, current) =>
                  previous.pan != current.pan || previous.tilt != current.tilt,
              listener: (context, state) {
                context.read<DetectionScreenCubit>().rotatePan();
                context.read<DetectionScreenCubit>().rotateTilt();
              }),
        ],
        child: AppDismissKeyboard(
          onWillPop: false,
          child: AppLayout(
              useSafeArea: true,
              onWillPop: () => Future.value(true),
              backgroundColor: AppColors.bgPurple,
              showAppBar: false,
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: AppContainer(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 22),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              runSpacing: 16,
                              alignment: WrapAlignment.center,
                              children: [
                                AppText(
                                  "Chế độ nhận diện",
                                  fontSize: 29,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                                AppText(
                                  "Ở chế độ này, bạn không thể thực hiện các tính năng khác",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.bodyText,
                                  textAlign: TextAlign.center,
                                ),
                                AppButton(
                                    title: "Thoát khỏi chế độ nhận diện",
                                    onPressed: () {
                                      context
                                          .read<DetectionScreenCubit>()
                                          .cancelDetection()
                                          .then((value) {
                                        Get.back();
                                      });
                                    }),
                                const Divider(color: AppColors.darkPurple)
                              ],
                            ),
                            Wrap(
                              runSpacing: 50,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child:
                                      ArrowNavigationWidget(onChangedPan: (_) {
                                    context
                                        .read<DetectionScreenCubit>()
                                        .updateState(
                                            (p0) => p0.copyWith(pan: _));
                                  }, onChangedTilt: (_) {
                                    context
                                        .read<DetectionScreenCubit>()
                                        .updateState(
                                            (p0) => p0.copyWith(tilt: _));
                                  }),
                                ),
                                BlocBuilder<DetectionScreenCubit,
                                    DetectionScreenState>(
                                  builder: (context, state) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          "Trục ngang: ${state.pan}",
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          fontSize: 15,
                                        ),
                                        AppText(
                                          "Trục dọc: ${state.tilt}",
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          fontSize: 15,
                                        )
                                      ],
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        BlocBuilder<DetectionScreenCubit, DetectionScreenState>(
                          buildWhen: (previous, current) =>
                              previous.waiting != current.waiting ||
                              previous.second != current.second,
                          builder: (context, state) {
                            return !state.waiting
                                ? const SizedBox.shrink()
                                : Positioned.fill(
                                    child: AppContainer(
                                    color: AppColors.black.withOpacity(0.5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AppText(
                                          "Vui lòng chờ để hệ thống nhận diện được khởi động",
                                          fontSize: 18,
                                          color: AppColors.white,
                                          textAlign: TextAlign.center,
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                        ),
                                        AppText(
                                          "${state.second} giây",
                                          fontSize: 18,
                                          color: AppColors.white,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ));
                          },
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
      ),
    );
  }
}
