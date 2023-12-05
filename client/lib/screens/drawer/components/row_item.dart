import 'package:flutter/material.dart';

import '../../../shared/utils/app_colors.dart';
import '../../../shared/widgets/app_container.dart';
import '../../../shared/widgets/app_text.dart';

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    this.leading,
    this.trailing,
    this.onTap,
    required this.title,
  });
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: AppContainer(
        color: AppColors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ?? const SizedBox.shrink(),
            AppText(
              title,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              fontWeight: FontWeight.w600,
              fontSize: 17,
              color: AppColors.titleText,
            ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
