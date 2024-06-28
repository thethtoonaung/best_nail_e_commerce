import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class ImageSlider extends StatelessWidget {
  final List<String> images;
  final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
  final int activeIndex;
  final CarouselController carouselController;
  const ImageSlider(
      {super.key,
      required this.images,
      this.onPageChanged,
      required this.activeIndex,
      required this.carouselController});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: images.length,
              itemBuilder: (_, index, i) {
                if (images.isNotEmpty) {
                  return MyCacheImg(
                      url: images[index],
                      boxfit: BoxFit.contain,
                      height: Dimesion.screenHeight * 0.3,
                      borderRadius: BorderRadius.zero);
                } else {
                  return const Center(child: Text("No Image"));
                }
              },
              options: CarouselOptions(
                  height: Dimesion.screenHeight * 0.3,
                  autoPlay: false,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayInterval: const Duration(seconds: 4),
                  pauseAutoPlayOnTouch: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  onPageChanged: onPageChanged)),
          Container(
              margin: EdgeInsets.symmetric(vertical: Dimesion.height10),
              alignment: Alignment.center,
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: images.length,
                effect: WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColor.primaryClr,
                    dotWidth: Dimesion.width5 * 1.4,
                    dotHeight: Dimesion.width5 * 1.4),
              )),
        ],
      ),
    );
  }
}
