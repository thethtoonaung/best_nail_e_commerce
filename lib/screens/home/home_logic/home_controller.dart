import 'package:get/get.dart';
import '../../../controllers/product_controller.dart';
import '../../../models/category/category_model.dart';
import '../../../models/products/banner_model.dart';
import '../../../models/products/product_model.dart';
import 'home_repo.dart';

class HomeController extends GetxController with StateMixin {
  final ProductController productController;
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo, required this.productController});

  @override
  void onInit() {
    getCategories();
    getBanners();
    getPopularProducts(isLoadmore: false);
    productController.getAllProducts(isLoadmore: false);
    super.onInit();
  }

  RxInt currentTabIndex = 0.obs;

  RxList<CategoryData> categories = <CategoryData>[].obs;

  Future<void> getCategories() async {
    categories.clear();
    categories.add(
        CategoryData(id: 0, name: "All", icon: "assets/icons/category.png"));
    change(categories, status: RxStatus.loading());

    try {
      final response = await homeRepo.getCategories();

      if (response.statusCode == 200) {
        final CategoryModel categoryModel =
            CategoryModel.fromJson(response.body);
        change([
          CategoryData(id: 0, name: "All", icon: "assets/icons/category.png")
        ], status: RxStatus.loading());
        categories.addAll(categoryModel.data!);
        change(categories, status: RxStatus.success());
      } else {
        change([
          CategoryData(id: 0, name: "All", icon: "assets/icons/category.png")
        ], status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(
          [CategoryData(id: 0, name: "All", icon: "assets/icons/category.png")],
          status: RxStatus.error(e.toString()));
    }
  }

  onChangeCatTab(int index) {
    currentTabIndex.value = index;
    productController.productByCategoryPage.value = 1;
    productController.productsByCategory.clear();
    productController.getProductsByCategory(
        id: categories[index].id ?? 0, isLoadmore: false);
  }

  //* Get Banners --->
  RxList<BannerData> banners = <BannerData>[].obs;

  Future<void> getBanners() async {
    banners.clear();
    change(banners, status: RxStatus.loading());

    try {
      final response = await homeRepo.getBanners();

      if (response.statusCode == 200) {
        final BannerModel bannerModel = BannerModel.fromJson(response.body);
        banners.addAll(bannerModel.data!);
        change(banners, status: RxStatus.success());
      } else {
        change(banners, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(banners, status: RxStatus.error(e.toString()));
    }
  }

  //* GET Popular Products

  RxList<ProductData> popularProducts = <ProductData>[].obs;
  RxInt popularPage = 1.obs;
  RxBool popularCanloadMore = false.obs;

  Future<void> getPopularProducts({required bool isLoadmore}) async {
    if (isLoadmore) {
      change(popularProducts, status: RxStatus.loadingMore());
    } else {
      change(popularProducts, status: RxStatus.loading());
    }
    try {
      final response =
          await homeRepo.getPopularProducts(page: popularPage.value);
      if (response.statusCode == 200) {
        final ProductModel productModel = ProductModel.fromJson(response.body);
        popularProducts.addAll(productModel.data!);
        popularCanloadMore.value = productModel.canLoadMore!;
        change(popularProducts, status: RxStatus.success());
      } else {
        change(popularProducts, status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change(popularProducts, status: RxStatus.error(e.toString()));
    }
  }
}
