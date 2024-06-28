import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/dimesions.dart';

class ColumnText extends StatelessWidget {
  final String title;
  final String val;
  const ColumnText({super.key, required this.title, required this.val});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(
          val,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}

class ProductColumnText extends StatelessWidget {
  final String title;
  final String val;

  const ProductColumnText({super.key, required this.title, required this.val});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColor.primaryClr),
        ),
        SizedBox(
          height: Dimesion.width5,
        ),
        Text(
          val,
          maxLines: 1,
          style: Theme.of(context).textTheme.labelSmall!,
        )
      ],
    );
  }
}
