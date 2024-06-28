import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../app_widgets/main_button.dart';
import '../../../../routes_helper/routes_helper.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/dimesions.dart';

class NoLoginWidget extends StatelessWidget {
  const NoLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lottie/sleep_panda.json",
            height: Dimesion.screenHeight * 0.3,
          ),
          Text("Looks like you are not logged in yet.",
              style: context.titleSmall),
          SizedBox(
            height: Dimesion.height10,
          ),
          mainButton(
            color: AppColor.primaryClr,
            title: Text(
              "Go to login",
              style: context.titleSmall.copyWith(color: Colors.white),
            ),
            onTap: () => Get.toNamed(RouteHelper.login),
            borderRadius: Dimesion.radius15 / 2,
            width: Dimesion.screeWidth * 0.5,
          )
        ],
      ),
    );
  }
}
