import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  String? firstHalf;
  String? secHalf;

  bool hiddenText = true;

  double textHeight = Get.context!.height / 3.9;
  @override
  void initState() {
    super.initState();
    if (widget.text.length > 350) {
      firstHalf = widget.text.substring(0, 350);
      secHalf = widget.text.substring(350, widget.text.length);
    } else {
      firstHalf = widget.text;
      secHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secHalf!.isEmpty
            ? Text(
                firstHalf!,
                style: context.labelMedium,
              )
            : Column(
                children: [
                  Text(
                    hiddenText ? ("${firstHalf!}...") : (firstHalf! + secHalf!),
                    style: context.labelMedium,
                  ),
                  InkWell(
                    onTap: (() {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    }),
                    child: Row(
                      children: [
                        Text(
                          hiddenText ? "Show more" : "Show less",
                          style: context.labelMedium.copyWith(
                              color: AppColor.primaryClr,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: AppColor.primaryClr,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
