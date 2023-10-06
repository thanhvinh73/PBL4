import 'package:flutter/material.dart';

class BottomTabBarItem extends BottomNavigationBarItem {
  BottomTabBarItem({
    required super.icon,
    super.label,
    super.activeIcon,
  });

  @override
  Widget get icon => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: super.icon,
      );

  @override
  Widget get activeIcon => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: super.activeIcon,
      );
}
