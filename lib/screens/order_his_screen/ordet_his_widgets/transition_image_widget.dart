import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../app_widgets/underline_text_button.dart';
import '../../../app_widgets/view_image_screen.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class OrderImageWidget extends StatelessWidget {
  final String imgUrl;
  final String title;
  const OrderImageWidget(
      {super.key, required this.imgUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimesion.width5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          Row(
            children: [
              MyCacheImg(
                url: imgUrl,
                boxfit: BoxFit.cover,
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                height: Dimesion.height40,
                width: Dimesion.height40,
              ),
              SizedBox(
                width: Dimesion.width5,
              ),
              UnderLineTextButton(
                  color: AppColor.primaryClr,
                  title: "View Image",
                  ontap: () => Get.to(() => ViewImageScreen(imgUrl: imgUrl)))
            ],
          ),
        ],
      ),
    );
  }
}
