import 'package:client/generated/assets.gen.dart';
import 'package:client/public_providers/app_user_cubit/app_user_cubit.dart';
import 'package:client/public_providers/web_socket_cubit/web_socket_cubit.dart';
import 'package:client/screens/main_screen/cubit/main_screen_cubit.dart';
import 'package:client/screens/setting_controller_screen/components/arrow_navigation_widget.dart';
import 'package:client/screens/setting_controller_screen/cubit/setting_controller_screen_cubit.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_mjpeg.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingControllerScreen extends StatefulWidget {
  const SettingControllerScreen({super.key});

  @override
  State<SettingControllerScreen> createState() =>
      _SettingControllerScreenState();
}

class _SettingControllerScreenState extends State<SettingControllerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingControllerScreenCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SettingControllerScreenCubit,
                  SettingControllerScreenState>(
              listenWhen: (previous, current) =>
                  previous.pan != current.pan || previous.tilt != current.tilt,
              listener: (context, state) {
                context.read<WebSocketCubit>().sendData("Tilt,${state.tilt}");
                context.read<WebSocketCubit>().sendData("Pan,${state.pan}");
              }),
        ],
        child: BlocBuilder<AppUserCubit, AppUserState>(
          buildWhen: (previous, current) =>
              previous.currentCameraUrl != current.currentCameraUrl,
          builder: (context, state) {
            final currentCameraUrl = state.currentCameraUrl;
            return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                child: AppContainer(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(runSpacing: 16, children: [
                        if (currentCameraUrl != null)
                          Wrap(
                            runSpacing: 4,
                            children: [
                              AppText(
                                "Hiện tại bạn chưa chọn đường dẫn camera nào nên không thể sử dụng tính năng này!",
                                fontSize: 18,
                                textAlign: TextAlign.center,
                                color: AppColors.titleText,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    context
                                        .read<MainScreenCubit>()
                                        .changeTab(MainTabs.home);
                                  },
                                  child: Align(
                                    child: AppText(
                                      "Vui lòng chọn đường dẫn tại đây",
                                      color: AppColors.darkPurple,
                                      textAlign: TextAlign.center,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                              Assets.icons.pcHintCameraSelectUrl.svg()
                            ],
                          )
                        else ...[
                          AppMjpeg(
                            url: currentCameraUrl?.url ?? "",
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                          ),
                          const Divider(),
                          ArrowNavigationWidget(
                            onChangedPan: (pan) {
                              context
                                  .read<SettingControllerScreenCubit>()
                                  .updateState((p0) => p0.copyWith(pan: pan));
                            },
                            onChangedTilt: (tilt) {
                              context
                                  .read<SettingControllerScreenCubit>()
                                  .updateState((p0) => p0.copyWith(tilt: tilt));
                            },
                          )
                        ]
                      ]),
                      BlocBuilder<SettingControllerScreenCubit,
                          SettingControllerScreenState>(
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
                                "Trục đứng: ${state.tilt}",
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                fontSize: 15,
                              )
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
