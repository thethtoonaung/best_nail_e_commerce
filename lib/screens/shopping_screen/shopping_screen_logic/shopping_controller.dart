import 'package:get/get.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/brand/brand_model.dart';
import '../../../models/category/category_model.dart';
import 'shopping_repo.dart';

class ShoppingController extends GetxController with StateMixin {
  final ShoppingRepo shoppingRepo;
  final ProductController productController;
  ShoppingController(
      {required this.shoppingRepo, required this.productController});
  @override
  onInit() {
    getShoppingCategory();
    super.onInit();
  }

  RxList<CategoryData> shoppingCategories = <CategoryData>[].obs;
  RxList<BrandData> shoppingBrands = <BrandData>[].obs;

  Future<void> getShoppingCategory() async {
    change([], status: RxStatus.loading());
    try {
      final response = await shoppingRepo.getCategories();
      if (response.statusCode == 200) {
        final CategoryModel categoryModel =
            CategoryModel.fromJson(response.body);
        shoppingCategories.assignAll(categoryModel.data!);
        change(shoppingCategories, status: RxStatus.success());
      } else {
        change([], status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }

  Future<void> getShoppingBrands() async {
    change([], status: RxStatus.loading());
    try {
      final response = await shoppingRepo.getBrands();
      if (response.statusCode == 200) {
        final BrandModel brandModel = BrandModel.fromJson(response.body);
        shoppingBrands.assignAll(brandModel.data!);
        change(shoppingBrands, status: RxStatus.success());
      } else {
        change([], status: RxStatus.error(response.bodyString));
      }
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }

  void getShoppingCategories() {}
}
