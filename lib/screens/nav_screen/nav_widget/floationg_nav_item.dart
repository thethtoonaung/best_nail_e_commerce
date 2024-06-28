import 'package:flutter/material.dart';

class MyFloatingNavbarItem {
  final String? title;
  final IconData? icon;
  final Widget? customWidget;

  MyFloatingNavbarItem({
    this.icon,
    this.title,
    this.customWidget,
  }) : assert(icon != null || customWidget != null);
}
