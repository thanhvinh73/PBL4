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
  const AppButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.shadowColor,
      this.titleColor,
      this.borderColor,
      this.style,
      this.height,
      this.width,
      this.gradient,
      this.hasGradient = true,
      this.color = Colors.deepPurpleAccent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width / 3 * 2 - 48,
        height: 48,
        decoration: BoxDecoration(
            color: color,
            border:
                Border.all(width: 1, color: borderColor ?? Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
            color: onPressed == null ? Colors.grey : titleColor ?? Colors.white,
            fontWeight: FontWeight.w700,
          ),
        )),
      ),
    );
  }
}
