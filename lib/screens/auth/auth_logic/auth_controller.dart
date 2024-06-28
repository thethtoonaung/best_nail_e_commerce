import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/custom_loading_widget.dart';
import '../../../models/auth/auth_model.dart';
import '../../../routes_helper/routes_helper.dart';
import '../../../services/noti_service.dart';
import '../../../services/toast_service.dart';
import '../../../utils/app_config.dart';
import 'auth_repo.dart';

class AuthController extends GetxController with StateMixin {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  @override
  void onInit() {
    init();
    super.onInit();
  }

  RxString appToken = "".obs;
  //* For Login ------------------------->
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Rx<User> userData = User().obs;

  Future<void> login() async {
    var loading = BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) => const CustomLoadingWidget(),
    );
    var fcmToken = await authRepo.getFcmToken();
    print("Login_FCM_Token>>>>"+fcmToken.toString());
    var body = {
      "email": loginEmailController.text,
      "password": loginPasswordController.text,
      "fcm_token": fcmToken
    };
    try {
      Response response = await authRepo.loginUser(body);
      if (response.statusCode == 200) {
        AuthModel authModel = AuthModel.fromJson(response.body);
        userData.value = authModel.data!.user!;
        appToken.value = authModel.data!.token!;
        authRepo.savePassword(password: loginPasswordController.text);
        authRepo.saveAppToken(token: authModel.data!.token!);
        authRepo.updateHeader(authModel.data!.token!);
        loading();
        clearTextFields();
        ToastService.successToast("Login Success");
        Get.offNamed(RouteHelper.home);
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
  }

//* For Register ------------------------->
  final TextEditingController regNameController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController regConfirmPassController =
      TextEditingController();

  RxString passVal = "".obs;
  onChangePassField(val) {
    passVal.value = val;
  }


  Future<void> registerUser() async {
    var loading = BotToast.showCustomLoading(
      toastBuilder: (cancelFunc) => const CustomLoadingWidget(),
    );
    var fcmToken = await authRepo.getFcmToken();
    print("Fcm token register: $fcmToken");
    var body = {
      "name": regNameController.text,
      "email": regEmailController.text,
      "password": regPasswordController.text,
      "password_confirmation": regConfirmPassController.text,
      "user_role": "user",
      "fcm_token": fcmToken
    };
    try {
      Response response = await authRepo.registerUser(body);
      if (response.statusCode == 201) {
        ToastService.successToast("Successfully Registered");
        await Future.delayed(const Duration(seconds: 2));
        AuthModel authModel = AuthModel.fromJson(response.body);
        userData.value = authModel.data!.user!;
        appToken.value = authModel.data!.token!;
        authRepo.savePassword(password: regPasswordController.text);
        authRepo.saveAppToken(token: authModel.data!.token!);
        authRepo.updateHeader(authModel.data!.token!);
        loading();
        clearTextFields();
        ToastService.successToast("Login Success");
        Get.offNamed(RouteHelper.home);
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      return ToastService.errorToast(e.toString());
    } finally {
      loading();
    }
  }



  //* For Logout ------------------------->

  Future<void> logout() async {
    BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());

    try {
      Response response = await authRepo.logoutUser();
      if (response.statusCode == 200) {
        authRepo.saveAppToken(token: "");
        authRepo.savePassword(password: "");
        appToken.value = "";
        userData.value = User();
        ToastService.successToast("Successfully Logout");
        BotToast.closeAllLoading();
        Get.offNamed(RouteHelper.initial);
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  //* Get User Data ------------------------->
  getAppToken() async {
    appToken.value = await authRepo.getAppToken();
  }

  //* Clear Data------------------------>
  clearTextFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
    regNameController.clear();
    regEmailController.clear();
    regPasswordController.clear();
    regConfirmPassController.clear();
  }

  //* For Profile Card ------------------------->

  RxBool isObscure = true.obs;

  Future<void> getUser({required bool isInitial}) async {
    userData.value = User();
    if (!isInitial) {
      BotToast.showCustomLoading(
        toastBuilder: (cancelFunc) => const CustomLoadingWidget(),
      );
    }try {authRepo.updateHeader(appToken.value);
      Response response = await authRepo.getUser();
    print("User_Token>>>>"+appToken.value.toString());
    print("Get_User>>>>"+response.statusCode.toString());
      if (response.statusCode == 200) {
        User data = User.fromJson(response.body['data']);
        userData.value = data;
      } else if (response.statusCode == 401) {
        logout();
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  init() async {
    notiInit();
    await getAppToken();
    isSwitchedOn.value = await authRepo.getAppLanguage();
    onChangeLanguage(isSwitchedOn.value);
    if (appToken.value.isNotEmpty) {
      await getUser(isInitial: true);
    }
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    regNameController.dispose();
    regEmailController.dispose();
    regPasswordController.dispose();
    regConfirmPassController.dispose();
    super.onClose();
  }

  //* For Language ------------------------->
  RxBool isSwitchedOn = false.obs;

  onChangeLanguage(val) {
    isSwitchedOn.value = val;
    if (isSwitchedOn.value) {
      Get.updateLocale(const Locale('bu_mm'));
      authRepo.saveAppLanguage(val: isSwitchedOn.value);
    } else {
      Get.updateLocale(const Locale('en_us'));
      authRepo.saveAppLanguage(val: isSwitchedOn.value);
    }
  }

  onChangeLanguageValOnLogin(AppLanguage val) {
    if (val == AppLanguage.mm) {
      Get.updateLocale(const Locale('bu_mm'));
      authRepo.saveAppLanguage(val: true);
    } else {
      Get.updateLocale(const Locale('en_us'));
      authRepo.saveAppLanguage(val: false);
    }
  }

  //*For Update Profile ------------------------->

  Future<void> updateProfile(
      {required File? img,
      required String? name,
      required String? email}) async {
    BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    String pass = await authRepo.getPassword();
    FormData formData = FormData({
      "name": name,
      "email": email,
      "profile_picture":
          img == null ? null : MultipartFile(img.path, filename: 'profile.png'),
      "old_password": pass,
      "password": pass,
      "password_confirmation": pass,
    });
    try {
      Response response = await authRepo.updateProfile(formData: formData);
      if (response.statusCode == 200) {
        ToastService.successToast("Successfully Updated");
        await Future.delayed(const Duration(milliseconds: 500));
        await getUser(isInitial: false);
        BotToast.closeAllLoading();
        Get.back();
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Future<void> updatePassword(
      {required String newPass,
      required String newConfirmPass,
      required File? img,
      required String name,
      required String email}) async {
    BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    String oldPass = await authRepo.getPassword();
    FormData formData = FormData({
      "name": name,
      "email": email,
      "profile_picture":
          img == null ? null : MultipartFile(img.path, filename: 'profile.png'),
      "old_password": oldPass,
      "password": newPass,
      "password_confirmation": newConfirmPass,
    });

    try {
      Response response = await authRepo.updateProfile(formData: formData);

      if (response.statusCode == 200) {
        ToastService.successToast("Successfully Updated");
        await Future.delayed(const Duration(milliseconds: 500));

        BotToast.closeAllLoading();
        logout();
      } else {
        ToastService.errorToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }

  Future<void> deleteAccount() async {
    BotToast.showCustomLoading(
        toastBuilder: (_) => const CustomLoadingWidget());
    try {
      Response response = await authRepo.deleteAccoutn();
      if (response.statusCode == 200) {
        authRepo.saveAppToken(token: "");
        authRepo.savePassword(password: "");
        BotToast.closeAllLoading();
        Get.offAllNamed(RouteHelper.initial);
      } else {
        BotToast.closeAllLoading();
        ToastService.warningToast(response.body['message']);
      }
    } catch (e) {
      ToastService.errorToast(e.toString());
    } finally {
      BotToast.closeAllLoading();
    }
  }
}
