import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_color.dart';
import '../utils/dimesions.dart';
import 'main_button.dart';

class EmptyViewWidget extends StatelessWidget {
  final void Function()? refresh;
  const EmptyViewWidget({super.key, this.refresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Dimesion.screenHeight * 0.4,
        child: Column(children: [
          LottieBuilder.asset("assets/lottie/empty.json",
              height: Dimesion.screenHeight * 0.2, fit: BoxFit.contain),
          refresh == null
              ? Text(
                  "No Data Found".tr,
                  style: context.titleSmall,
                )
              : mainButton(
                  title: Column(
                    children: [
                      Icon(
                        Icons.refresh,
                        color: AppColor.primaryClr,
                        size: Dimesion.iconSize16,
                      ),
                      Text("Refresh",
                          style: context.titleSmall.copyWith(
                            color: AppColor.primaryClr,
                          )),
                    ],
                  ),
                  onTap: refresh ?? () {},
                  borderRadius: 0,
                  elevation: 0,
                  width: Dimesion.screeWidth * 0.3)
        ]),
      ),
    );
  }
}
