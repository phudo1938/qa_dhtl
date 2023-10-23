import 'package:flutter/cupertino.dart';

class SidebarXItem {
  const SidebarXItem({
    this.label,
    this.icon,
    this.iconWidget,
    this.onTap,
  }) : assert(
          (icon != null || iconWidget != null) &&
              (icon == null || iconWidget == null),
        );

  final String? label;
  final IconData? icon;
  final Widget? iconWidget;
  final Function()? onTap;
}
