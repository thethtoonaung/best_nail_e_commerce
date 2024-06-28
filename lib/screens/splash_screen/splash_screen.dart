import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes_helper/routes_helper.dart';
import '../../services/pref_service.dart';
import '../../utils/app_color.dart';
import '../../utils/app_config.dart';
import '../../utils/dimesions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PrefService prefService = Get.find<PrefService>();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      var token = await prefService.getAppToken();
      debugPrint("From Splash : $token");
      /*if (token.isNotEmpty) {
        Get.offNamed(RouteHelper.home);
      } else {
        Get.offNamed(RouteHelper.login);
      }*/
      Get.offNamed(RouteHelper.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryClr,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppConfig.appName,
              style: context.titleLarge
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              AppConfig.appTagLine,
              style: context.titleLarge
                  .copyWith(fontWeight: FontWeight.normal, color: Colors.white),
            ),
            SizedBox(
              height: Dimesion.height10,
            ),
            const CupertinoActivityIndicator(
              animating: true,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
