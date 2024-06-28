import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class TabbarWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSlected;
  final int index;
  const TabbarWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.isSlected,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimesion.width5, top: Dimesion.width5),
      child: Chip(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimesion.radius15)),
        side: BorderSide(
            color: isSlected ? AppColor.primaryClr : Colors.grey[400]!),
        padding: EdgeInsets.all(Dimesion.width5),
        // selected: isSlected,
        // selectedColor: Colors.white,

        surfaceTintColor: Colors.transparent,
        elevation: 3,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 0
                ? Image.asset(
                    icon,
                    height: Dimesion.height15,
                    color: isSlected ? AppColor.primaryClr : Colors.grey[400],
                    width: Dimesion.height20,
                  )
                : MyCacheImg(
                    url: icon,
                    boxfit: BoxFit.contain,
                    borderRadius: BorderRadius.zero,
                    height: Dimesion.height15,
                    width: Dimesion.height20,
                  ),
            SizedBox(
              width: Dimesion.width5,
            ),
            Text(
              title.tr,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSlected ? AppColor.primaryClr : Colors.grey[400]),
            )
          ],
        ),
      ),
    );
  }
}
