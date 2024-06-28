import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../../../utils/route_constant.dart';

class CheckOutRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  CheckOutRepo({required this.apiClient, required this.prefService});

  Future<Response> getRegions() async {
    return await apiClient.getData(RouteConstant.regions);
  }

  Future<Response> getTownships({required int regionId}) async {
    return await apiClient.getData(RouteConstant.townships(regionId: regionId));
  }

  Future<Response> getDelivery({required int townId}) async {
    return await apiClient.getData(RouteConstant.delivery(townshipId: townId));
  }

  Future<Response> getSearchDelivery(
      {required int townId, required int deliveryId}) async {
    return await apiClient.postFormData(RouteConstant.deliverySearch,
        FormData({"township_id": townId, "delivery_id": deliveryId}));
  }

  Future<Response> getPayments() async {
    return await apiClient.getData(RouteConstant.payments);
  }

  Future<Response> postOrder({required FormData data}) async {
    return await apiClient.postFormData(RouteConstant.orders, data);
  }
}
