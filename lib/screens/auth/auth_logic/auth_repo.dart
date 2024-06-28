import 'package:get/get.dart';

import '../../../services/api_service.dart';
import '../../../services/pref_service.dart';
import '../../../utils/route_constant.dart';

class AuthRepo {
  final ApiClient apiClient;
  final PrefService prefService;
  AuthRepo({required this.apiClient, required this.prefService});

  Future<Response> registerUser(body) async {
    return await apiClient.postData(RouteConstant.register, body);
  }

  Future<Response> loginUser(body) async {
    return await apiClient.postData(RouteConstant.login, body);
  }

  Future<Response> getUser() async {
    return await apiClient.getData(RouteConstant.getUser);
  }

  Future<Response> updateProfile({required FormData formData}) async {
    return apiClient.postFormData(RouteConstant.updateUser, formData);
  }

  Future<Response> updatePassword({required FormData formData}) async {
    return apiClient.postData(RouteConstant.updateUser, formData);
  }

  Future<Response> logoutUser() async {
    return await apiClient.getData(RouteConstant.logout);
  }

  Future<Response> deleteAccoutn() async {
    return await apiClient.deleteData(RouteConstant.deleteUser);
  }

  updateHeader(String token) {
    apiClient.updateHeader(token);
  }

  saveAppToken({required String token}) =>
      prefService.saveAppToken(token: token);

  savePassword({required String password}) =>
      prefService.savePassword(password: password);
  saveAppLanguage({required bool val}) => prefService.saveAppLanguage(val: val);

  Future<String> getPassword() async => await prefService.getPassword();
  Future<String> getAppToken() async => await prefService.getAppToken();
  Future<bool> getAppLanguage() async => await prefService.getAppLanguage();
  Future<String> getFcmToken() async => await prefService.getFcmToken();
}

