import 'package:best_nail/utils/extension/color_ext.dart';
import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../models/order/order_model.dart';
import '../../../utils/app_color.dart';
import '../../../utils/data_constant.dart';
import '../../../utils/dimesions.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem orderItem;
  const OrderItemWidget({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimesion.width5),
      padding: EdgeInsets.all(Dimesion.width5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
          color: Colors.grey.shade100),
      child: Row(
        children: [
          MyCacheImg(
              height: Dimesion.height40,
              width: Dimesion.height40,
              url: orderItem.productImage ?? "",
              boxfit: BoxFit.contain,
              borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          SizedBox(
            width: Dimesion.width10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderItem.productName ?? "", style: context.titleSmall),
              Text(
                  "${DataConstant.priceFormat.format(orderItem.unitPrice)} Ks x ${orderItem.quantity}",
                  style:
                      context.labelMedium.copyWith(color: AppColor.primaryClr)),
              Wrap(
                  spacing: Dimesion.width5,
                  children: List.generate(
                    orderItem.productVariations!.length,
                    (index) {
                      if (orderItem.productVariations![index]
                          .toString()
                          .startsWith("#")) {
                        return CircleAvatar(
                          radius: Dimesion.radius15 / 2,
                          backgroundColor:
                              orderItem.productVariations![index].toColor(),
                        );
                      } else {
                        return Text(
                          orderItem.productVariations![index],
                          style: context.labelMedium,
                        );
                      }
                    },
                  ))
            ],
          )
        ],
      ),
    );
  }
}
