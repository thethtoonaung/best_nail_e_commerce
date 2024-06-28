import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../utils/route_constant.dart';

class NotiRepo {
  final ApiClient apiClient;

  NotiRepo({required this.apiClient});

  Future<Response> getNotifications() async {
    return await apiClient.getData(RouteConstant.notification);
  }

  Future<Response> getNotificationDetail(int id) async {
    return await apiClient.getData(RouteConstant.deTailNotification(id: id));
  }
}
