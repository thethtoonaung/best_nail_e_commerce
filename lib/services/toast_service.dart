import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../utils/dimesions.dart';

class ToastService {
  static void errorToast(String message) => BotToast.showCustomText(
        toastBuilder: (cancelFunc) => Card(
          color: Colors.red,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ),
        duration: const Duration(seconds: 2),
        clickClose: true,
        onlyOne: true,
        align: const Alignment(0, 0.8),
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backButtonBehavior: BackButtonBehavior.none,
      );
  static void successToast(String message) => BotToast.showCustomText(
        toastBuilder: (cancelFunc) => Card(
          color: Colors.green,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: Dimesion.screeWidth * 0.8,
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )),
        ),
        duration: const Duration(seconds: 2),
        clickClose: true,
        onlyOne: true,
        align: const Alignment(0, 0.8),
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backButtonBehavior: BackButtonBehavior.none,
      );

  static void warningToast(String message) => BotToast.showCustomText(
        toastBuilder: (cancelFunc) => Card(
          color: Colors.amber,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ),
        duration: const Duration(seconds: 2),
        clickClose: true,
        onlyOne: true,
        align: const Alignment(0, 0.8),
        animationDuration: const Duration(milliseconds: 200),
        animationReverseDuration: const Duration(milliseconds: 200),
        backButtonBehavior: BackButtonBehavior.none,
      );
}
