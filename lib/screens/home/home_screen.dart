import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../routes_helper/routes_helper.dart';
import '../../utils/app_color.dart';
import '../../utils/dimesions.dart';
import '../nav_screen/nav_screen.dart';
import '../noti_screen/noti_logic/noti_controller.dart';
import 'home_logic/home_controller.dart';
import 'home_widgets/home_leading_widget.dart';
import 'home_widgets/home_tab_bar_view.dart';
import 'home_widgets/initial_tab_widget.dart';
import 'home_widgets/tab_bar_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      onRefresh: () {
        return Future(() => Get.offAll(() => NavScreen()));
      }, // Your refresh logic
      indicatorBuilder: (context, controller) {
        return Icon(
          Icons.ac_unit,
          color: Colors.red,
          size: 30,
        );
      },
      child: Obx(
        () {
          return DefaultTabController(
            length: controller.categories.length,
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
                  bottom: PreferredSize(
                      preferredSize:
                          Size.fromHeight(Dimesion.screenHeight * 0.07),
                      child: Obx(
                        () => Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              physics: const BouncingScrollPhysics(),
                              isScrollable: true,
                              indicatorColor: Colors.transparent,
                              dividerColor: Colors.transparent,
                              dividerHeight: 0,
                              padding: EdgeInsets.zero,
                              indicatorPadding: EdgeInsets.zero,
                              labelPadding: EdgeInsets.zero,
                              enableFeedback: true,
                              onTap: (value) =>
                                  controller.onChangeCatTab(value),
                              tabs: List.generate(controller.categories.length,
                                  (index) {
                                return Tab(
                                  child: TabbarWidget(
                                    title:
                                        controller.categories[index].name ?? "",
                                    icon:
                                        controller.categories[index].icon ?? "",
                                    isSlected: index ==
                                            controller.currentTabIndex.value
                                        ? true
                                        : false,
                                    index: index,
                                  ),
                                );
                              }),
                            )),
                      ))),
              body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                    controller.categories.length,
                    (index) => index == 0
                        ? const InitialTabWidget()
                        : HomeTabViewWidget(
                            id: controller.categories[index].id ?? 0,
                          )),
              ),
            ),
          );
        },
      ),
    );
  }
}
