import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'app_popup_menu_item.dart';

// ignore: must_be_immutable
class AppPopupMenu<T> extends StatelessWidget {
  AppPopupMenu({
    super.key,
    required this.items,
    this.child,
    this.backgroundColor = AppColors.white,
    this.padding = EdgeInsets.zero,
    this.initialValue,
    this.onSeleted,
    this.onOpened,
    this.onCanceled,
    this.showDivider = true,
    this.dividerColor = AppColors.gray,
  });
  List<AppPopupMenuItem<T>> items;
  final Widget? child;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final T? initialValue;
  final void Function(T value)? onSeleted;
  final void Function()? onOpened;
  final void Function()? onCanceled;
  final bool showDivider;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: PopupMenuButton<T>(
        position: PopupMenuPosition.under,
        itemBuilder: (context) {
          return items.asMap().entries.toList().fold(
              [],
              (previousValue, entry) => [
                    ...previousValue,
                    if (showDivider && entry.key > 0)
                      PopupMenuItem<T>(
                          padding: EdgeInsets.zero,
                          enabled: false,
                          height: 1,
                          child: const Divider(height: 1, thickness: 0.5)),
                    PopupMenuItem<T>(
                        value: entry.value.value, child: entry.value)
                  ]);
        },
        color: backgroundColor,
        splashRadius: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onOpened: onOpened,
        onCanceled: onCanceled,
        onSelected: onSeleted,
        initialValue: initialValue,
        child:
            child ?? const Icon(Icons.more_vert, color: AppColors.primaryColor),
      ),
    );
  }
}
