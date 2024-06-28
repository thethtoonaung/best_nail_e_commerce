import 'package:animations/animations.dart';
import 'package:best_nail/screens/home/home_widgets/product_card_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../app_widgets/footer_widget.dart';
import '../../../controllers/product_controller.dart';
import '../../../utils/dimesions.dart';
import '../../product_detail_screen/product_detail_screen.dart';

class HomeTabViewWidget extends StatefulWidget {
  final int id;
  const HomeTabViewWidget({
    super.key,
    required this.id,
  });

  @override
  State<HomeTabViewWidget> createState() => _HomeTabViewWidgetState();
}

class _HomeTabViewWidgetState extends State<HomeTabViewWidget> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  final ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return productController.obx(
        (state) => SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              footer: Obx(
                () => footer(
                    canLoadMore:
                        productController.productByCategoryCanloadMore.value),
              ),
              onLoading: _onLoading,
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              physics: const BouncingScrollPhysics(),
              child: productController.productsByCategory.isEmpty
                  ? const Center(
                      child: Text("There is no products."),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(Dimesion.height10),
                      itemCount: productController.productsByCategory.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: Dimesion.screenHeight * 0.22,
                          mainAxisSpacing: Dimesion.width5,
                          crossAxisSpacing: Dimesion.width10),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) => OpenContainer(
                          closedElevation: 0,
                          openElevation: 0,
                          transitionType: ContainerTransitionType.fadeThrough,
                          transitionDuration: const Duration(milliseconds: 400),
                          closedBuilder: (_, close) => ProductCard(
                                productData:
                                    productController.productsByCategory[index],
                              ),
                          openBuilder: (_, open) =>
                               ProductDetailScreen(id: productController.productsByCategory[index].id,)),
                    ),
            ),
        onLoading: const Center(
          child: CustomLoadingWidget(),
        ),
        onEmpty: const Center(
          child: Text("No Products Found"),
        ),
        onError: (error) => Center(
              child: Text("$error"),
            ));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));

    productController.productByCategoryPage.value = 1;
    productController.productsByCategory.clear();
    productController.getProductsByCategory(id: widget.id, isLoadmore: false);

    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (productController.productByCategoryCanloadMore.value) {
      productController.productByCategoryPage.value++;
      productController.getProductsByCategory(id: widget.id, isLoadmore: true);
    } else {
      _refreshController.loadNoData();
    }

    _refreshController.loadComplete();
  }
}
