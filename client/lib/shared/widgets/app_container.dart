import 'package:flutter/widgets.dart';

class AppContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final Widget child;
  final Border? border;
  final Alignment? alignment;
  final List<BoxShadow>? boxShadow;
  final BoxConstraints? constraints;

  const AppContainer({
    super.key,
    this.width,
    this.height,
    this.color,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.gradient,
    this.borderRadius,
    this.child = const SizedBox.shrink(),
    this.border,
    this.alignment,
    this.boxShadow,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: borderRadius,
          border: border,
          boxShadow: boxShadow),
      child: child,
    );
  }
}
