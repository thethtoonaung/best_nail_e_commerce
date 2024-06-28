import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../repository/product_repo.dart';
import '../screens/auth/auth_logic/auth_controller.dart';
import '../screens/auth/auth_logic/auth_repo.dart';
import '../screens/cart_screen/cart_logic/cart_controller.dart';
import '../screens/cart_screen/cart_logic/cart_repo.dart';
import '../screens/checkout_screen/check_out_logic/check_out_repo.dart';
import '../screens/checkout_screen/check_out_logic/checkout_controller.dart';
import '../screens/fav_screen/fav_logic/fav_controller.dart';
import '../screens/fav_screen/fav_logic/fav_repo.dart';
import '../screens/nav_screen/nav_controller.dart';
import '../screens/noti_screen/noti_logic/noti_controller.dart';
import '../screens/noti_screen/noti_logic/noti_repo.dart';
import '../services/api_service.dart';
import '../services/pref_service.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() async {
    //* Repository
    Get.put(
        AuthRepo(
            apiClient: Get.find<ApiClient>(),
            prefService: Get.find<PrefService>()),
        permanent: true);

    Get.put(
        ProductRepo(
            apiClient: Get.find<ApiClient>(),
            prefService: Get.find<PrefService>()),
        permanent: true);

    Get.put(
        CartRepo(
            apiClient: Get.find<ApiClient>(),
            prefService: Get.find<PrefService>()),
        permanent: true);
    Get.put(FavRepo(
        apiClient: Get.find<ApiClient>(),
        prefService: Get.find<PrefService>()));
    Get.lazyPut(() => CheckOutRepo(
        apiClient: Get.find<ApiClient>(),
        prefService: Get.find<PrefService>()));
    Get.put(NotiRepo(apiClient: Get.find<ApiClient>()));
    //* Controllers
    Get.put(AuthController(authRepo: Get.find<AuthRepo>()), permanent: true);
    Get.put(
        NavController(
            prefService: Get.find<PrefService>(), Get.find<AuthController>()),
        permanent: true);

    Get.put(
        FavController(
          favRepo: Get.find<FavRepo>(),
        ),
        permanent: true);
    Get.put(
        CartController(
            cartRepo: Get.find<CartRepo>(),
            favController: Get.find<FavController>(),),
        permanent: true);
    Get.put(
        ProductController(
            productRepo: Get.find<ProductRepo>(),
            cartController: Get.find<CartController>(),
            authController: Get.find<AuthController>(),
            favController: Get.find<FavController>(),
            navController: Get.find<NavController>()),
        permanent: true);
    Get.put(CheckOutController(
        checkOutRepo: Get.find<CheckOutRepo>(),
        cartController: Get.find<CartController>()));
    Get.put(NotiController(
        notiRepo: Get.find<NotiRepo>(), authRepo: Get.find<AuthRepo>()));
  }
}
