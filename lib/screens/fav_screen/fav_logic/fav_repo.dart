import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../../../utils/route_constant.dart';

class FavRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  FavRepo({required this.apiClient, required this.prefService});

  Future<Response> getFavList() async {
    return await apiClient.getData(RouteConstant.fav);
  }

  Future<Response> addFav({required int productId}) async {
    return await apiClient.postFormData(
        RouteConstant.fav,
        FormData({
          "product_id": "$productId",
        }));
  }

  Future<Response> deleteFav({required int favId}) async {
    return await apiClient.postFormData(
        RouteConstant.deleteFav, FormData({"product_id": favId}));
  }

  Future<String> getAppToken() async => await prefService.getAppToken();
}
