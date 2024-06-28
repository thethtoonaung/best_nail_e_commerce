import 'package:best_nail/screens/search_screen/search_logic/search_controller.dart';
import 'package:best_nail/screens/search_screen/search_widgets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../app_widgets/back_button.dart';
import '../../app_widgets/custom_loading_widget.dart';
import '../../app_widgets/empty_view_widget.dart';
import '../../app_widgets/footer_widget.dart';
import '../../app_widgets/my_text_filed.dart';
import '../../routes_helper/routes_helper.dart';
import '../../utils/app_color.dart';
import '../../utils/dimesions.dart';
import '../home/home_widgets/product_card_widget.dart';
import '../product_detail_screen/product_detail_screen.dart';

class SearchScreen extends GetView<MySearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: backButton(color: Colors.white),
          backgroundColor: AppColor.primaryClr,
          centerTitle: false,
          title: Text(
            "Search".tr,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () => showModalBottomSheet(
                    enableDrag: false,
                    isScrollControlled: false,
                    context: context,
                    builder: (_) => const FilterBottomSheet()),
                icon: Icon(
                  Icons.filter_alt_rounded,
                  color: Colors.white,
                  size: Dimesion.iconSize16,
                )),
          ],
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimesion.height40),
              child: MyTextFieldWidget(
                controller: controller.searchController,
                isPasswords: false,
                prefixIcon: Icons.search,
                hintText: "Search Product".tr,
                inputType: TextInputType.text,
                inputAction: TextInputAction.search,
                onChanged: (val) {
                  controller.page.value = 1;
                  EasyDebounce.debounce(
                      'search', const Duration(milliseconds: 500), () async {
                    controller.results.clear();
                    await controller.getSearchProducts(isLoadMore: false);
                  });
                },
              )),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CustomLoadingWidget(),
            );
          } else if (controller.results.isEmpty) {
            return const EmptyViewWidget();
          } else {
            return SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              footer: Obx(
                () => footer(canLoadMore: controller.canLoadMore.value),
              ),
              onLoading: controller.onLoading,
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              physics: const BouncingScrollPhysics(),
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimesion.width10,
                      vertical: Dimesion.height15),
                  itemCount: controller.results.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Dimesion.height10 / 2,
                      crossAxisSpacing: Dimesion.width10 / 2,
                      childAspectRatio: 0.9),
                  itemBuilder: (_, index) => InkWell(
                        onTap: () =>
                            Get.toNamed(RouteHelper.productDetailScreen,
                                arguments: ProductDetailScreen(
                                  id: controller.results[index].id,
                                )),
                        child: ProductCard(
                          productData: controller.results[index],
                        ),
                      )),
            );
          }
        }));
  }
}
