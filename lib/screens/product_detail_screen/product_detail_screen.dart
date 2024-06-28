
import 'package:best_nail/screens/product_detail_screen/widgets/bottom_app_bar_widget.dart';
import 'package:best_nail/screens/product_detail_screen/widgets/color_widget.dart';
import 'package:best_nail/screens/product_detail_screen/widgets/first_row_widget.dart';
import 'package:best_nail/screens/product_detail_screen/widgets/image_slider_widget.dart';
import 'package:best_nail/screens/product_detail_screen/widgets/variations_widget.dart';
import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../app_widgets/column_text.dart';
import '../../app_widgets/custom_loading_widget.dart';
import '../../app_widgets/main_button.dart';
import '../../app_widgets/my_cache_img.dart';
import '../../audio_player/audio_player_screen.dart';
import '../../controllers/product_controller.dart';
import '../../routes_helper/routes_helper.dart';
import '../../services/dialog_service.dart';
import '../../utils/app_color.dart';
import '../../utils/constants.dart';
import '../../utils/custom_text.dart';
import '../../utils/data_constant.dart';
import '../../utils/dimesions.dart';

class ProductDetailScreen extends StatefulWidget {
  final int? id;
  const ProductDetailScreen({
    super.key,
    this.id,
  });
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int code_index = 0;

  final controller=Get.find<ProductController>();
  String selectedValue = "";
  String selectedValue2 = "";

  bool isWholeSale = false;
  bool isCheck = false;
  int totalWholeSale = 0;
  int actucalWholeSaleQuantity = 0;


  List<String> _selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    print("Product_detail");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text(
          "Product Detail".tr,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black),
        ),
        leading: const BackButton(),
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Obx(
                () => Badge.count(
              isLabelVisible: controller.cartController.cartList.isNotEmpty,
              backgroundColor: AppColor.red,
              count: controller.cartController.cartList.length,
              offset: const Offset(2, 6),
              child: IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    controller.navController.selectedScreen.value = 2;
                    Get.offNamed(RouteHelper.home);
                  },
                  icon: Icon(
                    Iconsax.shopping_cart,
                    color: AppColor.primaryClr,
                    size: Dimesion.iconSize16 * 1.3,
                  )),
            ),
          ),
          Obx(() => IconButton(
              constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: () {
                if (controller.authController.appToken.isEmpty) {
                  DialogService.showDialog(
                      isDelete: false,
                      message: "You need to login first.\nWanna login?",
                      dialogType: DialogType.error,
                      context: context);
                } else {
                  if (controller.isFavorite.value == true) {
                    controller.removeFav(productId: widget.id ?? 0);
                  } else {
                    controller.addFav(productId: widget.id ?? 0);
                  }
                }
              },
              icon: Icon(
                controller.isFavorite.value
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: AppColor.primaryClr,
                size: Dimesion.iconSize16 * 1.3,
              ))),
        ],
      ),
      body: GetBuilder<ProductController>(
          initState: (_) async =>
          await controller.getProductDetail(id: widget.id ?? 0),
          builder: (controller) {
            return Obx(() {
              if (controller.isLoading==false) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: Dimesion.screenHeight * 0.41,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Obx(
                              () => ImageSlider(
                            carouselController: controller.carouselController,
                            images:
                            controller.productDetail.value.product == null
                                ? []
                                : controller.productDetail.value.product!
                                .getImageList(),
                            activeIndex: controller.imgIndex.value,
                            onPageChanged: (val, _) {
                              controller.imgIndex.value = val;
                            },
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                      scrolledUnderElevation: 0,
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize:
                        Size.fromHeight(Dimesion.screenHeight * 0.04),
                        child: Container(
                          padding: EdgeInsets.all(Dimesion.height10 / 2),
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimesion.radius15),
                                  topRight:
                                  Radius.circular(Dimesion.radius15))),
                          child: SizedBox(
                            height: Dimesion.height40 * 1.1,
                            child: Obx(
                                  () => ListView(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    controller.productDetail.value.product ==
                                        null
                                        ? 0
                                        : controller.productDetail.value
                                        .product!.images!.length,
                                        (index) => InkWell(
                                      onTap: () {
                                        controller.carouselController
                                            .animateToPage(index);
                                      },
                                      child: Container(
                                        padding:
                                        EdgeInsets.all(Dimesion.width5),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: Dimesion.width5),
                                        decoration: BoxDecoration(
                                            border: index ==
                                                controller
                                                    .imgIndex.value
                                                ? Border.all(
                                                color:
                                                AppColor.primaryClr,
                                                width: 2)
                                                : null,
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        child: MyCacheImg(
                                            url: controller.productDetail
                                                .value.product!
                                                .getImageList()[index],
                                            height: Dimesion.height40,
                                            width: Dimesion.height40,
                                            boxfit: BoxFit.contain,
                                            borderRadius:
                                            BorderRadius.circular(
                                                Dimesion.radius15 / 2)),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.all(Dimesion.height10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FirstRow(
                                name: controller.productDetail.value.product ==
                                    null
                                    ? ""
                                    : controller.productDetail.value.product!
                                    .name ??
                                    "",
                                unit:
                                "(${controller.productDetail.value.product == null ? "" : controller.productDetail.value.product!.category!.name})",
                                price: SizedBox(
                                  width: Dimesion.screeWidth * 0.4,
                                  child: Obx(
                                        () => Text(
                                      controller.isGettingVariations.value
                                          ? DataConstant.loading
                                          : "${DataConstant.priceFormat.format(controller.productPrice.value)} Ks",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                          color: AppColor.primaryClr,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              Card(
                                  color: Colors.white,
                                  surfaceTintColor: Colors.white,
                                  margin: EdgeInsets.zero,
                                  child: Container(
                                    padding: EdgeInsets.all(Dimesion.width10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        ProductColumnText(
                                            title: "Category".tr,
                                            val: controller.productDetail.value
                                                .product ==
                                                null
                                                ? ""
                                                : controller
                                                .productDetail
                                                .value
                                                .product!
                                                .category!
                                                .name ??
                                                ""),
                                        ProductColumnText(
                                            title: "Brand".tr,
                                            val: controller.productDetail.value
                                                .product ==
                                                null
                                                ? ""
                                                : controller.productDetail.value
                                                .product!.brand!.name!),
                                        Obx(
                                              () => ProductColumnText(
                                              title: "Stock".tr,
                                              val: controller.productDetail
                                                  .value.product ==
                                                  null
                                                  ? ""
                                                  : controller
                                                  .isGettingVariations
                                                  .value
                                                  ? DataConstant.loading
                                                  : "${controller.stock} Instocks"),
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Total Amount:'.tr,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppColor.primaryClr,
                                  ),
                                  Obx(() => controller.isLoading.value==false?
                                  CustomText(
                                    text:
                                    "${Constants.priceFormat.format(controller.total).toString()} Ks",
                                    size: 16,
                                    textColor: AppColor.primaryClr,
                                  ):CustomText(
                                    text:
                                    "${Constants.priceFormat.format(0).toString()} Ks",
                                    size: 16,
                                    textColor: AppColor.primaryClr,
                                  )),
                                ],
                              ),
                              SizedBox(height: 10),
                              for (var i = 0; i < controller.productDetail
                                  .value.variations!.length; i++)
                                controller.productDetail.value.variations![i].name!.toLowerCase()=="code"?
                              Wrap(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Code',
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      MyCacheImg(
                                          url: controller.img_code.value,
                                          height: 100,
                                          width: 90,
                                          boxfit: BoxFit.fill,
                                          borderRadius:
                                          BorderRadius.circular(
                                              Dimesion.radius15 / 2)),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          spacing: 8.0,
                                          runSpacing: 8.0,
                                          children: controller.productDetail
                                              .value.variations![i].values!
                                              .map((category) => InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedCategories.clear();
                                                _selectedCategories.add(category);
                                                controller.getProductVariPrice(variation: controller.productDetail
                                                    .value.variations![i].name.toString(), val: category);
                                                /*productController.sizePosition.value=index,
  productController.detail_price.value=widget.data!.sizes![index].price!,
  productController.select_size.value=widget.data!.sizes![0].size!*/
                                              });
                                            },
                                            child: Chip(
                                              label: Text(category),
                                              backgroundColor: _selectedCategories.contains(category)
                                                  ? AppColor.primaryClr
                                                  : Colors.grey[300],
                                            ),
                                          )).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ):Container(),
                              SizedBox(
                                height: Dimesion.screenHeight * 0.13,
                                width: Dimesion.screeWidth,
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  children: List.generate(
                                      controller.productDetail.value.variations == null ? 0 : controller.productDetail.value
                                          .variations!.length, (index) {
                                    if (controller.productDetail.value
                                        .variations![index].name
                                        .toString()
                                        .toLowerCase() ==
                                        "color") {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            right: Dimesion.width10),
                                        width: Dimesion.screeWidth * 0.45,
                                        height: Dimesion.screenHeight * 0.15,
                                        child: Obx(
                                              () => ColorWidget(
                                            variations: controller.productDetail
                                                .value.variations![index],
                                            selectedColorIndex: controller
                                                .selectedVIndex[index],
                                            onSelectColor: (val) {

                                              controller.onSelectColor(
                                                  val: val, vIndex: index);

                                            },
                                            avaliableVariables: controller
                                                .avaliableVariations[index]
                                                .values,
                                            selectedValue: controller
                                                .selectedValues[index],
                                          ),
                                        ),
                                      );
                                    } else if(controller.productDetail.value
                                        .variations![index].name
                                        .toString()
                                        .toLowerCase() !=
                                        "code") {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            right: Dimesion.width10),
                                        height: Dimesion.screenHeight * 0.15,
                                        width: Dimesion.screeWidth * 0.45,
                                        child: Obx(
                                              () => SelectVariationWidget(
                                            variations: controller.productDetail
                                                .value.variations![index],
                                            selectedVIndex: controller
                                                .selectedVIndex[index]!,
                                            onSelect: (val) =>
                                                controller.onSelectVariations(
                                                    val: val, vIndex: index),
                                            selectedValue: controller
                                                .selectedValues[index],
                                          ),
                                        ),
                                      );
                                    }else{
                                      return Container(
                                        height: 1,
                                      );
                                    }
                                  }),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  mainButton(
                                      padding: EdgeInsets.all(Dimesion.width5),
                                      elevation: 0,
                                      height: Dimesion.height30,
                                      color: AppColor.primaryClr,
                                      title: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.voice_chat,
                                            color: Colors.white,
                                            size: Dimesion.iconSize16 * 1.1,
                                          ),
                                          SizedBox(
                                            width: Dimesion.width5,
                                          ),
                                          Text("Listen Description".tr,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium
                                                  ?.copyWith(
                                                  color: Colors.white))
                                        ],
                                      ),
                                      onTap: () => showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (_) => AudioPlayerScreen(
                                            url: controller
                                                .productDetail
                                                .value
                                                .product!
                                                .voice
                                                ?.voice ??
                                                '',
                                            images: controller.productDetail
                                                .value.product!
                                                .getImageList(),
                                            title: controller.productDetail
                                                .value.product!.name ??
                                                '',
                                          )),
                                      borderRadius: Dimesion.radius15 / 2,
                                      width: Dimesion.width30),
                                  TextButton(
                                      style: ButtonStyle(
                                          padding:
                                          MaterialStateProperty.resolveWith(
                                                  (states) => EdgeInsets.symmetric(
                                                  horizontal:
                                                  Dimesion.width10)),
                                          shape: MaterialStateProperty.resolveWith(
                                                  (states) => RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                      Dimesion.radius15 / 2))),
                                          backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                                  (states) => AppColor.primaryClr.withOpacity(0.5))),
                                      onPressed: () => controller.onClearSelection(),
                                      child: Text(
                                        "Clear Selection".tr,
                                        style: context.titleSmall
                                            .copyWith(color: Colors.white),
                                      )),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: controller.productDetail.value.product!.isWholesale == 1
                                      ? Row(
                                    children: [
                                      Checkbox(
                                        checkColor: AppColor.primaryClr,
                                        value: isWholeSale,
                                        shape: const CircleBorder(),
                                        onChanged: (bool? value) {
                                          isWholeSale = value!;
                                          setState(() {});
                                        },
                                      ),
                                      Text(
                                        "Buy Wholesale".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: AppColor.primaryClr),
                                      )
                                    ],
                                  ): Container()),
                              Wrap(
                                  children: <Widget>[
                                    Visibility(
                                      visible: isWholeSale,
                                      child: controller.productDetail.value.productWholesales!=null?
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .productDetail.value.productWholesales!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 20),
                                                  Checkbox(
                                                      checkColor: Colors.white,
                                                      value: controller
                                                          .productDetail
                                                          .value
                                                          .productWholesales?[index]
                                                          .isCheck ??
                                                          false,
                                                      onChanged: (bool? value) {
                                                        for (var a in controller
                                                            .productDetail
                                                            .value
                                                            .productWholesales!) {
                                                          a.isCheck = false;
                                                          // a.quantity = 0;
                                                        }
                                                        controller.currentWHIndex.value = index;
                                                        controller
                                                            .productDetail
                                                            .value
                                                            .productWholesales?[index]
                                                            .isCheck = value!;
                                                        controller.wholeSaleID.value = controller
                                                            .productDetail
                                                            .value
                                                            .productWholesales?[index]
                                                            .id ??
                                                            0;

                                                        isCheck = value!;
                                                        controller.isWholeSale.value=value;
                                                        controller.total==controller
                                                            .productDetail
                                                            .value
                                                            .productWholesales?[index]
                                                            .quantity ??
                                                            0;
                                                        actucalWholeSaleQuantity = controller
                                                            .productDetail
                                                            .value
                                                            .productWholesales?[index]
                                                            .quantity ??
                                                            0;
                                                        setState(() {});
                                                      }),
                                                  Text(
                                                    "${controller.productDetail.value.productWholesales?[index].quantity} ${'pieces'.tr}",
                                                    style: context
                                                        .theme.textTheme.titleMedium!
                                                        .copyWith(
                                                        color: AppColor.primaryClr),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${controller.productDetail.value.productWholesales?[index].price} ${'Ks'.tr}",
                                                    style: context
                                                        .theme.textTheme.titleMedium!,
                                                  ),
                                                  SizedBox(width: 20),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      ):Container(),
                                    )
                                  ]),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              Text(
                                "Description".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(
                                height: Dimesion.height10,
                              ),
                              Text(
                                controller.productDetail.value.product == null
                                    ? ""
                                    : controller.productDetail.value.product!
                                    .description ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: Colors.black),
                              ),
                            ]),
                      ),
                    )
                  ],
                );
              } else {
                return const Center(child: CustomLoadingWidget());
              }
            });
          }),
      bottomNavigationBar: Obx(
            () => ProductBottomBar(
            productController: controller,
            productVariationId: controller.selectedVariationId.value),
      ),
    );
  }
}
