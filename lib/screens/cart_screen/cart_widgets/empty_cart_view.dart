import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/dimesions.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lottie/cart.json",
            height: Dimesion.screenHeight * 0.15,
          ),
          Text("Looks like your cart is empty".tr,
              style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
