import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../utils/dimesions.dart';

Widget backButton({Color? color}) => IconButton(
    onPressed: () => Get.back(),
    icon: Icon(
      CupertinoIcons.back,
      color: color ?? AppColor.primaryClr,
      size: Dimesion.iconSize16,
    ));
