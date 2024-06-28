import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Constants constants = Constants();


class Constants {
  static final Constants _constants = Constants._i();

  factory Constants() {
    return _constants;
  }

  Constants._i();
  void showSnackBarSuccess(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      colorText: Colors.black,
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
    );
  }

  void showSnackBarError(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }

  static NumberFormat priceFormat = NumberFormat.decimalPattern("en_US");

  void showSnackBarAlert(String title, String msg) {
    Get.snackbar(
      title,
      msg,
      colorText: Colors.black,
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }
}
