import 'package:client/shared/extensions/string_ext.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'app_text.dart';

class AppPopupMenuItem<T> extends StatelessWidget {
  final String? label;
  final Icon? icon;
  final Color color;
  final T value;
  const AppPopupMenuItem({
    super.key,
    required this.label,
    this.icon,
    required this.value,
    this.color = AppColors.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (icon != null) icon!,
        if (icon != null) const SizedBox(width: 10),
        if (label.isNotEmptyOrNull)
          AppText(
            label,
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
      ],
    );
  }
}
