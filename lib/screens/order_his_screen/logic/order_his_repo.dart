import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../utils/route_constant.dart';

class OrderHisRepo {
  final ApiClient apiClient;
  OrderHisRepo({required this.apiClient});

  Future<Response> getOrderHis({required int page}) async {
    return await apiClient.getData(RouteConstant.orderHistory(page: page));
  }
}
