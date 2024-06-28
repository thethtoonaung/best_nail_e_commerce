import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../utils/route_constant.dart';

class ShoppingRepo {
  final ApiClient apiClient;
  ShoppingRepo({required this.apiClient});

  Future<Response> getCategories() async {
    return await apiClient.getData(RouteConstant.category);
  }

  Future<Response> getBrands() async {
    return await apiClient.getData(RouteConstant.brand);
  }
}
