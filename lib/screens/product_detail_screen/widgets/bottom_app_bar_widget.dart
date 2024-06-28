import 'package:best_nail/models/cart/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_widgets/main_button.dart';
import '../../../controllers/product_controller.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';
import '../../cart_screen/cart_logic/cart_controller.dart';

class ProductBottomBar extends GetView<CartController> {
  final int productVariationId;
  final ProductController productController;
  const ProductBottomBar({
    super.key,
    required this.productController,
    required this.productVariationId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.primaryClr,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimesion.radius20),
              topRight: Radius.circular(Dimesion.radius20))),
      padding: EdgeInsets.only(
          bottom: Dimesion.height15,
          top: Dimesion.height15,
          left: Dimesion.height10,
          right: Dimesion.height10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: Dimesion.height40 * 1.1,
          padding: EdgeInsets.all(Dimesion.width5 / 2),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimesion.radius15)),
          child: Obx(
            () => Row(
              children: [
                IconButton(
                    onPressed: () =>
                        productController.changeQuantity(isIncrease: true),
                    icon: const Icon(Icons.add_circle_rounded)),
                Text(
                  productController.detailQuantity.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                IconButton(
                    onPressed: () =>
                        productController.changeQuantity(isIncrease: false),
                    icon: const Icon(Icons.remove_circle_rounded)),
              ],
            ),
          ),
        ),
        SizedBox(
          width: Dimesion.width10,
        ),
        Expanded(
          child: mainButton(
            title: Text(
              "Add to Cart".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              if (productController.canAddtoCart(context: context,product_vid: productVariationId)) {
                productController.toCartModel.value.quantity=productController.detailQuantity.value;
                productController.toCartModel.value.product_wholesale_id=productController.wholeSaleID.value;
                productController.toCartModel.value.product_variation_ids=productController.selectedVariationId.value;
                productController.toCartModel.value.product_variation_id=productController.selectedVariationId.value;
                if(productController.productDetail.value.productWholesales!=null){
                  productController.toCartModel.value.product_variation_quantities=productController.productDetail.value.productWholesales![productController.currentWHIndex.value].quantity!;
                }else{
                  productController.toCartModel.value.product_variation_quantities=0;
                }
                controller.addCart(toCartModel: productController.toCartModel.value, wholesale: productController.isWholeSale.value);
              }
            },
            width: Dimesion.screeWidth * 0.4,
            height: Dimesion.height40 * 1.1,
            borderRadius: Dimesion.radius15,
          ),
        ),
      ]),
    );
  }
}

