import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/app_container.dart';
import '../widgets/app_text.dart';

enum BannerType { success, error, warning, info }

enum BannerPosition { top, bottom }

extension BannerExt on BannerType {
  Color get backgroundColor => {
        BannerType.success: AppColors.bgSuccess,
        BannerType.error: AppColors.bgError,
        BannerType.warning: AppColors.bgOrange,
        BannerType.info: AppColors.bgBlue,
      }[this]!;

  IconData get icon => {
        BannerType.success: Icons.check_circle,
        BannerType.error: Icons.cancel,
        BannerType.info: Icons.info_rounded,
        BannerType.warning: Icons.error_rounded,
      }[this]!;

  Color get iconColor => {
        BannerType.success: AppColors.accept,
        BannerType.error: AppColors.red,
        BannerType.info: Colors.blue[800],
        BannerType.warning: Colors.yellow[800],
      }[this]!;

  Color get textColor => {
        BannerType.success: AppColors.titleText,
        BannerType.error: AppColors.titleText,
        BannerType.warning: AppColors.titleText,
        BannerType.info: AppColors.white,
      }[this]!;
}

extension BannerPositionExt on BannerPosition {
  Alignment get align => {
        BannerPosition.bottom: Alignment.bottomCenter,
        BannerPosition.top: Alignment.topCenter,
      }[this]!;
}

showErrorBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return AppBanner(
        content: content,
        bannerType: BannerType.error,
      );
    },
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

showSuccessBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return AppBanner(
        content: content,
        bannerType: BannerType.success,
      );
    },
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

showWarningBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return AppBanner(
        content: content,
        bannerType: BannerType.warning,
      );
    },
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

showInfoBanner({
  required String content,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return AppBanner(
        content: content,
        bannerType: BannerType.info,
      );
    },
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

showBottomBanner({
  required String content,
  BannerType bannerType = BannerType.info,
  BannerPosition bannerPosition = BannerPosition.bottom,
  int delayDurationInMilliseconds = 0,
}) async {
  if (delayDurationInMilliseconds > 0) {
    await Future.delayed(Duration(milliseconds: delayDurationInMilliseconds));
  }
  BotToast.showCustomNotification(
    toastBuilder: (cancelFunc) {
      return AppBanner(
        content: content,
        bannerType: bannerType,
        bannerPosition: bannerPosition,
      );
    },
    backButtonBehavior: BackButtonBehavior.ignore,
    animationDuration: const Duration(milliseconds: 300),
    animationReverseDuration: const Duration(milliseconds: 300),
    duration: const Duration(milliseconds: 2000),
  );
}

class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    this.content,
    required this.bannerType,
    this.bannerPosition = BannerPosition.top,
  });
  final String? content;
  final BannerType bannerType;
  final BannerPosition bannerPosition;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: bannerPosition.align,
      child: AppContainer(
        color: bannerType.backgroundColor,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              bannerType.icon,
              size: 22,
              color: bannerType.iconColor,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                content,
                fontSize: 15,
                color: bannerType.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
