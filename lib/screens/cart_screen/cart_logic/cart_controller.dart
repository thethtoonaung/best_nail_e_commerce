import 'package:best_nail/models/cart/add_to_cart_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../models/cart/cart_model.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../services/toast_service.dart';
import '../../fav_screen/fav_logic/fav_controller.dart';
import 'cart_repo.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  final FavController favController;
  CartController({required this.cartRepo, required this.favController});

  @override
  void onInit() {
    loadIfHasToken();
    super.onInit();
  }

  loadIfHasToken() async {
    var token = await cartRepo.getAppToken();

    if (token.isNotEmpty) {
      // cartRepo.updateHeader(token);
      getCarts(isInitial: true);
    }
  }
//* For Product Details --------------->

  RxInt detailQuantity = 1.obs;
  Future<void> addCart({required AddToCartModel toCartModel,required bool wholesale}) async {
    var body;
    if(wholesale==true){
      body = {
        "product_variation_ids[0]": toCartModel.product_variation_ids,
        "product_variation_quantities[0]": toCartModel.product_variation_quantities,
        "product_wholesale_id": toCartModel.product_wholesale_id,
      };
    }else{
      body = {
        "product_variation_id": toCartModel.product_variation_id,
        "quantity": toCartModel.quantity,

      };
    }
    print("Add To Cart>>>>"+body.toString());
    var loading = BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      Response response = await cartRepo.addCart(formData: FormData(body));

      if (response.statusCode == 201) {

        ToastService.successToast(response.body["message"]);
        getCarts(isInitial: true);
      } else if (response.statusCode == 200) {
        ToastService.successToast(response.body["message"]);
      } else {
        if(response.body["message"]=="Unauthenticated."){
          ToastService.errorToast("You are baned !Please Login again");
          Get.offNamed(RouteHelper.login);
        }
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
  }

//* Get  Carts  ------------->
  RxList<CartData> cartList = <CartData>[].obs;
  Future<void> getCarts({required bool isInitial}) async {
    if (!isInitial) {
      BotToast.showCustomLoading(
          toastBuilder: (_) => const CustomLoadingWidget());
    }
    try {
      Response response = await cartRepo.getCarts();

      if (response.statusCode == 200) {
        cartList.value = CartModel.fromJson(response.body).data!;
        cartQuantityList.value = List.generate(
            cartList.length, (index) => cartList[index].quantity!);
        int tamt=0;
        for (var i = 0; i < cartList.length; i++) {
          tamt += cartList[i].totalPrice!;
        }
        totalAmount.value = tamt.toDouble();
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      debugPrint("Get Cart Error $e");
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

//* Delete Cart --------------->
  Future<void> delecteCart({required int cartId}) async {
    BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      Response response = await cartRepo.deleteCart(cartId: cartId);
      if (response.statusCode == 200) {
        ToastService.successToast(response.body["message"]);
        getCarts(isInitial: false);
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

//* Update Cart ------------->
  Future<void> updateCart({required int cartId, required int quantity}) async {
    BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      Response response =
          await cartRepo.updateCart(cartId: cartId, quantity: quantity);
      if (response.statusCode == 200) {
        ToastService.successToast(response.body["message"]);
        getCarts(isInitial: false);
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

//* For Cart --------------->
  RxDouble totalAmount = 0.0.obs;
  RxList<int> cartQuantityList = <int>[].obs;
  updateCartQuantity(
      {required bool isIncrease, required int index, required int cartId}) {
    if (isIncrease) {
      cartQuantityList[index]++;
      EasyDebounce.debounce("cart", const Duration(seconds: 1),
          () => updateCart(cartId: cartId, quantity: cartQuantityList[index]));
    } else {
      if (cartQuantityList[index] > 1) {
        cartQuantityList[index]--;
        EasyDebounce.debounce(
            "cart",
            const Duration(seconds: 1),
            () =>
                updateCart(cartId: cartId, quantity: cartQuantityList[index]));
      } else {
        ToastService.warningToast("Quantity can't be less than 1");
      }
    }
  }

  //* For Detail Quantity --------------->
  changeQuantity({required bool isIncrease}) {
    if (isIncrease) {
      detailQuantity.value++;
    } else {
      if (detailQuantity.value > 1) {
        detailQuantity.value--;
      } else {
        ToastService.warningToast("Quantity can't be less than 1");
      }
    }
  }
}
