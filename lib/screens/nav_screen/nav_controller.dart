import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../services/pref_service.dart';
import '../auth/auth_logic/auth_controller.dart';
import '../auth/profile_screen/profile_screen.dart';
import '../cart_screen/cart_screen.dart';
import '../home/home_screen.dart';
import '../shopping_screen/shopping_screen.dart';

class NavController extends GetxController implements GetxService {
  final PrefService prefService;
  final AuthController authController;
  NavController(this.authController, {required this.prefService});

  RxInt selectedScreen = 0.obs;
  List<Widget> screens = <Widget>[
    const HomeScreen(),
    const ShoppingScreen(),
    const CartScreen(),
    const ProfileScreen()
  ].obs;

  RxList<String> titles = <String>[
    "Home",
    "",
    "Voice For You",
    "Read With Points",
  ].obs;

  Future<bool> checkLoginOrNot() async {
    var token = await prefService.getAppToken();
    if (token.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
