import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../controllers/product_controller.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../utils/dimesions.dart';
import '../../product_detail_screen/product_detail_screen.dart';
import 'product_card_widget.dart';

class NewArrivalsWidget extends GetView<ProductController> {
  const NewArrivalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.allProducts.isEmpty) {
        return const Center(child: CustomLoadingWidget());
      } else {
        return Center(
          child: GridView.builder(
            padding: EdgeInsets.all(Dimesion.height10),
            itemCount: controller.allProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: Dimesion.screenHeight * 0.22,
                mainAxisSpacing: Dimesion.width5,
                crossAxisSpacing: Dimesion.width10),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => InkWell(
              onTap: () => Get.toNamed(RouteHelper.productDetailScreen,
                  arguments: ProductDetailScreen(
                    id: controller.allProducts[index].id,
                  )),
              child: ProductCard(
                productData: controller.allProducts[index],
              ),
            ),
          ),
        );
      }
    });
  }
}
