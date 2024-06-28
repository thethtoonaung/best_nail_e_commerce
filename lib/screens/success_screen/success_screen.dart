import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../app_widgets/main_button.dart';
import '../../app_widgets/row_text_widget.dart';
import '../../models/order/order_model.dart';
import '../../routes_helper/routes_helper.dart';
import '../../utils/app_color.dart';
import '../../utils/data_constant.dart';
import '../../utils/dimesions.dart';
import '../checkout_screen/check_out_logic/checkout_controller.dart';
import '../noti_screen/noti_logic/noti_controller.dart';

class SuccessScreen extends StatefulWidget {
  final OrderData orderData;
  const SuccessScreen({super.key, required this.orderData});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  final NotiController notiController = Get.find<NotiController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/lottie/thank.json",
              height: Dimesion.screenHeight * 0.4,
              fit: BoxFit.contain,
            ),
            Text("Thank you for your order ${widget.orderData.orderNo}!",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: AppColor.primaryClr)),
            SizedBox(
              height: Dimesion.height10,
            ),
            const Divider(
              color: AppColor.primaryClr,
            ),
            SizedBox(
              height: Dimesion.height10,
            ),
            RowTextWidget(
                title: "Order Type",
                val: widget.orderData.cod == "1"
                    ? "Cash on Delivery"
                    : "Online Payment"),
            SizedBox(
              height: Dimesion.width5,
            ),
            RowTextWidget(
                title: "Sub Total",
                val:
                    "${DataConstant.priceFormat.format(widget.orderData.subTotal)} Ks"),
            SizedBox(
              height: Dimesion.width5,
            ),
            RowTextWidget(
                title: "Delivery Fees",
                val:
                    "${DataConstant.priceFormat.format(widget.orderData.deliveryFee)} Ks"),
            SizedBox(
              height: Dimesion.width5,
            ),
            RowTextWidget(
                title: "Grand Total",
                val:
                    "${DataConstant.priceFormat.format(widget.orderData.grandTotal)} Ks"),
            SizedBox(
              height: Dimesion.height20,
            ),
            mainButton(
              color: AppColor.primaryClr,
              title: Text(
                "Go to Home".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
              ),
              onTap: () async {
                notiController.getNotiList();
                CheckOutController checkOutController =
                    Get.find<CheckOutController>();
                checkOutController.resetCheckoutSelection();
                await Get.offNamed(RouteHelper.home);
              },
              borderRadius: Dimesion.radius15,
              width: Dimesion.screeWidth,
            ),
          ],
        ),
      ),
    );
  }
}
