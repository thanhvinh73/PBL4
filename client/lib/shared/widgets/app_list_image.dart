import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';

class AppListImage extends StatelessWidget {
  const AppListImage(
      {super.key,
      required this.imgsUrl,
      this.amountOfImageShow = 3,
      this.spaceXY = 4,
      this.borderRadius = 8,
      this.onTap});
  final List<String> imgsUrl;
  final int amountOfImageShow;
  final double borderRadius;
  final double spaceXY;
  final void Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth / 3.1;
        return Wrap(
          alignment: WrapAlignment.end,
          runSpacing: spaceXY,
          spacing: spaceXY,
          children: [
            for (int i = 0; i < imgsUrl.length; i++)
              if (i + 1 < amountOfImageShow)
                GestureDetector(
                  onTap: () {
                    if (onTap != null) {
                      onTap!.call(i);
                    } else {
                      // Get.toNamed(Routes.photoGallery, arguments: [imgsUrl, i]);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: CachedNetworkImage(
                      alignment: Alignment.center,
                      imageUrl: imgsUrl[i],
                      width: size,
                      height: size,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            if (imgsUrl.length > amountOfImageShow - 1)
              GestureDetector(
                onTap: () {
                  if (onTap != null) {
                    onTap!.call(amountOfImageShow - 2);
                  } else {
                    // Get.toNamed(Routes.photoGallery,
                    //     arguments: [imgsUrl, amountOfImageShow - 2]);
                  }
                },
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(borderRadius)),
                  child: Center(
                    child: AppText(
                      "+${imgsUrl.length - (amountOfImageShow - 1)}",
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
