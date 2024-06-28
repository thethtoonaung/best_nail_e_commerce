import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/noti_screen/noti_logic/noti_controller.dart';
import '../utils/app_config.dart';
import '../utils/data_constant.dart';
import '../utils/dimesions.dart';

Future<void> notiInit() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var status = await messaging.requestPermission(
      alert: true, sound: true, badge: true, provisional: false);
  debugPrint("this is calling--------->");
  debugPrint("Status is $status");

  if (status.authorizationStatus == AuthorizationStatus.authorized) {
    messaging.getInitialMessage();
    messaging.getToken().then((value) {print("FCM ========> $value");
      saveFcmToken(value!);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final NotiController notiController = Get.find<NotiController>();
      notiController.getNotiList();
      RemoteNotification? notification = message.notification;
      BotToast.showNotification(
          backgroundColor: Colors.white,
          leading: (_) => Image.asset(
                AppConfig.appLogo,
                height: Dimesion.height40,
                width: Dimesion.height40,
              ),
          duration: const Duration(seconds: 2),
          title: (_) => Text(notification!.title!),
          subtitle: (_) => Text(notification!.body!));
    });
  }
}

saveFcmToken(String token) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  debugPrint("fcmToken is $token");
  await sharedPreferences.setString(DataConstant.fcmToken, token);
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}
