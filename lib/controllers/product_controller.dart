import 'package:best_nail/models/cart/add_to_cart_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_widgets/custom_loading_widget.dart';
import '../models/products/product_detail_model.dart';
import '../models/products/product_model.dart';
import '../models/products/product_variations_search_model.dart';
import '../repository/product_repo.dart';
import '../routes_helper/routes_helper.dart';
import '../screens/auth/auth_logic/auth_controller.dart';
import '../screens/cart_screen/cart_logic/cart_controller.dart';
import '../screens/fav_screen/fav_logic/fav_controller.dart';
import '../screens/nav_screen/nav_controller.dart';
import '../services/dialog_service.dart';
import '../services/toast_service.dart';

class ProductController extends GetxController with StateMixin {
  final ProductRepo productRepo;
  final CartController cartController;
  final AuthController authController;
  final FavController favController;
  final NavController navController;
  ProductController(
      {required this.productRepo,
      required this.cartController,
      required this.authController,
      required this.favController,
      required this.navController});

  RxList<ProductData> allProducts = <ProductData>[].obs;
  RxInt allProductPage = 1.obs;
  RxBool allProductCanloadMore = false.obs;
  String productValueVariation = "";

  Future<void> getAllProducts({required bool isLoadmore}) async {
    if (isLoadmore) {
      change(allProducts, status: RxStatus.loadingMore());
    } else {
      change(allProducts, status: RxStatus.loading());
    }
    try {
      final response =
          await productRepo.getAllProducts(page: allProductPage.value);
      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);
        allProducts.addAll(productModel.data!);
        allProductCanloadMore.value = productModel.canLoadMore!;
        change(allProducts, status: RxStatus.success());
      } else {
        change(allProducts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(allProducts, status: RxStatus.error(e.toString()));
    }
  }

//* Get Product By Brand
  RxList<ProductData> productsByBrand = <ProductData>[].obs;
  RxInt productByBrandPage = 1.obs;
  RxBool productByBrandCanloadMore = false.obs;

  Future<void> getProductByBrand(
      {required int id, required bool isLoadmore}) async {
    if (isLoadmore) {
      change(productsByBrand, status: RxStatus.loadingMore());
    } else {
      change(productsByBrand, status: RxStatus.loading());
    }
    try {
      final response = await productRepo.getProductByBrand(
          page: productByBrandPage.value, id: id);
      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);
        productsByBrand.addAll(productModel.data!);
        productByBrandCanloadMore.value = productModel.canLoadMore!;
        change(productsByBrand, status: RxStatus.success());
      } else {
        change(productsByBrand, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(productsByBrand, status: RxStatus.error(e.toString()));
    }
  }

//* Get Product By Category
  RxList<ProductData> productsByCategory = <ProductData>[].obs;
  RxInt productByCategoryPage = 1.obs;
  RxBool productByCategoryCanloadMore = false.obs;

  Future<void> getProductsByCategory(
      {required int id, required bool isLoadmore}) async {
    if (isLoadmore) {
      change(productsByCategory, status: RxStatus.loadingMore());
    } else {
      change(productsByCategory, status: RxStatus.loading());
    }
    try {
      final response = await productRepo.getProductByCategory(
          page: productByCategoryPage.value, id: id);
      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);
        productsByCategory.addAll(productModel.data!);
        productByCategoryCanloadMore.value = productModel.canLoadMore!;
        change(productsByCategory, status: RxStatus.success());
      } else {
        change(productsByCategory, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(productsByCategory, status: RxStatus.error(e.toString()));
    }
  }

//* Get Product Detail
  Rx<AddToCartModel> toCartModel = AddToCartModel().obs;

  Rx<ProductDetailData> productDetail = ProductDetailData().obs;
  RxBool isFavorite = false.obs;
  RxBool isLoading = false.obs;

  Future<void> getProductDetail({required int id}) async {
    productDetail.value = ProductDetailData();
    resetProductScreen();
    isLoading.value=true;

    try {
      final response = await productRepo.getProductDetail(id: id);

      if (response.statusCode == 200) {
        final ProductDetailModel productDetailModel =
            ProductDetailModel.fromJson(response.body);
        productDetail.value = productDetailModel.data!;
        print("Variant>>>"+response.body.toString());
        isFavorite.value = productDetail.value.isFavourite ?? false;
        /*productPrice.value =
            productDetailModel.data!.productVariation!.first.sellPrice!;
        _total.value =
        productDetailModel.data!.productVariation!.first.sellPrice!;
        _price.value =
            productDetailModel.data!.productVariation!.first.stockQuantity!;*/
        avaliableVariations.value = productDetail.value.variations!;
        selectedVIndex.assignAll(List.generate(
            productDetail.value.variations!.length, (index) => 0));
        selectedValues.assignAll(List.generate(
            productDetail.value.variations!.length, (index) => "Select"));
        isLoading.value=false;

      } else {
        ToastService.errorToast("Error ${response.statusText}");
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      //loading();
    }
  }

//* For ProductDetailScreen
  final CarouselController carouselController = CarouselController();
  Rx<ProductVariationSearch> productvariation = ProductVariationSearch().obs;
  RxInt imgIndex = 0.obs;
  RxInt currentWHIndex = 0.obs;
  RxInt wholeSaleID = 0.obs;
  RxInt productPrice = 0.obs;
  RxInt _stock = 0.obs;
  RxInt _price = 0.obs;

  final RxInt _total=0.obs;

  RxList<int?> selectedVIndex = <int?>[].obs;
  RxList<String> selectedValues = <String>[].obs;
  RxList<Variation> avaliableVariations = <Variation>[].obs;
  RxBool isGettingVariations = false.obs;
  RxBool isWholeSale = false.obs;
  RxInt selectedVariationId = 0.obs;
  int get select_variant_id => selectedVariationId.value;


  RxString img_code = "".obs;
  int get total => _total.value;
  int get qty => detailQuantity.value;
  int get price => _price.value;
  int get stock => _stock.value;

  RxInt detailQuantity = 1.obs;

  onChangePrice() {
    _price.value = productvariation.value.productVariation!.sellPrice!;
    detailQuantity.value=1;
    _total.value = price * detailQuantity.value;
  }

  changeQuantity({required bool isIncrease}) {
    if (isIncrease == true) {
      detailQuantity.value++;
    } else {
      if (qty > 1) {
        detailQuantity.value--;
      } else {
        ToastService.warningToast("Quantity can't be less than 1");
      }
    }
    _total.value=_price.value*detailQuantity.value;
    _total.value = _price.value * detailQuantity.value;
  }

  Future<void> getProductVariPrice(
      {required String variation, required String val}) async {
    isGettingVariations.value = true;
    isLoading.value=true;
    print("SelectedVariationId variation: $variation");
    print("SelectedVariationId val: $val");

    try {
      final response = await productRepo.getProductVariationPrice(
          id: productDetail.value.product!.id!, variation: variation, val: val);
      if (response.statusCode == 200) {
        final ProductVariationsSearchModel productVariationModel =
            ProductVariationsSearchModel.fromJson(response.body);
        print("Respon>>>"+response.body.toString());
        productvariation.value = productVariationModel.data!;
        selectedVariationId.value = productvariation.value.productVariation!.id!;
        productPrice.value = productVariationModel.data!.productVariation!.sellPrice!;
        _price.value = productVariationModel.data!.productVariation!.sellPrice!;
        _stock.value = productVariationModel.data!.productVariation!.stockQuantity!;
        avaliableVariations.value = productVariationModel.data!.variations!;
        onChangePrice();
        img_code.value=productVariationModel.data!.productVariation!.image!;

        print("SelectedVariationId Select: ${productvariation.value.productVariation!.id!}");
        isLoading.value=false;
      } else {
        ToastService.errorToast(response.body["message"]);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isGettingVariations.value = false;
      isLoading.value=false;

    }
  }

  resetProductScreen() {
    img_code.value="";
    imgIndex.value = 0;
    productPrice.value = 0;
    _total.value=0;
    _stock.value = 0;
    selectedVIndex.value = [];
    wholeSaleID.value=0;
    isWholeSale.value=false;
    selectedVariationId.value=0;
    cartController.detailQuantity.value = 1;
  }


  onSelectColor({int? val, int? vIndex}) {
    print("OnSelectColor: $val");

    selectedVIndex[vIndex!] = val!;
    selectedValues[vIndex] =
        productDetail.value.variations![vIndex].values![val];
    productValueVariation =
        productDetail.value.variations![vIndex].values![val];
    print("OnSelectColor: $productValueVariation");

    cartController.detailQuantity.value = 1;
    getProductVariPrice(
        variation: avaliableVariations[vIndex].name!,
        val: selectedValues[vIndex]);
  }

  onClearSelection() {
    selectedValues.assignAll(List.generate(
        productDetail.value.variations!.length, (index) => "Select"));
    avaliableVariations.value = productDetail.value.variations!;
    cartController.detailQuantity.value = 1;
  }

  onSelectVariations({String? val, int? vIndex}) {
    selectedVIndex[vIndex ?? 0] =
        productDetail.value.variations?[vIndex ?? 0].values?.indexOf(val ?? "");
    selectedValues[vIndex ?? 0] = val ?? "";

    for (int i = 0; i < selectedVIndex.length; i++) {
      if (i != vIndex) {
        // selectedVIndex[i] = null;
        // selectedValues[i] = "Select";
        break;
      }
    }
    cartController.detailQuantity.value = 1;
    getProductVariPrice(
        variation: avaliableVariations[vIndex ?? 0].name ?? "", val: val ?? "");
  }

  bool canAddtoCart({required BuildContext context, required int product_vid}) {
    if (authController.appToken.isEmpty) {
      DialogService.showDialog(
          isDelete: false,
          message: "Please login to continue.",
          dialogType: DialogType.error,
          context: context,
          onContinue: () => Get.toNamed(RouteHelper.login));
      return false;
    } else if (selectedVariationId.value == 0) {
      ToastService.warningToast("Please Select Variant");
      String results = "";
      if (productDetail.value.variations != null) {
        for (var element in productDetail.value.variations!) {
          results += "${element.name!}, ";
        }
      } else {
        ToastService.warningToast("Please select $results");
      }
      return false;
    } else if (productvariation.value.productVariation!.stockQuantity! < 1) {
      ToastService.warningToast("Item is out of stock");
      return false;
    } else {
      return true;
    }
  }


  //*Toggle Fav ------------->
  addFav({required int productId}) async {
    await favController.addFav(productId: productId).then((value) async {
      if (value) {
        isFavorite.value = true;
        await favController.getFavList();
      }
    });
  }

  removeFav({required int productId}) async {
    await favController.removeFav(productId: productId).then((value) async {
      if (value) {
        isFavorite.value = false;
        await favController.getFavList();
      }
    });
  }
}
