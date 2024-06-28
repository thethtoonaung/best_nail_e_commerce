import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_cache_img.dart';

class NetWorkBackGround extends StatelessWidget {
  final String url;
  const NetWorkBackGround({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyCacheImg(
            url: url,
            boxfit: BoxFit.cover,
            height: Get.context!.height,
            width: Get.context!.width,
            borderRadius: BorderRadius.circular(0)),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const SizedBox(),
        ))
      ],
    );
  }
}
