import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:client/shared/enum/main_tabs.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_icon_button.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:client/shared/widgets/app_popup_menu.dart';
import 'package:client/shared/widgets/app_popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../shared/utils/app_colors.dart';
import '../../shared/widgets/app_mjpeg.dart';
import '../main_screen/cubit/main_screen_cubit.dart';

enum MjpegFullScreenOption { detech, cameraController }

extension MjpegFullScreenOptionExt on MjpegFullScreenOption {
  String get label => {
        MjpegFullScreenOption.detech: "Nhận diện hành động",
        MjpegFullScreenOption.cameraController: "Điều chỉnh camera",
      }[this]!;

  Icon get icon => {
        MjpegFullScreenOption.detech: const Icon(Icons.star_rate_rounded),
        MjpegFullScreenOption.cameraController:
            const Icon(Icons.settings_rounded),
      }[this]!;
}

class MjpegFullScreen extends StatefulWidget {
  const MjpegFullScreen({
    super.key,
    required this.url,
  });
  final String url;

  @override
  State<MjpegFullScreen> createState() => _MjpegFullScreenState();
}

class _MjpegFullScreenState extends State<MjpegFullScreen>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    showRotatePhoneDialog(context);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      showAppBar: false,
      useSafeArea: true,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            AppMjpeg(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                showFullScreen: false,
                url: widget.url),
            Positioned(
                bottom: 4,
                right: 4,
                child: AppIconButton(
                  icon: Icons.fullscreen_exit_outlined,
                  onTap: Navigator.of(context).pop,
                  color: AppColors.bgPurple,
                  size: 28,
                )),
            Positioned(
                top: 4,
                right: 4,
                child: AppPopupMenu<MjpegFullScreenOption>(
                  items: MjpegFullScreenOption.values
                      .map((e) => AppPopupMenuItem(
                            label: e.label,
                            value: e,
                            icon: e.icon,
                          ))
                      .toList(),
                  onSeleted: (value) {
                    switch (value) {
                      case MjpegFullScreenOption.detech:
                        Get.back();
                        context
                            .read<MainScreenCubit>()
                            .changeTab(MainTabs.action);
                        break;
                      case MjpegFullScreenOption.cameraController:
                        context
                            .read<MainScreenCubit>()
                            .changeTab(MainTabs.cameraController);
                        Get.back();
                        break;
                      default:
                    }
                  },
                  child: const Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.bgPurple,
                    size: 28,
                  ),
                ))
          ],
        );
      }),
    );
  }
}
