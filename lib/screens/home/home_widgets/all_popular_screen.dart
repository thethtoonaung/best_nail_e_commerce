import 'package:best_nail/screens/home/home_widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../app_widgets/back_button.dart';
import '../../../app_widgets/custom_loading_widget.dart';
import '../../../app_widgets/footer_widget.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';
import '../../product_detail_screen/product_detail_screen.dart';
import '../home_logic/home_controller.dart';

class AllPopularScreen extends StatefulWidget {
  const AllPopularScreen({
    super.key,
  });

  @override
  State<AllPopularScreen> createState() => _AllPopularScreenState();
}

class _AllPopularScreenState extends State<AllPopularScreen> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController();

    super.initState();
  }

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          homeController.popularPage.value = 1;
          homeController.popularProducts.clear();
          homeController.getPopularProducts(isLoadmore: false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          primary: true,
          leading: backButton(color: Colors.white),
          title: Text(
            "Popular Products",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          centerTitle: false,
          scrolledUnderElevation: 0,
          backgroundColor: AppColor.primaryClr,
          actions: [
            IconButton.filled(
                color: Colors.white.withOpacity(0.2),
                onPressed: () => Get.toNamed(RouteHelper.searchScreen),
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: Dimesion.iconSize16,
                )),
          ],
        ),
        body: homeController.obx(
            (state) => SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  footer: Obx(
                    () => footer(
                        canLoadMore: homeController.popularCanloadMore.value),
                  ),
                  onLoading: _onLoading,
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const WaterDropHeader(),
                  physics: const BouncingScrollPhysics(),
                  child: GridView.builder(
                    padding: EdgeInsets.all(Dimesion.height10),
                    itemCount: homeController.popularProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: Dimesion.screenHeight * 0.22,
                        mainAxisSpacing: Dimesion.width5,
                        crossAxisSpacing: Dimesion.width10),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.productDetailScreen,
                            arguments: ProductDetailScreen(
                              id: homeController.popularProducts[index].id,
                            ));
                      },
                      child: ProductCard(
                        productData: homeController.popularProducts[index],
                      ),
                    ),
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
                )),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));

    homeController.popularPage.value = 1;
    homeController.popularProducts.clear();
    homeController.getPopularProducts(isLoadmore: false);

    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (homeController.popularCanloadMore.value) {
      homeController.popularPage.value++;
      homeController.getPopularProducts(isLoadmore: true);
    } else {
      _refreshController.loadNoData();
    }

    _refreshController.loadComplete();
  }
}
