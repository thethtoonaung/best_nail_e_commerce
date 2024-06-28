import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../utils/dimesions.dart';
import '../product_by_screen.dart';
import '../shopping_screen_logic/shopping_controller.dart';
import 'brandandcatcard_widget.dart';

class BrandAndCategoriesWidget extends GetView<ShoppingController> {
  final bool isBrand;
  const BrandAndCategoriesWidget({Key? key, required this.isBrand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
        (state) => GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: Dimesion.height10),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: Dimesion.width10,
                  crossAxisSpacing: Dimesion.width5,
                  mainAxisExtent: Dimesion.screenHeight * 0.12),
              itemCount: isBrand
                  ? controller.shoppingBrands.length
                  : controller.shoppingCategories.length,
              itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    if (isBrand) {
                      controller.productController.productByBrandPage.value = 1;
                      controller.productController.productsByBrand.clear();
                      controller.productController.getProductByBrand(
                          id: controller.shoppingBrands[index].id ?? 0,
                          isLoadmore: false);
                    } else {
                      controller.productController.productByCategoryPage.value =
                          1;
                      controller.productController.productsByCategory.clear();
                      controller.productController.getProductsByCategory(
                          id: controller.shoppingCategories[index].id ?? 0,
                          isLoadmore: false);
                    }
                    Get.toNamed(RouteHelper.productByScreen,
                        arguments: ProductByScreen(
                            title: isBrand
                                ? controller.shoppingBrands[index].name ?? ""
                                : controller.shoppingCategories[index].name ??
                                    "",
                            isBrand: isBrand,
                            id: isBrand
                                ? controller.shoppingBrands[index].id ?? 0
                                : controller.shoppingCategories[index].id ??
                                    0));
                  },
                  child: isBrand
                      ? BrandandCategoryCardWidget(
                          url: controller.shoppingBrands[index].image ?? "",
                          title: controller.shoppingBrands[index].name ?? "")
                      : BrandandCategoryCardWidget(
                          title:
                              controller.shoppingCategories[index].name ?? "",
                          url: controller.shoppingCategories[index].icon ?? "",
                        )),
            ),
        onEmpty: Center(
          child: Text(
            "Empty Data",
            style: context.titleSmall,
          ),
        ),
        onLoading: const Center(
          child: CustomLoadingWidget(),
        ),
        onError: (error) => Center(
              child: Text(
                error ?? "",
                style: context.titleSmall,
              ),
            ));
  }
}
