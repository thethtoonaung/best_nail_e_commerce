import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class RemarkWidget extends StatelessWidget {
  final String title;
  final String message;
  final bool isCancel;
  const RemarkWidget(
      {super.key,
      required this.title,
      required this.message,
      required this.isCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimesion.width5),
      child: Column(
        children: [
          Text(
            title,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          Text(
            message,
            style: context.labelMedium
                .copyWith(color: isCancel ? Colors.red : AppColor.primaryClr),
          )
        ],
      ),
    );
  }
}
