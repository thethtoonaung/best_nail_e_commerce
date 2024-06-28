import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';

class RowTextWidget extends StatelessWidget {
  final String title;
  final String val;
  const RowTextWidget({super.key, required this.title, required this.val});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.tr,
          style: context.titleSmall,
        ),
        Text(
          val,
          style: context.bodySmall.copyWith(color: AppColor.primaryClr),
          textAlign: TextAlign.end,
        )
      ],
    );
  }
}
