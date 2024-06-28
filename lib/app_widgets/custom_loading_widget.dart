import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/dimesions.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimesion.height10),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
      child: const CupertinoActivityIndicator(
        color: AppColor.primaryClr,
        animating: true,
      ),
    );
  }
}
