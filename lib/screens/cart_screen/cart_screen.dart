import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../app_widgets/main_button.dart';
import '../../routes_helper/routes_helper.dart';
import '../../services/toast_service.dart';
import '../../utils/app_color.dart';
import '../../utils/data_constant.dart';
import '../../utils/dimesions.dart';
import '../home/home_widgets/home_leading_widget.dart';
import '../noti_screen/noti_logic/noti_controller.dart';
import 'cart_logic/cart_controller.dart';
import 'cart_widgets/cart_card_widget.dart';
import 'cart_widgets/empty_cart_view.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        primary: true,
        leading: const HomeLeadingWidget(),
        leadingWidth: Dimesion.screeWidth * 0.4,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.primaryClr,
        toolbarHeight: Dimesion.screenHeight * 0.08,
        actions: [
          GetBuilder<NotiController>(
            builder: (cont) => Badge(
              label: Obx(
                () => Text(
                  cont.unReadNotiList.length.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ),
              backgroundColor: Colors.white,
              child: IconButton.filled(
                  color: Colors.white.withOpacity(0.2),
                  onPressed: () {
                    cont.getNotiList();
                    Get.toNamed(RouteHelper.notiScreen);
                  },
                  icon: Icon(
                    Iconsax.notification,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
          ),
          Obx(
            () => Badge(
              isLabelVisible: controller.favController.favList.isNotEmpty,
              offset: const Offset(2, 1),
              label: Text(
                controller.favController.favList.length.toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              child: IconButton.filled(
                  color: Colors.white.withOpacity(0.2),
                  onPressed: () => Get.toNamed(RouteHelper.favScreen),
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
          ),
          SizedBox(
            width: Dimesion.width5,
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimesion.radius15),
                bottomRight: Radius.circular(Dimesion.radius15))),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Dimesion.screenHeight * 0.07),
          child: Container(
            padding: EdgeInsets.only(
                left: Dimesion.width10,
                right: Dimesion.width10,
                bottom: Dimesion.height10,
                top: Dimesion.height10),
            decoration: BoxDecoration(
                color: AppColor.primaryClr,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimesion.radius15),
                    bottomRight: Radius.circular(Dimesion.radius15))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.shopping_cart_checkout_rounded,
                    color: Colors.white,
                  ),
                  Text("Shopping Cart".tr,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.white)),
                ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.cartList.isEmpty
            ? const EmptyCartView()
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: Dimesion.height10),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.cartList.length,
                itemBuilder: (_, index) {
                  return CartCardWidget(
                    cartData: controller.cartList[index],
                    index: index,
                  );
                }),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Divider(),
          SizedBox(
            height: Dimesion.width5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Obx(
                () => Text(
                  "${DataConstant.priceFormat.format(controller.totalAmount.value)} Ks",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: AppColor.primaryClr),
                ),
              )
            ],
          ),
          SizedBox(
            height: Dimesion.height15,
          ),
          mainButton(
              title: Text(
                "Check Out".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onTap: () async {
                if (controller.cartList.isNotEmpty) {
                  await Get.toNamed(RouteHelper.selectDeliveryScreen);
                } else {
                  ToastService.warningToast("Your cart is empty");
                }
              },
              borderRadius: Dimesion.radius15,
              width: Dimesion.screeWidth,
              height: Dimesion.height40 * 1.1,
              color: AppColor.primaryClr),
          SizedBox(
            height: Dimesion.height15,
          ),
        ]),
      ),

      //
    );
  }
}
