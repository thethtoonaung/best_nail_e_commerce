import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/row_text_widget.dart';
import '../../../utils/data_constant.dart';
import '../../../utils/dimesions.dart';
import '../check_out_logic/checkout_controller.dart';

class SummerizeOrderInfoWidget extends GetView<CheckOutController> {
  const SummerizeOrderInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RowTextWidget(
              title: "Delivery Fees".tr,
              val:
                  "${DataConstant.priceFormat.format(controller.searchDeliveryData.value.fees ?? 0)} Ks"),
          SizedBox(
            height: Dimesion.width5,
          ),
          RowTextWidget(
              title: "Remark".tr,
              val: controller.searchDeliveryData.value.remark ?? "--"),
          SizedBox(
            height: Dimesion.width5,
          ),
          controller.searchDeliveryData.value.cod == "0"
              ? Text(
                  "* Cash on delivery service not avaliable in this region ."
                      .tr,
                  style: context.labelMedium.copyWith(color: Colors.red),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
