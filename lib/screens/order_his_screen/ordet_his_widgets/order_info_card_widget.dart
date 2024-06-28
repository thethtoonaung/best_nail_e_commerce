import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/order/order_model.dart';
import '../../../utils/data_constant.dart';
import '../../../utils/dimesions.dart';

class OrderInfoCardWidget extends StatelessWidget {
  final OrderData orderData;
  final Color orderColor;
  const OrderInfoCardWidget(
      {super.key, required this.orderData, required this.orderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimesion.width5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${orderData.orderNo}",
                style: context.labelSmall.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(orderData.orderStatus.toString().capitalizeFirst ?? "",
                  style: context.titleSmall.copyWith(color: orderColor))
            ],
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${DataConstant.priceFormat.format(orderData.grandTotal)} Ks",
                style: context.titleLarge.copyWith(color: orderColor),
              ),
              Text(
                "Date: ${DataConstant.dateFormat.format(DateTime.parse(orderData.orderDate.toString()))}",
                style: context.labelSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
