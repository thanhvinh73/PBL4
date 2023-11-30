import 'package:client/shared/extensions/string_ext.dart';
import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProfileRowItem extends StatelessWidget {
  const ProfileRowItem(
      {super.key, required this.content, this.icon, this.title});
  final String? content;
  final IconData? icon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title.isNotEmptyOrNull)
          Expanded(
            flex: 2,
            child: AppText(
              title,
              fontSize: 18,
              color: AppColors.titleText,
            ),
          )
        else
          Icon(
            icon,
            size: 30,
            color: AppColors.titleText,
          ),
        const SizedBox(width: 16),
        Expanded(
            flex: 3,
            child: AppText(
              content,
              fontSize: 18,
              color: AppColors.bodyText,
            ))
      ],
    );
  }
}
