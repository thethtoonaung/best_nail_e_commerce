import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_widgets/main_button.dart';
import '../../../utils/dimesions.dart';
import '../search_logic/search_controller.dart';

class FilterBottomSheet extends GetView<MySearchController> {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (_) => Container(
              padding: EdgeInsets.all(Dimesion.width10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: Dimesion.height10,
                  ),
                  Text(
                    "Filter Price".tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: Dimesion.height10,
                  ),
                  Obx(
                    () => RangeSlider(
                        max: 50,
                        min: 0,
                        divisions: 50,
                        values: RangeValues(controller.fromPrice.value,
                            controller.toPrice.value),
                        labels: RangeLabels(
                          "${double.parse(controller.fromPrice.value.toString()).toInt()}K",
                          "${double.parse(controller.toPrice.value.toString()).toInt()}K",
                        ),
                        onChanged: (val) {
                          controller.onChangeSlider(val);
                        }),
                  ),
                  Row(
                    children: [
                      Text(
                        "Min Price".tr,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      const Spacer(),
                      Text(
                        "Max Price".tr,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimesion.height10,
                  ),
                  mainButton(
                      title: Text(
                        "Filter".tr,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      onTap: () {
                        controller.page.value = 1;
                        controller.results.clear();
                        controller.getSearchProducts(
                            isLoadMore: false,
                            from:
                                (controller.fromPrice.value * 1000).toString(),
                            to: (controller.toPrice.value * 1000).toString());
                        Get.back();
                      },
                      borderRadius: Dimesion.radius15,
                      width: Dimesion.screeWidth),
                  SizedBox(
                    height: Dimesion.height10,
                  ),
                ],
              ),
            ));
  }
}
