import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../utils/route_constant.dart';

class SearchRepo {
  final ApiClient apiClient;
  SearchRepo({required this.apiClient});

  Future<Response> getSearchProducts(
      {required int page,
      required String keywords,
      String? fromPrice,
      String? toPrice}) async {
    return await apiClient.getData(RouteConstant.getSearchProducts(
        page: page,
        keywords: keywords,
        fromPrice: fromPrice ?? "",
        toPrice: toPrice ?? ""));
  }
}
