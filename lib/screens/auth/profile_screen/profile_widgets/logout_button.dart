import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/dimesions.dart';

class LogoutButton extends StatelessWidget {
  final void Function()? onTap;
  const LogoutButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: Dimesion.width5),
        padding: EdgeInsets.all(Dimesion.width5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
        child: Row(
          children: [
            Text(
              "Logout".tr,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              width: Dimesion.width5,
            ),
            Icon(
              Icons.logout_rounded,
              color: Colors.red,
              size: Dimesion.iconSize16,
            ),
          ],
        ),
      ),
    );
  }
}
