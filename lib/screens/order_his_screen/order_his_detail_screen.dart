import 'package:best_nail/utils/extension/text_theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_widgets/row_text_widget.dart';
import '../../models/order/order_model.dart';
import '../../routes_helper/routes_helper.dart';
import '../../utils/app_color.dart';
import '../../utils/data_constant.dart';
import '../../utils/dimesions.dart';
import '../checkout_screen/checkout_widgets/selected_payment_widget.dart';
import '../product_detail_screen/product_detail_screen.dart';
import 'ordet_his_widgets/deliver_item_widget.dart';
import 'ordet_his_widgets/order_info_card_widget.dart';
import 'ordet_his_widgets/order_item_widget.dart';
import 'ordet_his_widgets/remark_widget.dart';
import 'ordet_his_widgets/transition_image_widget.dart';

class OrderHisDetailScreen extends StatelessWidget {
  final OrderData orderData;
  final Color orderColor;
  const OrderHisDetailScreen(
      {super.key, required this.orderData, required this.orderColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          leading: const BackButton(),
          title: Text("Order Detail".tr,
              style: context.titleSmall.copyWith(fontWeight: FontWeight.bold))),
      body: ListView(
        padding: EdgeInsets.all(Dimesion.width10),
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimesion.width5)),
            color: Colors.grey.shade100,
            surfaceTintColor: Colors.grey.shade100,
            child: OrderInfoCardWidget(
                orderData: orderData, orderColor: orderColor),
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          Text(
            "Order Items".tr,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: orderData.orderItems!.length,
              itemBuilder: (_, index) {
                return InkWell(
                    onTap: () => Get.toNamed(RouteHelper.productDetailScreen,
                        arguments: ProductDetailScreen(
                          id: orderData.orderItems![index].productId,
                        )),
                    child: OrderItemWidget(
                        orderItem: orderData.orderItems![index]));
              }),
          SizedBox(
            height: Dimesion.width5,
          ),
          Text(
            "Payment Type".tr,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          orderData.payment != null
              ? SelectPaymentWidget(paymentData: orderData.payment!)
              : Text(
                  "( Cash On Delivery )",
                  style: context.labelMedium.copyWith(
                      color: AppColor.primaryClr, fontWeight: FontWeight.bold),
                ),
          SizedBox(
            height: Dimesion.width5,
          ),
          Text(
            "Delivery".tr,
            style: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Dimesion.width5,
          ),
          DeliverytItemWidget(delivery: orderData.delivery!,),
          orderData.transactionImage != null
              ? OrderImageWidget(
                  title: "Transition Image", imgUrl: orderData.transactionImage)
              : const SizedBox.shrink(),
          orderData.cancellationRemark != null
              ? RemarkWidget(
                  title: "Cancellation Remark",
                  message: orderData.cancellationRemark,
                  isCancel: true)
              : const SizedBox.shrink(),
          orderData.refundRemark != null
              ? RemarkWidget(
              title: "Refund Remark",
              message: orderData.refundRemark,
              isCancel: true)
              : const SizedBox.shrink(),
          SizedBox(height: 10),
          orderData!.refundTransactionImage != null
              ? OrderImageWidget(
              title: "Refund  Image",
              imgUrl: orderData!.refundTransactionImage):Container(),
          SizedBox(height: 10),
          orderData.returnRemark != null
              ? RemarkWidget(
                  title: "Return Remark",
                  message: orderData.returnRemark,
                  isCancel: false)
              : const SizedBox.shrink(),
          orderData.returnTransactionImage != null
              ? OrderImageWidget(
                  title: "Return Transition Image",
                  imgUrl: orderData.returnTransactionImage)
              : const SizedBox.shrink(),
          const Divider(
            color: AppColor.primaryClr,
          ),
          RowTextWidget(title: "Name", val: orderData.name ?? ""),
          RowTextWidget(title: "Phone Number", val: orderData.phone ?? ""),
          RowTextWidget(
              title: "Address",
              val:
                  "${orderData.address}\n${orderData.township!.name}\n${orderData.township!.region!.region}"),
          const Divider(
            color: AppColor.primaryClr,
          ),
          RowTextWidget(
              title: "Sub Total",
              val: "${DataConstant.priceFormat.format(orderData.subTotal)} Ks"),
          RowTextWidget(
              title: "Delivery Fees",
              val:
                  "${DataConstant.priceFormat.format(orderData.deliveryFee)} Ks"),
          RowTextWidget(
              title: "Grand Total",
              val:
                  "${DataConstant.priceFormat.format(orderData.grandTotal)} Ks")
        ],
      ),
    );
  }
}
