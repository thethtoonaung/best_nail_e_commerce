
import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../../../utils/route_constant.dart';

class CartRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  CartRepo({required this.apiClient, required this.prefService});

  Future<Response> addCart(
      {required FormData formData}) async {
    return await apiClient.postFormData(RouteConstant.cart,
        formData);
  }

  Future<Response> getCarts() async {
    return await apiClient.getData(RouteConstant.cart);
  }

  updateHeader(String token) {
    apiClient.updateHeader(token);
  }

  Future<Response> updateCart(
      {required int cartId, required int quantity}) async {
    return await apiClient.patchData(
        RouteConstant.updateCart(cartId: cartId, quantity: quantity), {});
  }

  Future<Response> deleteCart({required int cartId}) async {
    return await apiClient.deleteData(RouteConstant.deleteCard(cartId: cartId));
  }

  Future<String> getAppToken() async => await prefService.getAppToken();
}


