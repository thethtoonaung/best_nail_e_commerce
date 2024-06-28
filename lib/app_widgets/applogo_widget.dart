import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_config.dart';
import '../utils/dimesions.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimesion.height40 * 1.5,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: AppColor.primaryClr,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(4, 4))
        ],
      ),
      child: Image.asset(AppConfig.appLogo),
    );
  }
}
