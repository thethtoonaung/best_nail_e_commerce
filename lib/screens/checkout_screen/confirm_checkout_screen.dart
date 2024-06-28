import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_widgets/back_button.dart';
import '../../app_widgets/main_button.dart';
import '../../app_widgets/my_text_filed.dart';
import '../../services/toast_service.dart';
import '../../utils/app_color.dart';
import '../../utils/data_constant.dart';
import '../../utils/dimesions.dart';
import 'check_out_logic/checkout_controller.dart';
import 'checkout_widgets/confirm_item_widget.dart';
import 'checkout_widgets/payment_sheet.dart';

class ConfirmCheckoutScreen extends GetView<CheckOutController> {
  final bool isCod;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ConfirmCheckoutScreen({super.key, required this.isCod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        primary: true,
        leading: backButton(color: Colors.white),
        title: Text(
          "Confirm Checkout".tr,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.primaryClr,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimesion.width5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: Dimesion.width5,
            ),
            Text(
              "Name".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            MyTextFieldWidget(
                controller: controller.nameController,
                isPasswords: false,
                hintText: "Mr John Doe",
                prefixIcon: Icons.person,
                inputType: TextInputType.text,
                fieldValidator: (value) {
                  if (value!.isEmpty) {
                    ToastService.errorToast("Please enter your name");
                    return "";
                  } else {
                    return null;
                  }
                },
                inputAction: TextInputAction.done),
            Text(
              "Phone Number".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            MyTextFieldWidget(
              controller: controller.phoneController,
              isPasswords: false,
              prefixIcon: Icons.phone,
              hintText: "09 123 456 789",
              inputType: TextInputType.text,
              inputAction: TextInputAction.done,
              fieldValidator: (value) {
                if (value!.isEmpty) {
                  ToastService.errorToast("Please enter your phone number");
                  return "";
                } else if (!value.toString().isPhoneNumber) {
                  ToastService.errorToast("Please enter valid phone number");
                  return "";
                } else {
                  return null;
                }
              },
            ),
            Text(
              "Address Detail".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            MyTextFieldWidget(
                controller: controller.addressController,
                isPasswords: false,
                hintText: "No. 123, 12 Street, Yangon",
                prefixIcon: Icons.pin_drop,
                inputType: TextInputType.text,
                inputAction: TextInputAction.done,
                fieldValidator: (value) {
                  if (value!.isEmpty) {
                    ToastService.errorToast("Please enter your address");
                    return "";
                  } else {
                    return null;
                  }
                }),
            Text(
              "Items in Your Cart".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimesion.height10 / 2,
            ),
            Obx(
              () => Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.cartController.cartList.length,
                      itemBuilder: (_, index) => ConfirmItemWIdget(
                          imgUrl: controller.cartController.cartList[index]
                              .product!.getImageList().last,
                          variables: controller.cartController.cartList[index]
                                  .productVariation!.variations ??
                              [],
                          unitPrice:
                              "${DataConstant.priceFormat.format(controller.cartController.cartList[index].unitPrice)} Ks",
                          quantity: controller
                              .cartController.cartList[index].quantity
                              .toString()))),
            ),
            SizedBox(
              height: Dimesion.width5,
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(Dimesion.width10),
        margin: EdgeInsets.only(bottom: Dimesion.height40),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total".tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    "${DataConstant.priceFormat.format(controller.cartController.totalAmount.value)} Ks",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Fees".tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    "${DataConstant.priceFormat.format(controller.searchDeliveryData.value.fees)} Ks",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Grand Total".tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    "${DataConstant.priceFormat.format(double.parse(controller.cartController.totalAmount.value.toString()) + double.parse(controller.searchDeliveryData.value.fees.toString()))} Ks",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: Dimesion.height10,
              ),
              mainButton(
                color: AppColor.primaryClr,
                title: Text(
                  isCod ? "Order Now" : "Go to Payment".tr,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                ),
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    if (isCod) {
                      controller.postOrder(isCod: isCod);
                    } else {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) => const PaymentSheet());
                    }
                  }
                },
                borderRadius: Dimesion.radius15,
                width: Dimesion.screeWidth,
                height: Dimesion.height40 * 1.1,
              ),
            ]),
      ),
    );
  }
}
