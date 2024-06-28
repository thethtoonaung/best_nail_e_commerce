import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/dimesions.dart';

class ItemsWidget extends StatelessWidget {
  final String val;
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const ItemsWidget(
      {super.key,
      required this.val,
      required this.title,
      required this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: Dimesion.width10, vertical: Dimesion.width5),
        child: Container(
          padding: EdgeInsets.all(Dimesion.height10),
          child: Row(
            children: [
              Icon(
                icon,
                color: AppColor.primaryClr,
                size: Dimesion.iconSize32,
              ),
              SizedBox(
                width: Dimesion.width10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColor.primaryClr,
                          fontWeight: FontWeight.bold)),
                  Text(
                    val,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor.primaryClr,
                size: Dimesion.iconSize16,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageItemWidget extends StatelessWidget {
  final String val;
  final String title;
  final IconData icon;
  final bool isSwitch;
  final Function(bool) onChanged;
  const LanguageItemWidget(
      {super.key,
      required this.val,
      required this.title,
      required this.icon,
      required this.isSwitch,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: Dimesion.width10, vertical: Dimesion.width5),
      child: Container(
        padding: EdgeInsets.all(Dimesion.height10),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColor.primaryClr,
              size: Dimesion.iconSize32,
            ),
            SizedBox(
              width: Dimesion.width10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColor.primaryClr,
                        fontWeight: FontWeight.bold)),
                Text(
                  val,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.green),
                )
              ],
            ),
            const Spacer(),
            Switch.adaptive(
              value: isSwitch,
              onChanged: onChanged,
            )
          ],
        ),
      ),
    );
  }
}
