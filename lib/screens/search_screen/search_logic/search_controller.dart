import 'package:best_nail/screens/search_screen/search_logic/search_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../models/products/product_model.dart';
import '../../../services/toast_service.dart';

class MySearchController extends GetxController {
  final SearchRepo searchRepo;
  MySearchController({required this.searchRepo});

  RxBool isLoading = false.obs;
  RxBool canLoadMore = false.obs;
  RxList<ProductData> results = <ProductData>[].obs;
  final TextEditingController searchController = TextEditingController();
  RxInt page = 1.obs;
  final RefreshController refreshController = RefreshController();

  Future<void> getSearchProducts(
      {required bool isLoadMore, String? from, String? to}) async {
    if (!isLoadMore) {
      isLoading.value = true;
    }
    try {
      var response = await searchRepo.getSearchProducts(
          page: page.value,
          keywords: searchController.text,
          fromPrice: from ?? "",
          toPrice: to ?? "");

      if (response.statusCode == 200) {
        ProductModel productModel = ProductModel.fromJson(response.body);
        results.addAll(productModel.data!);
        canLoadMore.value = productModel.canLoadMore!;
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 300));
    page.value = 1;
    results.clear();
    if (fromPrice.value != 0.0 || toPrice.value != 0.0) {
      getSearchProducts(
          isLoadMore: false,
          from: (fromPrice.value * 1000).toString(),
          to: (toPrice.value * 1000).toString());
    } else {
      getSearchProducts(isLoadMore: false);
    }
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (canLoadMore.value) {
      page.value++;

      if (fromPrice.value != 0.0 || toPrice.value != 0.0) {
        getSearchProducts(
            isLoadMore: true,
            from: (fromPrice.value * 1000).toString(),
            to: (toPrice.value * 1000).toString());
      } else {
        getSearchProducts(isLoadMore: true);
      }
    } else {
      refreshController.loadNoData();
    }
    refreshController.loadComplete();
  }

  //* Filter ------->

  RxDouble fromPrice = 0.0.obs;
  RxDouble toPrice = 0.0.obs;

  onChangeSlider(RangeValues val) {
    fromPrice.value = val.start;
    toPrice.value = val.end;
  }
}
