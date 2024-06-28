import 'package:best_nail/screens/auth/profile_screen/profile_widgets/items_widget.dart';
import 'package:best_nail/screens/auth/profile_screen/profile_widgets/logout_button.dart';
import 'package:best_nail/screens/auth/profile_screen/profile_widgets/no_login_widget.dart';
import 'package:best_nail/screens/auth/profile_screen/profile_widgets/profile_card_widget.dart';
import 'package:best_nail/screens/auth/profile_screen/profile_widgets/validate_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_config.dart';
import '../../../utils/dimesions.dart';
import '../../home/home_widgets/home_leading_widget.dart';
import '../auth_logic/auth_controller.dart';

class ProfileScreen extends GetView<AuthController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: const HomeLeadingWidget(),
        leadingWidth: Dimesion.screeWidth * 0.4,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.primaryClr,
        actions: [
          controller.appToken.value.isEmpty
              ? const SizedBox.shrink()
              : LogoutButton(
                  onTap: () => controller.logout(),
                )
        ],
      ),
      body: Obx(
        () => controller.appToken.value.isEmpty
            ? const NoLoginWidget()
            : ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const ProfileCardWidget(),
                  SizedBox(height: Dimesion.height10),
                  ItemsWidget(
                    val: "check your order status".tr,
                    title: "Order History".tr,
                    icon: Icons.receipt_long,
                    onTap: () => Get.toNamed(RouteHelper.orderHisScreen),
                  ),
                  ItemsWidget(
                    val: "change your account setting".tr,
                    title: "Account Setting".tr,
                    icon: Icons.person,
                    onTap: () => Get.bottomSheet(const ValidateWidget()),
                  ),
                  ItemsWidget(
                      val: "learn our privacy policy".tr,
                      title: "Privacy Policy".tr,
                      icon: Icons.safety_check),
                  LanguageItemWidget(
                    val: controller.isSwitchedOn.value
                        ? AppLanguage.mm.desc
                        : AppLanguage.en.desc,
                    title: "Language".tr,
                    icon: Icons.language_rounded,
                    isSwitch: controller.isSwitchedOn.value,
                    onChanged: (val) => controller.onChangeLanguage(val),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Text(
        "Developed By @${AppConfig.appName}",
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
