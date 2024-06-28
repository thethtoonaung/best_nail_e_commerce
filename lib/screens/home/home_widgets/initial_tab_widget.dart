import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../app_widgets/footer_widget.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';
import '../../product_detail_screen/product_detail_screen.dart';
import '../../shopping_screen/shopping_widget/popular_product_widget.dart';
import '../home_logic/home_controller.dart';
import 'bannerwidget.dart';
import 'news_arrival_widget.dart';

class InitialTabWidget extends StatefulWidget {
  const InitialTabWidget({super.key});

  @override
  State<InitialTabWidget> createState() => _InitialTabWidgetState();
}

class _InitialTabWidgetState extends State<InitialTabWidget> {
  late RefreshController _refreshController;
  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  int current = 0;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return homeController.obx(
        (state) => SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            footer: Obx(
              () => footer(
                  canLoadMore: homeController
                      .productController.allProductCanloadMore.value),
            ),
            onLoading: _onLoading,
            enablePullDown: true,
            enablePullUp: true,
            header: const WaterDropHeader(),
            physics: const BouncingScrollPhysics(),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: Dimesion.width5,
                ),
                SizedBox(
                  height: Dimesion.width5,
                ),
                Obx(() {
                  if (homeController.status == RxStatus.loading()) {
                    return const Center(
                      child: SizedBox(),
                    );
                  } else {
                    return homeController.banners.isEmpty
                        ? const SizedBox()
                        : BannerWidget(
                            banners: homeController.banners,
                            onPageChanged: (val, reason) {
                              setState(() {
                                current = val;
                              });
                            },
                            onTapBanner: () async {
                              await homeController.productController
                                  .getProductDetail(
                                      id: homeController
                                              .banners[current].productId ??
                                          0);
                              Get.toNamed(RouteHelper.productDetailScreen,
                                  arguments: ProductDetailScreen(
                                    id: homeController
                                            .banners[current].productId ??
                                        0,
                                  ));
                            },
                          );
                  }
                }),
                Container(
                    margin: EdgeInsets.only(top: Dimesion.width5),
                    alignment: Alignment.center,
                    child: AnimatedSmoothIndicator(
                      activeIndex: current,
                      count: homeController.banners.length,
                      effect: WormEffect(
                          dotColor: Colors.grey,
                          activeDotColor: AppColor.primaryClr,
                          dotWidth: Dimesion.width5 * 1.4,
                          dotHeight: Dimesion.width5 * 1.4),
                    )),
                const PopularProductWidget(),
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimesion.width10, top: Dimesion.height10),
                  child: Text(
                    "New Arrivals".tr,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const NewArrivalsWidget()
              ],
            )),
        onError: (error) => const Center(child: Text("Error")),
        onEmpty: const Center(child: Text("No Data Found")),
        onLoading: const Center(
          child: CustomLoadingWidget(),
        ));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    homeController.productController.allProductPage.value = 1;
    homeController.popularPage.value = 1;
    homeController.banners.clear();
    homeController.popularProducts.clear();
    homeController.productController.allProducts.clear();
    homeController.getBanners();
    homeController.getPopularProducts(isLoadmore: false);
    homeController.productController.getAllProducts(isLoadmore: false);
    homeController.getCategories();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (homeController.productController.allProductCanloadMore.value) {
      homeController.productController.allProductPage.value =
          homeController.productController.allProductPage.value + 1;
      homeController.productController.getAllProducts(isLoadmore: true);
    } else {
      _refreshController.loadNoData();
    }
    _refreshController.loadComplete();
  }
}
