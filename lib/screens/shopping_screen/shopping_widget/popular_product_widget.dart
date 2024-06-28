import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../app_widgets/view_all_button.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../utils/dimesions.dart';
import '../../home/home_logic/home_controller.dart';
import '../../home/home_widgets/product_card_widget.dart';
import '../../product_detail_screen/product_detail_screen.dart';

class PopularProductWidget extends GetView<HomeController> {
  const PopularProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimesion.screeWidth,
      height: Dimesion.screenHeight * 0.3,
      padding: EdgeInsets.all(Dimesion.width10 / 2),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Popular Products".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            ViewAllButton(
                ontap: () => Get.toNamed(RouteHelper.allPopularProductScreen))
          ],
        ),
        Obx(() {
          if (controller.popularProducts.isEmpty) {
            return const SizedBox.shrink();
          } else if (controller.status.isLoading) {
            return const Center(child: CustomLoadingWidget());
          } else if (controller.status.isSuccess) {
            return Expanded(
                child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              shrinkWrap: false,
              itemCount: controller.popularProducts.length,
              separatorBuilder: (context, index) => SizedBox(
                width: Dimesion.width5,
              ),
              itemBuilder: (_, index) => InkWell(
                  onTap: () => Get.toNamed(RouteHelper.productDetailScreen,
                      arguments: ProductDetailScreen(
                        id: controller.popularProducts[index].id,
                      )),
                  child: ProductCard(
                    removeBg: true,
                    productData: controller.popularProducts[index],
                  )),
            ));
          } else {
            return const SizedBox.shrink();
          }
        })
      ]),
    );
  }
}
