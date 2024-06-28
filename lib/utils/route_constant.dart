
import 'app_config.dart';

class RouteConstant {
  static const String baseUrl = "https://production1.sea2023.com/api/";

//* Auth Routes
  static String register = "mobile/register?store_id=${AppConfig.storeId}";
  static String login = "mobile/login?store_id=${AppConfig.storeId}";
  static String logout = "mobile/logout";
  static String getUser = "user";
  static String updateUser = "user/update";
  static String deleteUser = "user/delete";

  //* Category Route
  static String category = "mobile/categories?store_id=${AppConfig.storeId}";
  //* Brand Route
  static String brand = "mobile/brands?store_id=${AppConfig.storeId}";

  //*Product Routes
  static String getProduct({required int page}) =>
      "mobile/products?page=$page&store_id=${AppConfig.storeId}";
  static String getProductDetail({required int id}) => "mobile/products/$id";
  static String getProductByBrand({required int id, required int page}) =>
      "mobile/products?page=$page&brand_id=$id&store_id=${AppConfig.storeId}";
  static String getProductByCategory({required int id, required int page}) =>
      "mobile/products?page=$page&category_id=$id&store_id=${AppConfig.storeId}";
  static String getProductVariations = "mobile/product-variations/search";
  static String getBanner = "mobile/banners?store_id=${AppConfig.storeId}";
  static String getPopularProducts({required int page}) =>
      "mobile/product-ranking?page=$page&store_id=${AppConfig.storeId}";
  static String getSearchProducts(
          {required int page,
          required String keywords,
          String? fromPrice,
          String? toPrice}) =>
      "mobile/products?page=$page&keyword=$keywords&price_from=$fromPrice&price_to=$toPrice&store_id=${AppConfig.storeId}";

  //* Cart Routes
  static String cart = "mobile/carts";
  static String updateCart({required int cartId, required int quantity}) =>
      "mobile/carts/$cartId?quantity=$quantity";
  static String deleteCard({required int cartId}) => "mobile/carts/$cartId";

  //* Fav Routes
  static String fav = "mobile/favourites";
  static String deleteFav = "mobile/favourites/delete";

  //* For Checkout
  static String regions = "mobile/regions";
  static String townships({required int regionId}) =>
      "mobile/regions/$regionId/townships";
  static String delivery({required int townshipId}) =>
      "mobile/townships/$townshipId/deliveries";
  static String deliverySearch = "mobile/delivery-services/search";
  static String payments = "mobile/payments";
  static String orders = "mobile/orders";
  static String orderHistory({required int page}) => "mobile/orders?page=$page";
  static String orderDetail({required int orderId}) => "mobile/orders/$orderId";

  //*Notification
  static String notification = "mobile/notifications";
  static String deTailNotification({required int id}) =>
      "mobile/notifications/$id";
}

