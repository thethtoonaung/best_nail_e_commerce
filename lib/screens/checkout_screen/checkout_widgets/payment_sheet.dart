import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../app_widgets/main_button.dart';
import '../../../app_widgets/my_cache_img.dart';
import '../../../models/check_out/payment_model.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../services/toast_service.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';
import '../check_out_logic/checkout_controller.dart';
import '../pay_now_check_out_screen.dart';

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({super.key});

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  final CheckOutController checkOutController = Get.find<CheckOutController>();
  @override
  void initState() {
    checkOutController.getPayments();
    checkOutController.selectedPayment.value = PaymentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimesion.height10),
      width: Dimesion.screeWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Select Payment Method".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: Dimesion.height10,
          ),
          Obx(
            () => checkOutController.isLoadingPayment.value
                ? SizedBox(
                    height: Dimesion.screenHeight * 0.3,
                    child: const Center(
                      child: CustomLoadingWidget(),
                    ),
                  )
                : SizedBox(
                    height: Dimesion.screenHeight * 0.3,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: checkOutController.paymentList.length,
                      itemBuilder: (_, index) => Obx(
                        () => RadioListTile<PaymentData>.adaptive(
                          value: checkOutController.paymentList[index],
                          groupValue: checkOutController.selectedPayment.value,
                          onChanged: (val) {
                            if (val != null) {
                              checkOutController.onSelectPayment(val);
                            }
                          },
                          title: Text(
                            checkOutController.paymentList[index].name ?? "",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(
                              checkOutController.paymentList[index].account ??
                                  "",
                              style: Theme.of(context).textTheme.labelSmall),
                          secondary: MyCacheImg(
                              url: checkOutController.paymentList[index].logo ??
                                  "",
                              boxfit: BoxFit.cover,
                              height: Dimesion.height40,
                              width: Dimesion.height40,
                              borderRadius:
                                  BorderRadius.circular(Dimesion.radius15 / 2)),
                        ),
                      ),
                    ),
                  ),
          ),
          mainButton(
            color: AppColor.primaryClr,
            title: Text(
              "Check Out".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
            onTap: () {
              if (checkOutController.selectedPayment.value.id != null) {
                Get.toNamed(RouteHelper.payNowCheckOutScreen,
                    arguments: PayNowCheckOutScreen(
                      name: checkOutController.nameController.text,
                      phone: checkOutController.phoneController.text,
                      address: checkOutController.addressController.text,
                      deliveryFee: double.parse(checkOutController
                          .searchDeliveryData.value.fees
                          .toString()),
                      subTotal: double.parse(
                        checkOutController.cartController.totalAmount.value
                            .toString(),
                      ),
                      paymentData: checkOutController.selectedPayment.value,
                    ));
              } else {
                ToastService.errorToast("Please select payment method");
              }
            },
            borderRadius: Dimesion.radius15,
            width: Dimesion.screeWidth,
          ),
          SizedBox(
            height: Dimesion.height30,
          )
        ],
      ),
    );
  }
}
