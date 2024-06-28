import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../utils/app_color.dart';
import '../cart_screen/cart_logic/cart_controller.dart';
import '../fav_screen/fav_logic/fav_controller.dart';
import 'nav_controller.dart';
import 'nav_widget/floationg_nav_item.dart';
import 'nav_widget/nav_bar.dart';

class NavScreen extends GetView<NavController> {
  const NavScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: controller.selectedScreen.value,
          children: controller.screens,
        ),
        bottomNavigationBar: MyFloatingNavbar(
            backgroundColor: Colors.white.withOpacity(0.1),
            selectedBackgroundColor: Colors.white.withOpacity(0.3),
            selectedItemColor: AppColor.primaryClr,
            elevation: 0,
            items: [
              MyFloatingNavbarItem(
                  customWidget: Icon(
                controller.selectedScreen.value == 0
                    ? Iconsax.home
                    : Iconsax.home_2,
                color: controller.selectedScreen.value == 0
                    ? AppColor.primaryClr
                    : Colors.grey,
              )),
              MyFloatingNavbarItem(
                  customWidget: Icon(
                controller.selectedScreen.value == 1
                    ? Iconsax.shop
                    : Iconsax.shop_add,
                color: controller.selectedScreen.value == 1
                    ? AppColor.primaryClr
                    : Colors.grey,
              )),
              MyFloatingNavbarItem(
                  customWidget: Icon(
                controller.selectedScreen.value == 2
                    ? Icons.shopping_cart_checkout_rounded
                    : Icons.shopping_cart_rounded,
                color: controller.selectedScreen.value == 2
                    ? AppColor.primaryClr
                    : Colors.grey,
              )),
              MyFloatingNavbarItem(
                  customWidget: Icon(
                controller.selectedScreen.value == 3
                    ? Iconsax.profile_tick
                    : Iconsax.profile_circle,
                color: controller.selectedScreen.value == 3
                    ? AppColor.primaryClr
                    : Colors.grey,
              )),
            ],
            currentIndex: controller.selectedScreen.value,
            onTap: (val) {
              controller.selectedScreen.value = val;
              if (val == 3) {
                if (controller.authController.appToken.isNotEmpty) {
                  controller.authController.getUser(isInitial: false);
                }
              } else if (val == 2) {
                CartController cartController = Get.find<CartController>();
                FavController favController = Get.find<FavController>();
                if (controller.authController.appToken.isNotEmpty) {
                  cartController.getCarts(isInitial: false);
                  favController.getFavList();
                }
              }
            }),
      ),
    );
  }
}
