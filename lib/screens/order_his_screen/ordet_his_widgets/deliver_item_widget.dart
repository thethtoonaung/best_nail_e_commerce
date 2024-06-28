import 'package:flutter/material.dart';
import '../../../app_widgets/my_cache_img.dart';
import '../../../models/order/order_model.dart';
import '../../../utils/dimesions.dart';

class DeliverytItemWidget extends StatelessWidget {
  final Delivery delivery;
  const DeliverytItemWidget({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyCacheImg(
            height: Dimesion.height40,
            width: Dimesion.height40,
            url: delivery.logo ?? "",
            boxfit: BoxFit.cover,
            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
        SizedBox(
          width: Dimesion.width10,
        ),
        Text(delivery.name ?? "")
      ],
    );
  }
}
