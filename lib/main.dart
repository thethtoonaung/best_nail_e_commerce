import 'dart:io';

import 'package:best_nail/routes_helper/routes_helper.dart';
import 'package:best_nail/utils/app_color.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'appbinding/app_binding.dart';
import 'appbinding/initial_binding.dart';
import 'firebase_options.dart';
import 'language/language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } else {
    Firebase.initializeApp();
  }
  await Future.delayed(const Duration(milliseconds: 300));
  await InitailBinding().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: AppBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primaryClr),
        useMaterial3: true,
      ),
      initialRoute: RouteHelper.initial,
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      getPages: RouteHelper.routes,
      translations: LocalString(),
      locale: const Locale('en', 'US'),
    );
  }
}



