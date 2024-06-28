import 'package:best_nail/screens/checkout_screen/checkout_widgets/select_deli_widget.dart';
import 'package:best_nail/screens/checkout_screen/checkout_widgets/summerize_order_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../app_widgets/main_button.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';
import '../check_out_logic/checkout_controller.dart';
import 'drop_down_widget.dart';

class SelectDeliveryScreen extends StatefulWidget {
  const SelectDeliveryScreen({super.key});

  @override
  State<SelectDeliveryScreen> createState() => _SelectDeliveryScreenState();
}

class _SelectDeliveryScreenState extends State<SelectDeliveryScreen> {
  final CheckOutController checkOutController = Get.find<CheckOutController>();

  @override
  void initState() {
    if (checkOutController.regionList.isEmpty) {
      checkOutController.getRegions();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.primaryClr,
          leading: const BackButton(
            color: Colors.white,
          ),
          centerTitle: false,
          title: Text("Checkout".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold))),
      body: ListView(padding: EdgeInsets.all(Dimesion.width10), children: [
        LottieBuilder.asset(
          "assets/lottie/deli.json",
          height: Dimesion.screenHeight * 0.1,
          width: Dimesion.screeWidth,
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
        Obx(
          () => checkOutController.regionState.value == RegionState.loading
              ? const CustomLoadingWidget()
              : DropDownWidget(
                  title: "Region / State".tr,
                  hint: checkOutController.selectedRegion.value,
                  regionList: checkOutController.regionList,
                  onChangedRegion: (val) =>
                      checkOutController.onChageRegion(val!),
                ),
        ),
        Obx(
          () => checkOutController.townState.value == TownState.loading
              ? const CustomLoadingWidget()
              : DropDownWidget(
                  title: "Township / City".tr,
                  hint: checkOutController.selectedTownShip.value,
                  townshipList: checkOutController.townShipList,
                  onTapTownShip: () => checkOutController.onTapTownShip(),
                  onChangedTownship: (val) =>
                      checkOutController.onChangeTownShip(val!),
                ),
        ),
        SizedBox(
          height: Dimesion.width5,
        ),
        Text(
          "Select Delivery".tr,
          style: Theme.of(context).textTheme.titleSmall!,
        ),
        SizedBox(
          height: Dimesion.width5,
        ),
        const SelectDeliveryWidget(),
        SizedBox(
          height: Dimesion.width5,
        ),
        const SummerizeOrderInfoWidget(),
        SizedBox(
          height: Dimesion.height10,
        ),
        const Divider(),
        SizedBox(
          height: Dimesion.height10,
        ),
        Obx(
          () => mainButton(
            color: checkOutController.searchDeliveryData.value.cod == "0"
                ? Colors.grey
                : AppColor.primaryClr,
            title: Text(
              "Cash on Delivery".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
            onTap: () => checkOutController.validateCodForConfirmCheckout(),
            borderRadius: Dimesion.radius15,
            width: Dimesion.screeWidth,
            height: Dimesion.height40 * 1.1,
          ),
        ),
        SizedBox(
          height: Dimesion.height10,
        ),
        mainButton(
          color: AppColor.primaryClr,
          title: Text(
            "Pay Now".tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          onTap: () => checkOutController.validatePayNowForConfirmCheckout(),
          borderRadius: Dimesion.radius15,
          width: Dimesion.screeWidth,
          height: Dimesion.height40 * 1.1,
        ),
        SizedBox(
          height: Dimesion.height40,
        ),
      ]),
    );
  }
}
