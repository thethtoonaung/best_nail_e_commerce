import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../models/products/banner_model.dart';
import '../../../utils/dimesions.dart';

class BannerWidget extends StatelessWidget {
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final List<BannerData> banners;
  final void Function() onTapBanner;
  const BannerWidget(
      {super.key,
      this.onPageChanged,
      required this.banners,
      required this.onTapBanner});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: banners.length,
        itemBuilder: (_, i, index) => InkWell(
              onTap: onTapBanner,
              child: MyCacheImg(
                url: banners[i].image ?? "",
                boxfit: BoxFit.cover,
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
                height: Dimesion.screenHeight * 0.18,
              ),
            ),
        options: CarouselOptions(
          height: Dimesion.screenHeight * 0.18,
          animateToClosest: true,
          viewportFraction: 0.98,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          onPageChanged: onPageChanged,
          scrollDirection: Axis.horizontal,
          scrollPhysics: const BouncingScrollPhysics(),
          aspectRatio: 16 / 9,
        ));
  }
}
