import 'package:flutter/material.dart';
import '../utils/dimesions.dart';

Widget mainButton(
        {required Widget title,
        required void Function() onTap,
        required double borderRadius,
        required double width,
        double? height,
        double? elevation,
        EdgeInsetsGeometry? padding,
        Color? color}) =>
    MaterialButton(
        padding: padding ?? EdgeInsets.zero,
        elevation: elevation ?? 5,
        minWidth: width,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)),
        color: color ?? Colors.white,
        onPressed: onTap,
        height: height ?? Dimesion.height40,
        child: title);
