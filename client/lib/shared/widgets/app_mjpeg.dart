import 'package:client/routes/app_router.dart';
import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_icon_button.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:get/get.dart';

class AppMjpeg extends StatefulWidget {
  const AppMjpeg({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.showFullScreen,
  });
  final String url;
  final double? height;
  final double? width;
  final bool? showFullScreen;

  @override
  State<AppMjpeg> createState() => _AppMjpegState();
}

class _AppMjpegState extends State<AppMjpeg> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Mjpeg(
            stream: "http://${widget.url}",
            isLive: true,
            fit: BoxFit.cover,
            height: widget.height,
            width: widget.width,
            loading: (context) => const AppLoadingWidget(),
            timeout: const Duration(seconds: 5),
            error: (context, error, stack) {
              debugPrint("MJPEG-ERROR: ${error.toString()}");
              if (error.toString().isEmptyOrNull) {
                return const SizedBox.shrink();
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppContainer(
                    color: AppColors.darkPurple,
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      height: widget.height,
                      width: widget.width,
                      child: Center(
                        child: AppText(
                          "Không thể kết nối đến địa chỉ camera",
                          fontStyle: FontStyle.italic,
                          color: AppColors.bgPurple,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (widget.showFullScreen ?? widget.url.isNotEmptyOrNull)
          Positioned(
            right: 4,
            bottom: 4,
            child: AppIconButton(
              onTap: () {
                Get.toNamed(Routes.mjpegFullScreen,
                    arguments: "http://${widget.url}");
              },
              icon: Icons.fullscreen,
              color: AppColors.bgPurple,
              size: 28,
            ),
          )
      ],
    );
  }
}
