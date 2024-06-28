import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'apploading_widget.dart';

class MyCacheImg extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit boxfit;
  final BorderRadius borderRadius;
  const MyCacheImg(
      {super.key,
      required this.url,
      this.width,
      this.height,
      required this.boxfit,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      progressIndicatorBuilder: (context, url, progress) => Container(
          alignment: Alignment.center,
          height: height,
          width: width,
          child: const ApploadingWidget()),
      errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: const ApploadingWidget()),
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(image: imageProvider, fit: boxfit)),
      ),
    );
  }
}
