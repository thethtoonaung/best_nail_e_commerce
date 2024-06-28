import 'package:shared_preferences/shared_preferences.dart';

import '../utils/data_constant.dart';

class PrefService {
  final SharedPreferences sharedPreferences;
  PrefService({required this.sharedPreferences});

  Future<void> saveAppToken({required String token}) async {
    sharedPreferences.setString(DataConstant.appToken, token);
  }

  Future<String> getAppToken() async {
    return sharedPreferences.getString(DataConstant.appToken) ?? "";
  }

  Future<void> saveAppLanguage({required bool val}) async {
    sharedPreferences.setBool(DataConstant.appLanguage, val);
  }

  Future<bool> getAppLanguage() async {
    return sharedPreferences.getBool(DataConstant.appLanguage) ?? false;
  }

  Future<void> savePassword({required String password}) async {
    sharedPreferences.setString(DataConstant.password, password);
  }

  Future<String> getPassword() async {
    return sharedPreferences.getString(DataConstant.password) ?? "";
  }

  Future<String> getFcmToken() async {
    return sharedPreferences.getString(DataConstant.fcmToken) ?? "";
  }
}
