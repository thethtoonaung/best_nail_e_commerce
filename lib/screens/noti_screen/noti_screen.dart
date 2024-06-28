import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_widgets/back_button.dart';
import '../../app_widgets/custom_loading_widget.dart';
import '../../app_widgets/empty_view_widget.dart';
import '../../utils/app_color.dart';
import '../../utils/dimesions.dart';

import 'noti_logic/noti_controller.dart';
import 'noti_widgets/noti_card_widget.dart';

class NotiScreen extends GetView<NotiController> {
  const NotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          primary: true,
          leading: backButton(color: Colors.white),
          scrolledUnderElevation: 0,
          centerTitle: false,
          title: Text(
            "Notifications",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.white),
          ),
          backgroundColor: AppColor.primaryClr,
        ),
        body: Obx(
          () {
            if (controller.notiList.isEmpty) {
              return const EmptyViewWidget();
            } else if (controller.isLoading.value) {
              return const Center(
                child: CustomLoadingWidget(),
              );
            } else {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: Dimesion.width10),
                  itemCount: controller.notiList.length,
                  itemBuilder: (_, index) => InkWell(
                      onTap: () => controller.getNotiDetail(
                          id: controller.notiList[index].id!),
                      child: NotiCard(notiData: controller.notiList[index])));
            }
          },
        ));
  }
}
