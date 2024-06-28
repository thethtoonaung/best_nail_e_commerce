import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_widgets/back_button.dart';
import '../../app_widgets/main_button.dart';
import '../../app_widgets/row_text_widget.dart';
import '../../models/check_out/payment_model.dart';
import '../../services/toast_service.dart';
import '../../utils/app_color.dart';
import '../../utils/data_constant.dart';
import '../../utils/dimesions.dart';
import 'check_out_logic/checkout_controller.dart';
import 'checkout_widgets/selected_payment_widget.dart';
import 'checkout_widgets/upload_photo_widget.dart';

class PayNowCheckOutScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String address;
  final double subTotal;
  final double deliveryFee;
  final PaymentData paymentData;
  const PayNowCheckOutScreen(
      {super.key,
      required this.name,
      required this.phone,
      required this.address,
      required this.subTotal,
      required this.deliveryFee,
      required this.paymentData});

  @override
  State<PayNowCheckOutScreen> createState() => _PayNowCheckOutScreenState();
}

class _PayNowCheckOutScreenState extends State<PayNowCheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        primary: true,
        leading: backButton(color: Colors.white),
        title: Text(
          "Confrim Payment".tr,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
        ),
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.primaryClr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimesion.height10,
            ),
            Text(
              "Upload Screenshot of Payment Transaction".tr,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(
              height: Dimesion.height10,
            ),
            const CheckOutUploadPhotoWidget(),
            SizedBox(
              height: Dimesion.height10,
            ),
            Text(
              "Note: Please upload the screenshot of your payment transaction to confirm your payment."
                  .tr,
              style: Theme.of(context).textTheme.labelSmall,
            ),
            SizedBox(
              height: Dimesion.width5,
            ),
            SelectPaymentWidget(paymentData: widget.paymentData),
            const Divider(),
            RowTextWidget(title: "Name", val: widget.name),
            RowTextWidget(title: "Phone Number", val: widget.phone),
            RowTextWidget(title: "Address", val: widget.address),
            const Divider(),
            RowTextWidget(
                title: "Sub Total",
                val: "${DataConstant.priceFormat.format(widget.subTotal)} KS"),
            RowTextWidget(
                title: "Delivery Fees",
                val:
                    "${DataConstant.priceFormat.format(widget.deliveryFee)} KS"),
            RowTextWidget(
                title: "Grand Total",
                val:
                    "${DataConstant.priceFormat.format(widget.subTotal + widget.deliveryFee)} KS"),
            const Spacer(),
            mainButton(
                color: AppColor.primaryClr,
                title: Text("Order Now".tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white)),
                onTap: () {
                  CheckOutController controller =
                      Get.find<CheckOutController>();
                  if (controller.pickedImagePath == null) {
                    ToastService.errorToast("Please upload payment screenshot");
                  } else {
                    controller.postOrder(isCod: false);
                  }
                },
                borderRadius: Dimesion.radius15,
                width: Dimesion.screeWidth),
            SizedBox(
              height: Dimesion.height40,
            ),
          ],
        ),
      ),
    );
  }
}
