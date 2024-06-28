import 'package:flutter/material.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../utils/dimesions.dart';

class BrandandCategoryCardWidget extends StatelessWidget {
  final String url;
  final String title;

  const BrandandCategoryCardWidget(
      {super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: Dimesion.screeWidth * 0.12,
          width: Dimesion.screeWidth * 0.12,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          child: MyCacheImg(
              url: url,
              boxfit: BoxFit.contain,
              borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
        ),
        SizedBox(
          height: Dimesion.width5,
        ),
        Text(
          title,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        )
      ],
    );
  }
}
