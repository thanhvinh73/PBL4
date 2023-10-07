import 'package:client/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? shadowColor;
  final Color? titleColor;
  final Color? borderColor;
  final TextStyle? style;
  final double? height;
  final double? width;
  final Gradient? gradient;
  final bool? hasGradient;
  final Color? color;
  final double borderRadius;
  const AppButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.shadowColor,
      this.titleColor,
      this.borderColor,
      this.style,
      this.height = 48,
      this.width,
      this.gradient,
      this.hasGradient = true,
      this.color = AppColors.primaryColor,
      this.borderRadius = 8});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width / 3 * 2 - 48,
        height: height,
        decoration: BoxDecoration(
            color: color,
            border:
                Border.all(width: 1, color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: onPressed == null ? Colors.grey : titleColor ?? Colors.white,
            fontWeight: FontWeight.w700,
          ),
        )),
      ),
    );
  }
}
