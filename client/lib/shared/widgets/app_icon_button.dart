import 'package:client/shared/utils/app_colors.dart';
import 'package:client/shared/widgets/app_container.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.onTap,
    this.padding = EdgeInsets.zero,
    required this.icon,
    this.color,
    this.size,
  });
  final VoidCallback onTap;
  final EdgeInsets padding;
  final IconData icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: AppContainer(
          padding: padding,
          color: AppColors.transparent,
          child: Icon(
            icon,
            size: size,
            color: color,
          ),
        ));
  }
}
