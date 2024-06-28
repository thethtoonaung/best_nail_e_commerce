import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../utils/dimesions.dart';

class ViewAllButton extends StatelessWidget {
  final String? title;
  final void Function()? ontap;
  const ViewAllButton({super.key, this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: ontap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title ?? "View more",
                style: context.labelMedium.copyWith(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(
              width: Dimesion.width5 / 2,
            ),
            Icon(
              Iconsax.arrow_right,
              size: Dimesion.iconSize16 * 0.8,
              color: Colors.black,
            )
          ],
        ));
  }
}
