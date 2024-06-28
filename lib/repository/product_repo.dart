import 'package:get/get.dart';

import '../services/api_service.dart';
import '../services/pref_service.dart';
import '../utils/route_constant.dart';

class ProductRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  ProductRepo({required this.apiClient, required this.prefService});

  Future<Response> getAllProducts({required int page}) async {
    return await apiClient.getData(RouteConstant.getProduct(page: page));
  }

  Future<Response> getProductDetail({required int id}) async {
    return await apiClient.getData(RouteConstant.getProductDetail(id: id));
  }

  Future<Response> getProductByBrand(
      {required int page, required int id}) async {
    return await apiClient
        .getData(RouteConstant.getProductByBrand(page: page, id: id));
  }

  Future<Response> getProductByCategory(
      {required int page, required int id}) async {
    return await apiClient
        .getData(RouteConstant.getProductByCategory(page: page, id: id));
  }

  Future<Response> getProductVariationPrice(
      {required int id, required String variation, required String val}) async {
    return await apiClient.postFormData(RouteConstant.getProductVariations,
        FormData({"product_id": id, "variations[$variation]": val}));
  }
}
