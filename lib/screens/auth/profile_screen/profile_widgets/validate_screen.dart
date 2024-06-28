import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_widgets/main_button.dart';
import '../../../../app_widgets/my_text_filed.dart';
import '../../../../routes_helper/routes_helper.dart';
import '../../../../services/toast_service.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/dimesions.dart';
import '../../auth_logic/auth_controller.dart';

class ValidateWidget extends StatefulWidget {
  const ValidateWidget({super.key});

  @override
  State<ValidateWidget> createState() => _ValidateWidgetState();
}

class _ValidateWidgetState extends State<ValidateWidget> {
  final TextEditingController passController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.white,
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: Dimesion.height10,
              ),
              Text(
                "Verify your account".tr,
                style:
                    context.titleMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Dimesion.height15,
              ),
              MyTextFieldWidget(
                  controller: passController,
                  isPasswords: true,
                  hintText: "Enter your password".tr,
                  prefixIcon: Icons.password,
                  inputType: TextInputType.text,
                  inputAction: TextInputAction.done),
              const Spacer(),
              mainButton(
                  color: AppColor.primaryClr,
                  title: Text(
                    "Continue".tr,
                    style: context.titleSmall.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    String password =
                        await authController.authRepo.getPassword();
                    if (passController.text == password) {
                      Get.back();
                      Get.toNamed(RouteHelper.updateProfileScreen);
                    } else {
                      ToastService.errorToast("Wrong Password");
                    }
                  },
                  borderRadius: Dimesion.radius15 / 2,
                  width: Dimesion.screeWidth * 0.8),
              SizedBox(
                height: Dimesion.height40,
              ),
            ],
          ),
        );
      },
    );
  }
}
