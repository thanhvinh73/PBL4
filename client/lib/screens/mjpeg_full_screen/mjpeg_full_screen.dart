import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:client/shared/helpers/dialog_helper.dart';
import 'package:client/shared/widgets/app_icon_button.dart';
import 'package:client/shared/widgets/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/utils/app_colors.dart';
import '../../shared/widgets/app_mjpeg.dart';

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
    // showRotatePhoneDialog(context);
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
                ))
          ],
        );
      }),
    );
  }
}
