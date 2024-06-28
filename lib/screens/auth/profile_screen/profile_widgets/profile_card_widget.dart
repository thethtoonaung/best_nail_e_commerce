import 'package:circular_image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_widgets/custom_loading_widget.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/dimesions.dart';
import '../../auth_logic/auth_controller.dart';

class ProfileCardWidget extends GetView<AuthController> {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.userData.value.email == null) {
        return SizedBox(
          height: Dimesion.screenHeight * 0.2,
          child: const Center(child: CustomLoadingWidget()),
        );
      } else {
        return Center(
          child: Container(
            padding: EdgeInsets.all(Dimesion.width10),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: controller.userData.value.profilePicture != null
                          ? Obx(() => controller.userData.value.profilePicture == ""
                          ? Center(
                        child: CircularImage(radius:60,borderWidth:2,borderColor:Colors.white, source: controller.userData.value.profilePicture.toString(),),
                      )
                          : Center(
                        child: CircularImage(radius:60,borderWidth:2,borderColor:Colors.white, source: controller.userData.value.profilePicture.toString(),),
                      )
                      )
                          : Center(
                        child: CircularImage(source: 'assets/default_profile.png',radius: 60,),
                      ),
                    )),
                SizedBox(
                  width: Dimesion.width10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(controller.userData.value.name ?? "",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColor.primaryClr,
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                              !controller.isObscure.value
                                  ? controller.userData.value.email ?? ""
                                  : " ${controller.userData.value.email!.replaceRange(0, controller.userData.value.email!.length - 3, '*********')}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                        SizedBox(
                          width: Dimesion.width5,
                        ),
                        InkWell(
                            onTap: () {
                              controller.isObscure.value =
                                  !controller.isObscure.value;
                            },
                            child: Icon(
                                controller.isObscure.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: controller.isObscure.value
                                    ? AppColor.primaryClr
                                    : Colors.grey,
                                size: Dimesion.iconSize16))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
