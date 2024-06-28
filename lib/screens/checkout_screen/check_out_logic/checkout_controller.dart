import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../models/check_out/delivery_model.dart';
import '../../../models/check_out/payment_model.dart';
import '../../../models/check_out/region_model.dart';
import '../../../models/check_out/search_delivery_model.dart';
import '../../../models/check_out/town_ship_model.dart';
import '../../../models/order/create_order_model.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../services/toast_service.dart';
import '../../cart_screen/cart_logic/cart_controller.dart';
import '../../success_screen/success_screen.dart';
import '../confirm_checkout_screen.dart';
import 'check_out_repo.dart';

class CheckOutController extends GetxController {
  final CheckOutRepo checkOutRepo;
  final CartController cartController;
  CheckOutController(
      {required this.checkOutRepo, required this.cartController});

  @override
  onInit() {
    getRegions();
    super.onInit();
  }

  RxList<RegionData> regionList = <RegionData>[].obs;
  RxList<TownShipData> townShipList = <TownShipData>[].obs;
  RxList<DeliveryData> deliveryList = <DeliveryData>[].obs;
  Rx<SearchDeliveryData> searchDeliveryData = SearchDeliveryData().obs;
  RxString selectedRegion = "---".obs;
  RxString selectedTownShip = "---".obs;

  RxInt selectedRegionId = 0.obs;
  RxInt selectedTownShipId = 0.obs;
  Rx<DeliveryData> selectedDelivery = DeliveryData().obs;
  Rx<RegionState> regionState = RegionState.empty.obs;

  Future<void> getRegions() async {
    regionState.value = RegionState.loading;
    try {
      final response = await checkOutRepo.getRegions();
      if (response.statusCode == 200) {
        final RegionModel regionModel = RegionModel.fromJson(response.body);
        regionList.addAll(regionModel.data!);
        regionState.value = RegionState.success;
      }
    } catch (e) {
      regionState.value = RegionState.error;
      ToastService.errorToast(e.toString());
    } finally {
      regionState.value = RegionState.success;
    }
  }

  onChageRegion(RegionData val) {
    selectedRegion.value = val.name!;
    selectedRegionId.value = val.id!;
    selectedTownShip.value = "---";
    selectedTownShipId.value = 0;
    deliveryList.clear();
    selectedDelivery.value = DeliveryData();
    searchDeliveryData.value = SearchDeliveryData();
    deliState.value = DeliveryState.empty;
    getTownShips(regionId: selectedRegionId.value);
  }

  Rx<TownState> townState = TownState.empty.obs;
  Future<void> getTownShips({required int regionId}) async {
    townState.value = TownState.loading;
    try {
      Response response = await checkOutRepo.getTownships(regionId: regionId);

      if (response.statusCode == 200) {
        TownshipModel data = TownshipModel.fromJson(response.body);
        townShipList.assignAll(data.data!);
        if (townShipList.isEmpty) {
          ToastService.warningToast("No Results");
          townState.value = TownState.empty;
        }
        townState.value = TownState.success;
      } else {
        townState.value = TownState.error;
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
      townState.value = TownState.error;
    }
  }

  onChangeTownShip(TownShipData townShipData) {
    selectedTownShip.value = townShipData.name!;
    selectedTownShipId.value = townShipData.id!;
    deliveryList.clear();
    deliState.value = DeliveryState.empty;
    searchDeliveryData.value = SearchDeliveryData();
    getDeliveries(townId: selectedTownShipId.value);
  }

  onTapTownShip() {
    if (selectedRegion.value == "---") {
      ToastService.warningToast("Please Select Region First");
    }
  }

  Rx<DeliveryState> deliState = DeliveryState.empty.obs;
  Future<void> getDeliveries({required int townId}) async {
    deliState.value = DeliveryState.loading;
    try {
      Response response = await checkOutRepo.getDelivery(townId: townId);
      if (response.statusCode == 200) {
        DeliveryModel data = DeliveryModel.fromJson(response.body);
        deliveryList.assignAll(data.data!);
        if (deliveryList.isEmpty) {
          deliState.value = DeliveryState.empty;
        }
        deliState.value = DeliveryState.success;
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
      deliState.value = DeliveryState.error;
    }
  }

  onChangeDelivery(DeliveryData deliveryData) {
    selectedDelivery.value = deliveryData;
    getSearchDelivery();
  }

  RxBool isLoadingSearch = false.obs;
  Future<void> getSearchDelivery() async {
    isLoadingSearch.value = true;
    try {
      Response response = await checkOutRepo.getSearchDelivery(
          townId: selectedTownShipId.value,
          deliveryId: selectedDelivery.value.id!);
      if (response.statusCode == 200) {
        SearchDeliveryModel data = SearchDeliveryModel.fromJson(response.body);
        searchDeliveryData.value = data.data!;
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoadingSearch.value = false;
    }
  }
//* Reset Checkout Screen ------------->

  resetCheckoutSelection() {
    selectedRegion.value = "---";
    selectedTownShip.value = "---";
    selectedDelivery.value = DeliveryData();
    searchDeliveryData.value = SearchDeliveryData();
    townShipList.clear();
    deliveryList.clear();
    deliState.value = DeliveryState.empty;
    nameController.clear();

    phoneController.clear();
    addressController.clear();
  }

//* Get PayMents ----->

  Rx<PaymentData> selectedPayment = PaymentData().obs;
  RxList<PaymentData> paymentList = <PaymentData>[].obs;
  RxBool isLoadingPayment = false.obs;

  Future<void> getPayments() async {
    isLoadingPayment.value = true;
    try {
      Response response = await checkOutRepo.getPayments();
      if (response.statusCode == 200) {
        PaymentModel data = PaymentModel.fromJson(response.body);
        paymentList.assignAll(data.data!);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoadingPayment.value = false;
    }
  }

  onSelectPayment(PaymentData paymentData) {
    selectedPayment.value = paymentData;
  }

  //* SelectPaymentImage =============>

  File? pickedImagePath;

  XFile? pickedFile;

  final picker = ImagePicker();
  Future<void> pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      XFile image = XFile(pickedFile!.path);
      pickedImagePath = File(image.path);
      update();
    }
  }

  onClearImage() {
    pickedImagePath = null;
    update();
  }

  //* For Confirm Checkout----->
  validateCodForConfirmCheckout() {
    if (selectedRegion.value == "---") {
      ToastService.warningToast("Please Select Region");
    } else if (selectedTownShip.value == "---") {
      ToastService.warningToast("Please Select Township");
    } else if (selectedDelivery.value.id == null) {
      ToastService.warningToast("Please Select Delivery");
    } else if (searchDeliveryData.value.cod == "0") {
      ToastService.warningToast("Service not avaliable.");
    } else {
      Get.toNamed(RouteHelper.confirmCheckoutScreen,
          arguments: ConfirmCheckoutScreen(isCod: true));
    }
  }

  validatePayNowForConfirmCheckout() {
    if (selectedRegion.value == "---") {
      ToastService.warningToast("Please Select Region");
    } else if (selectedTownShip.value == "---") {
      ToastService.warningToast("Please Select Township");
    } else if (selectedDelivery.value.id == null) {
      ToastService.warningToast("Please Select Delivery");
    } else {
      Get.toNamed(RouteHelper.confirmCheckoutScreen,
          arguments: ConfirmCheckoutScreen(isCod: false));
    }
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> postOrder({required bool isCod}) async {
    var loading = BotToast.showCustomLoading(
        toastBuilder: (_) => const Center(
              child: CustomLoadingWidget(),
            ));
    FormData formData;
    if (isCod) {
      formData = FormData({
        "payment_id": selectedPayment.value.id,
        "delivery_id": selectedDelivery.value.id,
        "township_id": selectedTownShipId.value,
        "name": nameController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "COD": 1
      });
    } else {
      formData = FormData({
        "payment_id": selectedPayment.value.id,
        "delivery_id": selectedDelivery.value.id,
        "township_id": selectedTownShipId.value,
        "name": nameController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "transaction_image":
            MultipartFile(pickedImagePath, filename: "payment.jpg"),
        "COD": 0
      });
    }

    try {
      Response response = await checkOutRepo.postOrder(data: formData);

      if (response.statusCode == 200) {
        cartController.cartList.clear();
        cartController.totalAmount.value=0;
        CreateOrderModel createOrderModel =
            CreateOrderModel.fromJson(response.body);
        ToastService.successToast(createOrderModel.message ?? "");
        loading();

        Get.offNamed(RouteHelper.successScreen,
            arguments: SuccessScreen(orderData: createOrderModel.order!));
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
      loading();
    } finally {
      loading();
    }
  }
}

enum RegionState { loading, success, error, empty }

enum TownState { loading, success, error, empty }

enum DeliveryState { loading, success, error, empty }
