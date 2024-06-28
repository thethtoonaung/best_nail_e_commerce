import 'package:flutter/material.dart';

import '../../../models/noti/noti_model.dart';
import '../../../utils/data_constant.dart';
import '../../../utils/dimesions.dart';

class NotiCard extends StatelessWidget {
  final NotiData notiData;
  const NotiCard({super.key, required this.notiData});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Dimesion.width5),
        padding: EdgeInsets.all(Dimesion.width5),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(Dimesion.width5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Dimesion.screeWidth * 0.65,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notiData.title ?? "",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      notiData.body ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                notiData.read == 0
                    ? Icon(Icons.circle,
                        color: Colors.green, size: Dimesion.radius15 / 2)
                    : const SizedBox(),
                SizedBox(
                  height: Dimesion.height20,
                ),
                Text(DataConstant.dateFormat.format(notiData.updatedAt!),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 10, color: Colors.grey))
              ],
            )
          ],
        ));
  }
}
