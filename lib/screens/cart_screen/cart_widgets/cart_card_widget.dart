import 'package:best_nail/utils/extension/color_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../models/cart/cart_model.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../utils/app_color.dart';
import '../../../utils/data_constant.dart';
import '../../../utils/dimesions.dart';
import '../../product_detail_screen/product_detail_screen.dart';
import '../cart_logic/cart_controller.dart';

class CartCardWidget extends GetView<CartController> {
  final CartData cartData;
  final int index;

  const CartCardWidget({
    super.key,
    required this.cartData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: Dimesion.width5,
          left: Dimesion.width5,
          right: Dimesion.width5),
      padding: EdgeInsets.symmetric(horizontal: Dimesion.width5),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          IconButton(
              onPressed: () => controller.delecteCart(cartId: cartData.id!),
              icon: Icon(
                Icons.remove_circle_rounded,
                size: Dimesion.iconSize16,
                color: Colors.red[600],
              )),
          InkWell(
            onTap: () => Get.toNamed(RouteHelper.productDetailScreen,
                arguments: ProductDetailScreen(
                  id: cartData.product!.id!,
                )),
            child: MyCacheImg(
                url: cartData.product?.getImageList().first ?? "",
                boxfit: BoxFit.contain,
                height: Dimesion.height40 * 2,
                width: Dimesion.height40 * 2,
                borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          ), // Container(

          SizedBox(
            width: Dimesion.width10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartData.product?.name ?? "",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: Dimesion.width5,
                ),
                Text(
                    "${cartData.quantity} x ${DataConstant.priceFormat.format(cartData.unitPrice)} Ks",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor.primaryClr)),
                SizedBox(
                  height: Dimesion.width5,
                ),
                Row(
                  children: [
                    ...List.generate(
                        cartData.productVariation!.variations!.length, (i) {
                      if (cartData.productVariation!.variations![i]
                          .toString()
                          .startsWith("#")) {
                        return CircleAvatar(
                          backgroundColor: cartData
                              .productVariation!.variations![i]
                              .toColor(),
                          radius: Dimesion.radius15 * 0.5,
                        );
                      } else {
                        return Container(
                          margin: (i == 0)
                              ? EdgeInsets.only(right: Dimesion.width5)
                              : EdgeInsets.only(left: Dimesion.width5),
                          child: Text(
                              cartData.productVariation!.variations![i]
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: AppColor.primaryClr)),
                        );
                      }
                    }),
                  ],
                )
              ],
            ),
          ),
          cartData.isWholesale==false?
          Column(
            children: [
              IconButton(
                  onPressed: () => controller.updateCartQuantity(
                      cartId: cartData.id!, isIncrease: true, index: index),
                  icon: Icon(
                    Icons.add_circle_rounded,
                    color: AppColor.primaryClr,
                    size: Dimesion.iconSize16 * 1.2,
                  )),
              Obx(
                    () => Text(
                  controller.cartQuantityList[index].toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () => controller.updateCartQuantity(
                      cartId: cartData.id!, isIncrease: false, index: index),
                  icon: Icon(
                    Icons.remove_circle_rounded,
                    color: AppColor.primaryClr,
                    size: Dimesion.iconSize16 * 1.2,
                  )),
            ],
          ):Container(
            child: Center(child: Text("WholeSale  "),),
          )
        ],
      ),
    );
  }
}
