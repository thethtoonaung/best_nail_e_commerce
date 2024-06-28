import 'package:best_nail/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../screens/auth/auth_logic/auth_controller.dart';
import '../screens/auth/auth_logic/auth_repo.dart';
import '../screens/auth/login_screen/login_screen.dart';
import '../screens/auth/profile_screen/profile_widgets/update_profile_widget.dart';
import '../screens/auth/register_screen/register_screen.dart';
import '../screens/checkout_screen/checkout_widgets/select_order_screen.dart';
import '../screens/checkout_screen/confirm_checkout_screen.dart';
import '../screens/checkout_screen/pay_now_check_out_screen.dart';
import '../screens/fav_screen/fav_screen.dart';
import '../screens/home/home_logic/home_controller.dart';
import '../screens/home/home_logic/home_repo.dart';
import '../screens/home/home_widgets/all_popular_screen.dart';
import '../screens/nav_screen/nav_screen.dart';
import '../screens/noti_screen/noti_screen.dart';
import '../screens/order_his_screen/logic/order_his_controller.dart';
import '../screens/order_his_screen/logic/order_his_repo.dart';
import '../screens/order_his_screen/order_his_screen.dart';
import '../screens/product_detail_screen/product_detail_screen.dart';
import '../screens/search_screen/search_logic/search_controller.dart';
import '../screens/search_screen/search_logic/search_repo.dart';
import '../screens/search_screen/search_screen.dart';
import '../screens/shopping_screen/product_by_screen.dart';
import '../screens/shopping_screen/shopping_screen_logic/shopping_controller.dart';
import '../screens/shopping_screen/shopping_screen_logic/shopping_repo.dart';
import '../screens/success_screen/success_screen.dart';
import '../services/api_service.dart';
import '../services/pref_service.dart';

class RouteHelper {
  static const String initial = "/initial";
  static const String home = "/home";
  static const String login = "/login";
  static const String register = "/register";
  static const String searchScreen = "/searchScreen";
  static const String notiScreen = "/notiScreen";
  static const String confirmCheckoutScreen = "/confirmCheckoutScreen";
  static const String payNowCheckOutScreen = "/payNowCheckOutScreen";
  static const String successScreen = "/successScreen";
  static const String productByScreen = "/productByScreen";
  static const String productDetailScreen = "/productDetailScreen";
  static const String allPopularProductScreen = "/allPopularProductScreen";
  static const String favScreen = "/favScreen";
  static const String selectDeliveryScreen = "/selectDeliveryScreen";
  static const String orderHisScreen = "/orderHisScreen";
  static const String updateProfileScreen = "/updateProfileScreen";

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => SplashScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: home,
        page: () => const NavScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
        bindings: [
          BindingsBuilder.put(() => HomeRepo(
              apiClient: Get.find<ApiClient>(),
              prefService: Get.find<PrefService>())),
          BindingsBuilder.put(() => HomeController(
              homeRepo: Get.find<HomeRepo>(),
              productController: Get.find<ProductController>())),
          BindingsBuilder.put(
              () => ShoppingRepo(apiClient: Get.find<ApiClient>())),
          BindingsBuilder.put(() => ShoppingController(
              shoppingRepo: Get.find<ShoppingRepo>(),
              productController: Get.find<ProductController>())),
        ]),
    GetPage(
      name: login,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
        name: register,
        page: () => RegisterScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
        bindings: [
          BindingsBuilder.put(() => AuthRepo(
              apiClient: Get.find<ApiClient>(),
              prefService: Get.find<PrefService>())),
          BindingsBuilder.put(
              () => AuthController(authRepo: Get.find<AuthRepo>()))
        ]),
    GetPage(
        name: notiScreen,
        page: () => const NotiScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: searchScreen,
        page: () => const SearchScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
        bindings: [
          BindingsBuilder.put(
              () => SearchRepo(apiClient: Get.find<ApiClient>())),
          BindingsBuilder.put(
              () => MySearchController(searchRepo: Get.find<SearchRepo>()))
        ]),
    GetPage(
        name: confirmCheckoutScreen,
        page: () {
          Get.arguments;
          ConfirmCheckoutScreen confirmCheckoutScreen = Get.arguments;
          return confirmCheckoutScreen;
        },
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: payNowCheckOutScreen,
        page: () {
          Get.arguments;
          PayNowCheckOutScreen noticBoardDetailScreen = Get.arguments;
          return noticBoardDetailScreen;
        },
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: successScreen,
        page: () {
          Get.arguments;
          SuccessScreen successScreen = Get.arguments;
          return successScreen;
        },
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: productByScreen,
        page: () {
          Get.arguments;
          ProductByScreen productByScreen = Get.arguments;
          return productByScreen;
        },
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
      name: productDetailScreen,
      page: () {
        Get.arguments;
        ProductDetailScreen productDetailScreen = Get.arguments;
        return productDetailScreen;
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
        name: allPopularProductScreen,
        page: () => const AllPopularScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: favScreen,
        page: () => const FavScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: selectDeliveryScreen,
        page: () => const SelectDeliveryScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300)),
    GetPage(
        name: orderHisScreen,
        page: () => const OrderHisScreen(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 300),
        bindings: [
          BindingsBuilder.put(() => OrderHisRepo(
                apiClient: Get.find<ApiClient>(),
              )),
          BindingsBuilder.put(
              () => OrderHisController(orderHisRepo: Get.find<OrderHisRepo>()))
        ]),
    GetPage(
      name: updateProfileScreen,
      page: () => const UpdateProfileWidget(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
