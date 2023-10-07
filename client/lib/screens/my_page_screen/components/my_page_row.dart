import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPageRow extends StatelessWidget {
  const MyPageRow({
    super.key,
    this.onTap,
    required this.svgUrl,
    required this.title,
  });
  final void Function()? onTap;
  final String svgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  svgUrl,
                  color: AppColors.titleText,
                  width: 30,
                  height: 30,
                )),
            Expanded(
                flex: 5,
                child: AppText(
                  title,
                  color: AppColors.bodyText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ))
          ],
        ),
      ),
    );
  }
}
