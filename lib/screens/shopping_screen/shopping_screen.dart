import 'package:best_nail/screens/shopping_screen/shopping_screen_logic/shopping_controller.dart';
import 'package:best_nail/screens/shopping_screen/shopping_widget/brandandcat_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../app_widgets/circle_tab_widget.dart';
import '../../routes_helper/routes_helper.dart';
import '../../utils/app_color.dart';
import '../../utils/dimesions.dart';
import '../home/home_widgets/home_leading_widget.dart';
import '../noti_screen/noti_logic/noti_controller.dart';

class ShoppingScreen extends GetView<ShoppingController> {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            primary: true,
            leading: const HomeLeadingWidget(),
            leadingWidth: Dimesion.screeWidth * 0.4,
            scrolledUnderElevation: 0,
            backgroundColor: AppColor.primaryClr,
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
              IconButton.filled(
                  color: Colors.white.withOpacity(0.2),
                  onPressed: () => Get.toNamed(RouteHelper.searchScreen),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 23,
                  )),
            ],
            bottom: TabBar(
                onTap: (index) {
                  if (index == 0) {
                    controller.getShoppingCategories();
                  } else {
                    controller.getShoppingBrands();
                  }
                },
                labelColor: Colors.white,
                indicatorColor: Colors.transparent,
                indicator: CircleTabIndicator(color: Colors.white, radius: 3),
                labelStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                tabs: [
                  Tab(
                    text: "Categories".tr,
                  ),
                  Tab(
                    text: "Brands".tr,
                  )
                ]),
          ),
          body: const TabBarView(
            children: [
              BrandAndCategoriesWidget(isBrand: false),
              BrandAndCategoriesWidget(isBrand: true)
            ],
          )),
    );
  }
}
