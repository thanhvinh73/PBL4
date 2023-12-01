import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/helpers/bot_toast_helper.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class AppMjpeg extends StatefulWidget {
  const AppMjpeg({
    super.key,
    required this.url,
    this.height,
    this.width,
  });
  final String url;
  final double? height;
  final double? width;

  @override
  State<AppMjpeg> createState() => _AppMjpegState();
}

class _AppMjpegState extends State<AppMjpeg> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
          if (error.toString().isEmptyOrNull) return const SizedBox.shrink();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppContainer(
                color: AppColors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: Center(
                    child: AppText(
                      "Không thể kết nối đến địa chỉ camera",
                      fontStyle: FontStyle.italic,
                      color: AppColors.red,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
