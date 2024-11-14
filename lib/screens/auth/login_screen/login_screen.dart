import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../app_widgets/applogo_widget.dart';
import '../../../app_widgets/glassy_card.dart';
import '../../../app_widgets/main_button.dart';
import '../../../app_widgets/my_text_filed.dart';
import '../../../app_widgets/text_span_button.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../services/app_validator_service.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_config.dart';
import '../../../utils/dimesions.dart';
import '../auth_logic/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  final GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: "loginFormKey");
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: Stack(
          children: [
            Container(
              height: Dimesion.screenHeight * 0.5,
              color: AppColor.primaryClr,
            ),
            Positioned(
              top: Dimesion.screenHeight * 0.06,
              right: Dimesion.width5,
              child: SizedBox(
                width: Dimesion.screeWidth * 0.3,
                child: DropdownButtonFormField(
                    selectedItemBuilder: (context) {
                      return AppLanguage.values.map((e) {
                        return Text(
                          e.desc,
                          style:
                              context.titleSmall.copyWith(color: Colors.white),
                        );
                      }).toList();
                    },
                    style: context.titleSmall.copyWith(color: Colors.white),
                    hint: controller.isSwitchedOn.value
                        ? Text(
                            AppLanguage.mm.desc,
                            style: context.titleSmall
                                .copyWith(color: Colors.white),
                          )
                        : Text(
                            AppLanguage.en.desc,
                            style: context.titleSmall
                                .copyWith(color: Colors.white),
                          ),
                    decoration: InputDecoration(
                        hintStyle:
                            context.titleSmall.copyWith(color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: Dimesion.width10,
                            vertical: Dimesion.height10)),
                    icon: Icon(
                      Iconsax.global,
                      color: Colors.white,
                      size: Dimesion.iconSize16,
                    ),
                    items: AppLanguage.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.desc,
                              style: context.titleSmall,
                            )))
                        .toList(),
                    onChanged: (val) =>
                        controller.onChangeLanguageValOnLogin(val!)),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Dimesion.width10),
                child: GlassyCard(
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(Dimesion.width10),
                      children: [
                        const AppLogoWidget(),
                        SizedBox(
                          height: Dimesion.height15,
                        ),
                        Text(
                          """${AppConfig.appName}""",
                          style: context.titleMedium
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Dimesion.height15,
                        ),
                        Text(
                          "Sign In".tr,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "Please sign in to continue .".tr,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SizedBox(
                          height: Dimesion.height10,
                        ),
                        MyTextFieldWidget(
                          controller: controller.loginEmailController,
                          isPasswords: false,
                          prefixIcon: Iconsax.info_circle,
                          inputType: TextInputType.text,
                          hintText: "Enter your email".tr,
                          inputAction: TextInputAction.next,
                          fieldValidator:
                              AppValidator.emailValidator(context: context),
                        ),
                        SizedBox(
                          height: Dimesion.width5,
                        ),
                        MyTextFieldWidget(
                          controller: controller.loginPasswordController,
                          isPasswords: false,
                          prefixIcon: Iconsax.key,
                          inputType: TextInputType.text,
                          hintText: "Enter your password".tr,
                          inputAction: TextInputAction.next,
                          fieldValidator:
                              AppValidator.passwordValidator(context: context),
                        ),
                        SizedBox(
                          height: Dimesion.height15,
                        ),
                        mainButton(
                            title: Text(
                              "Sign In".tr,
                              style: context.titleSmall
                                  .copyWith(color: Colors.white),
                            ),
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                              if (loginFormKey.currentState!.validate()) {
                                controller.login();
                              }
                            },
                            elevation: 2,
                            color: AppColor.primaryClr,
                            borderRadius: Dimesion.radius20,
                            width: double.maxFinite),
                        SizedBox(
                          height: Dimesion.height15,
                        ),
                        textSpanButton(
                            firstText: "Don't have an account?".tr,
                            buttonText: "Sign Up Here!".tr,
                            ontap: () => Get.toNamed(RouteHelper.register),
                            context: context),
                        SizedBox(
                          height: Dimesion.height15,
                        ),
                      ]),
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: Dimesion.screenHeight * 0.15,
                child: Center(
                    child: TextButton(
                        onPressed: () => Get.offNamed(RouteHelper.home),
                        child: Text("Continue as Guest".tr,
                            style: context.labelSmall.copyWith(
                                color: AppColor.blue,
                                fontWeight: FontWeight.bold)))))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: Text("Developed By THN",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall)),
      ),
    );
  }
}
