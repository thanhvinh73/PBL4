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
  final EdgeInsets padding;
  final Widget? child;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.shadowColor,
    this.titleColor,
    this.padding = const EdgeInsets.all(16),
    this.borderColor,
    this.style,
    this.height,
    this.width,
    this.gradient,
    this.hasGradient = true,
    this.color,
    this.borderRadius = 6,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            color: color,
            gradient: (color != null)
                ? null
                : (gradient != null)
                    ? gradient
                    : const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                            AppColors.darkPurple,
                            AppColors.primaryColor,
                            AppColors.lightPurple
                          ]),
            border:
                Border.all(width: 1, color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: child ??
            Center(
                child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: onPressed == null
                    ? Colors.grey
                    : titleColor ?? Colors.white,
                fontWeight: FontWeight.w700,
              ),
            )),
      ),
    );
  }
}
