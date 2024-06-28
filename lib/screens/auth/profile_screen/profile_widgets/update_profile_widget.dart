import 'dart:io';

import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app_widgets/main_button.dart';
import '../../../../app_widgets/my_cache_img.dart';
import '../../../../app_widgets/my_text_filed.dart';
import '../../../../services/app_validator_service.dart';
import '../../../../services/dialog_service.dart';
import '../../../../services/toast_service.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/dimesions.dart';
import '../../auth_logic/auth_controller.dart';

class UpdateProfileWidget extends StatefulWidget {
  const UpdateProfileWidget({super.key});

  @override
  State<UpdateProfileWidget> createState() => _UpdateProfileWidgetState();
}

class _UpdateProfileWidgetState extends State<UpdateProfileWidget> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    _nameController.text = authController.userData.value.name!;
    _emailController.text = authController.userData.value.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryClr,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: Dimesion.iconSize16,
            ),
          ),
          centerTitle: false,
          title: Text(
            'Update Profile'.tr,
            style: context.titleSmall
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () => DialogService.showDialog(
                    isDelete: true,
                    message: "Are you sure to delete your account ?",
                    dialogType: DialogType.error,
                    onContinue: () {
                      authController.deleteAccount();
                    },
                    context: context),
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: Dimesion.iconSize16,
                ))
          ],
        ),
        body: GetBuilder<AuthController>(builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(Dimesion.width10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.userData.value.profilePicture == null ||
                            _image != null
                        ? Container(
                            height: Dimesion.height40 * 2.5,
                            width: Dimesion.height40 * 2,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: _image == null
                                    ? Border.all(
                                        color: AppColor.primaryClr, width: 1)
                                    : null,
                                borderRadius: BorderRadius.circular(
                                    Dimesion.radius15 / 2)),
                            child: _image == null
                                ? IconButton(
                                    onPressed: () => getImage(),
                                    icon: Icon(
                                      Icons.upload_file,
                                      color: Colors.grey,
                                      size: Dimesion.iconSize16,
                                    ))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimesion.radius15 / 2),
                                    child: Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          )
                        : InkWell(
                            onTap: () => getImage(),
                            child: Container(
                              height: Dimesion.height40 * 2.5,
                              width: Dimesion.height40 * 2,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(
                                      Dimesion.radius15 / 2)),
                              child: MyCacheImg(
                                height: Dimesion.height40 * 2,
                                width: Dimesion.height40 * 2,
                                url: controller.userData.value.profilePicture ??
                                    "",
                                boxfit: BoxFit.cover,
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: Dimesion.width5,
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          MyTextFieldWidget(
                            controller: _nameController,
                            isPasswords: false,
                            prefixIcon: Icons.person,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.done,
                            fieldValidator:
                                AppValidator.nameValidator(context: context),
                          ),
                          MyTextFieldWidget(
                              controller: _emailController,
                              isPasswords: false,
                              prefixIcon: Icons.email,
                              fieldValidator:
                                  AppValidator.emailValidator(context: context),
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.done),
                        ],
                      ),
                    ),
                  ],
                ),
                Text("New Password".tr,
                    style: context.titleSmall.copyWith(
                        color: AppColor.primaryClr,
                        fontWeight: FontWeight.bold)),
                MyTextFieldWidget(
                    controller: _newPassController,
                    hintText: "Enter your new password".tr,
                    isPasswords: false,
                    prefixIcon: Icons.password,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done),
                Text("Confirm Password".tr,
                    style: context.titleSmall.copyWith(
                        color: AppColor.primaryClr,
                        fontWeight: FontWeight.bold)),
                MyTextFieldWidget(
                    hintText: "Confirm your new password".tr,
                    controller: _confirmPassController,
                    isPasswords: false,
                    prefixIcon: Icons.password,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.done),
                SizedBox(
                  height: Dimesion.height40,
                ),
                Center(
                  child: mainButton(
                    color: AppColor.primaryClr,
                    title: Text("Update Profile".tr,
                        style: context.titleSmall.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onTap: () {
                      if (_newPassController.text.isNotEmpty &&
                          _confirmPassController.text.isNotEmpty) {
                        if (_newPassController.text !=
                            _confirmPassController.text) {
                          ToastService.errorToast("Password not match");
                          return;
                        } else {
                          authController.updatePassword(
                              img: _image,
                              name: _nameController.text,
                              email: _emailController.text,
                              newPass: _newPassController.text,
                              newConfirmPass: _confirmPassController.text);
                        }
                      } else if (_formKey.currentState!.validate()) {
                        authController.updateProfile(
                            img: _image,
                            name: _nameController.text,
                            email: _emailController.text);
                      }
                    },
                    borderRadius: Dimesion.radius15 / 2,
                    width: Dimesion.screeWidth * 0.8,
                  ),
                ),
                SizedBox(
                  height: Dimesion.height10,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
