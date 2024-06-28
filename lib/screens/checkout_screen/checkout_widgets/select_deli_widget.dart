import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../app_widgets/my_cache_img.dart';
import '../../../models/check_out/delivery_model.dart';
import '../../../utils/dimesions.dart';
import '../check_out_logic/checkout_controller.dart';
class SelectDeliveryWidget extends GetView<CheckOutController> {
  const SelectDeliveryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimesion.width5),
      child: Obx(() {
        if (controller.deliState.value == DeliveryState.empty) {
          return Center(
            child: LottieBuilder.asset("assets/lottie/sleep_panda.json",
                height: Dimesion.screenHeight * 0.2,
                width: Dimesion.screeWidth * 0.5),
          );
        } else if (controller.deliState.value == DeliveryState.loading) {
          return Container(
            height: Dimesion.screenHeight * 0.2,
            alignment: Alignment.center,
            child: const CustomLoadingWidget(),
          );
        } else {
          return SizedBox(
            height: Dimesion.screenHeight * 0.2,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: controller.deliveryList.length,
                itemBuilder: (context, index) => Obx(
                      () => RadioListTile<DeliveryData>.adaptive(
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyCacheImg(
                                  height: Dimesion.screenHeight * 0.05,
                                  width: Dimesion.screeWidth * 0.2,
                                  url:
                                      controller.deliveryList[index].logo ?? "",
                                  boxfit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(
                                      Dimesion.radius15 / 2)),
                              SizedBox(
                                width: Dimesion.width5,
                              ),
                              Text(
                                controller.deliveryList[index].name ?? "",
                                style: context.titleSmall
                                    .copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          value: controller.deliveryList[index],
                          groupValue: controller.selectedDelivery.value,
                          onChanged: (DeliveryData? val) =>
                              controller.onChangeDelivery(val!)),
                    )),
          );
        }
      }),
    );
  }
}
