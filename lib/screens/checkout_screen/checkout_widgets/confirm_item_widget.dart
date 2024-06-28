import 'package:best_nail/utils/extension/color_ext.dart';
import 'package:flutter/material.dart';

import '../../../app_widgets/my_cache_img.dart';
import '../../../utils/app_color.dart';
import '../../../utils/dimesions.dart';

class ConfirmItemWIdget extends StatelessWidget {
  final String imgUrl;
  final List<String> variables;
  final String unitPrice;
  final String quantity;
  const ConfirmItemWIdget(
      {super.key,
      required this.imgUrl,
      required this.variables,
      required this.unitPrice,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: Dimesion.width5,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          // Container(
          //   height: Dimesion.height40 * 2,
          //   width: Dimesion.height40 * 2,
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          //   child: Image.asset(
          //     "assets/pr_demo/p5.png",
          //     fit: BoxFit.contain,
          //   ),
          // ),
          MyCacheImg(
              height: Dimesion.height40 * 2,
              width: Dimesion.height40 * 2,
              url: imgUrl,
              boxfit: BoxFit.contain,
              borderRadius: BorderRadius.circular(Dimesion.radius15 / 2)),
          SizedBox(
            width: Dimesion.width10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Name",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: Dimesion.width5,
                ),
                Text("$unitPrice x $quantity",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColor.primaryClr)),
                SizedBox(
                  height: Dimesion.width5,
                ),
                Row(
                  children: [
                    ...List.generate(variables.length, (i) {
                      if (variables[i].toString().startsWith("#")) {
                        return CircleAvatar(
                          backgroundColor: variables[i].toColor(),
                          radius: Dimesion.radius15 * 0.5,
                        );
                      } else {
                        return Container(
                          margin: (i == 0)
                              ? EdgeInsets.only(right: Dimesion.width5)
                              : EdgeInsets.only(left: Dimesion.width5),
                          child: Text(variables[i].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: AppColor.primaryClr)),
                        );
                      }
                    }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
