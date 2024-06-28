import 'package:animations/animations.dart';
import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../app_widgets/custom_loading_widget.dart';
import '../../app_widgets/footer_widget.dart';
import '../../utils/app_color.dart';
import '../../utils/dimesions.dart';
import 'logic/order_his_controller.dart';
import 'order_his_detail_screen.dart';
import 'ordet_his_widgets/order_info_card_widget.dart';

class OrderHisScreen extends StatefulWidget {
  const OrderHisScreen({super.key});

  @override
  State<OrderHisScreen> createState() => _OrderHisScreenState();
}

class _OrderHisScreenState extends State<OrderHisScreen> {
  final OrderHisController controller = Get.find<OrderHisController>();
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Order History".tr,
            style: context.titleSmall
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          backgroundColor: AppColor.primaryClr,
          leading: const BackButton(color: Colors.white),
        ),
        body: GetBuilder<OrderHisController>(
          builder: (controller) => Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CustomLoadingWidget(),
              );
            } else if (controller.orderList.isEmpty) {
              return const Center(
                child: Text("No order history"),
              );
            } else {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                footer: Obx(
                  () => footer(canLoadMore: controller.canLoadMore.value),
                ),
                onLoading: _onLoading,
                header: const WaterDropHeader(),
                physics: const BouncingScrollPhysics(),
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SizedBox(height: Dimesion.height10 / 2),
                    padding: EdgeInsets.all(Dimesion.width5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.orderList.length,
                    itemBuilder: (context, index) => OpenContainer(
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionType: ContainerTransitionType.fadeThrough,
                        closedBuilder: (_, close) => OrderInfoCardWidget(
                              orderData: controller.orderList[index],
                              orderColor: controller.orderColor(
                                  controller.orderList[index].orderStatus ??
                                      ""),
                            ),
                        openBuilder: (_, open) {
                          return OrderHisDetailScreen(
                            orderColor: controller.orderColor(
                                controller.orderList[index].orderStatus ?? ""),
                            orderData: controller.orderList[index],
                          );
                        })),
              );
            }
          }),
        ));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    controller.page.value = 1;
    controller.orderList.clear();
    controller.getOrderHis();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (controller.canLoadMore.value) {
      controller.page.value++;
      controller.getOrderHis();
    } else {
      _refreshController.loadNoData();
    }
    _refreshController.loadComplete();
  }
}
