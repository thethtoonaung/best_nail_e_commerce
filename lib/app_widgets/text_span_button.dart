import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';

Widget textSpanButton(
        {required String firstText,
        required String buttonText,
        required void Function() ontap,
        required BuildContext context}) =>
    Center(
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: " $firstText ", style: Theme.of(context).textTheme.bodySmall),
        TextSpan(
          text: " $buttonText ",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColor.primaryClr, fontWeight: FontWeight.bold),
          recognizer: TapGestureRecognizer()..onTap = ontap,
        )
      ])),
    );
