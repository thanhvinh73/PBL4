import 'package:client/models/camera_url/camera_url.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/app_container.dart';

class UrlRowItem extends StatelessWidget {
  const UrlRowItem({
    super.key,
    this.onTap,
    required this.cameraUrl,
    this.onLongPress,
  });
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final CameraUrl cameraUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AppContainer(
        color: AppColors.transparent,
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Icon(
            Icons.camera_alt,
            size: 25,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  cameraUrl.ssid,
                  color: AppColors.hintTextColor,
                  padding: const EdgeInsets.only(bottom: 3),
                ),
                AppText(
                  cameraUrl.url,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
