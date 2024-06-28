import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/order/order_model.dart';
import '../../../services/toast_service.dart';
import 'order_his_repo.dart';

class OrderHisController extends GetxController {
  final OrderHisRepo orderHisRepo;
  OrderHisController({required this.orderHisRepo});
  @override
  void onInit() {
    getOrderHis();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  RxList<OrderData> orderList = <OrderData>[].obs;
  RxBool canLoadMore = true.obs;
  RxInt page = 1.obs;

  Future<void> getOrderHis() async {
    isLoading.value = true;
    try {
      final response = await orderHisRepo.getOrderHis(page: page.value);
      if (response.statusCode == 200) {
        final OrderModel orderModel = OrderModel.fromJson(response.body);
        orderList.addAll(orderModel.data!);
        canLoadMore.value = orderModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Color orderColor(String orderStatus) {
    switch (orderStatus) {
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
