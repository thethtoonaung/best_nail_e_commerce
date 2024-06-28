import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../../../utils/route_constant.dart';

class HomeRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  HomeRepo({required this.apiClient, required this.prefService});

  Future<Response> getCategories() async {
    return await apiClient.getData(RouteConstant.category);
  }

  Future<Response> getBanners() async {
    return await apiClient.getData(RouteConstant.getBanner);
  }

  Future<Response> getPopularProducts({required int page}) async {
    return await apiClient
        .getData(RouteConstant.getPopularProducts(page: page));
  }
}
