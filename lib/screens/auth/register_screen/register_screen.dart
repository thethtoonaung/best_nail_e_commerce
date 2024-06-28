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

class RegisterScreen extends GetView<AuthController> {
  final GlobalKey<FormState> regFormKey =
      GlobalKey<FormState>(debugLabel: "registerFormKey");
  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: regFormKey,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: Dimesion.screenHeight * 0.5,
                color: AppColor.primaryClr,
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
                            AppConfig.appName,
                            style: context.titleMedium
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: Dimesion.height15,
                          ),
                          Text(
                            "Welcome".tr,
                            style: context.titleSmall
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text("You can sign up here .".tr,
                              style: context.labelSmall),
                          SizedBox(
                            height: Dimesion.height10,
                          ),
                          MyTextFieldWidget(
                            controller: controller.regNameController,
                            isPasswords: false,
                            prefixIcon: Iconsax.profile_circle,
                            inputType: TextInputType.text,
                            hintText: "Enter your name".tr,
                            inputAction: TextInputAction.next,
                            fieldValidator:
                                AppValidator.nameValidator(context: context),
                          ),
                          MyTextFieldWidget(
                            controller: controller.regEmailController,
                            isPasswords: false,
                            prefixIcon: Iconsax.message_circle,
                            inputType: TextInputType.text,
                            hintText: "Enter your email".tr,
                            inputAction: TextInputAction.next,
                            fieldValidator:
                                AppValidator.emailValidator(context: context),
                          ),
                          MyTextFieldWidget(
                            controller: controller.regPasswordController,
                            isPasswords: true,
                            prefixIcon: Iconsax.key,
                            inputType: TextInputType.text,
                            hintText: "Enter your password".tr,
                            inputAction: TextInputAction.next,
                            onChanged: (p0) => controller.onChangePassField(p0),
                            fieldValidator: AppValidator.passwordValidator(
                                context: context),
                          ),
                          Obx(
                            () => MyTextFieldWidget(
                              controller: controller.regConfirmPassController,
                              isPasswords: true,
                              prefixIcon: Iconsax.password_check,
                              inputType: TextInputType.text,
                              hintText: "Confirm your password".tr,
                              inputAction: TextInputAction.next,
                              fieldValidator:
                                  AppValidator.confirmPasswordValidator(
                                      context: context,
                                      password: controller.passVal.value),
                            ),
                          ),
                          SizedBox(
                            height: Dimesion.height15,
                          ),
                          mainButton(
                              title: Text(
                                "Sign Up".tr,
                                style: context.titleSmall
                                    .copyWith(color: Colors.white),
                              ),
                              onTap: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                if (regFormKey.currentState!.validate()) {
                                  controller.registerUser();
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
                              firstText: "Already has an account?".tr,
                              buttonText: "Sign In Here!".tr,
                              ontap: () => Get.toNamed(RouteHelper.login),
                              context: context),
                          SizedBox(
                            height: Dimesion.height15,
                          ),
                        ]),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
