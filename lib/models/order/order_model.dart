// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import '../check_out/payment_model.dart';


OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  List<OrderData>? data;
  int? currentPage;
  int? lastPage;
  int? dataTotal;
  int? dataPerPage;
  int? dataFrom;
  int? dataTo;
  bool? canLoadMore;

  OrderModel({
    this.data,
    this.currentPage,
    this.lastPage,
    this.dataTotal,
    this.dataPerPage,
    this.dataFrom,
    this.dataTo,
    this.canLoadMore,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        data: json["data"] == null
            ? []
            : List<OrderData>.from(
                json["data"]!.map((x) => OrderData.fromJson(x))),
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        dataTotal: json["data_total"],
        dataPerPage: json["data_per_page"],
        dataFrom: json["data_from"],
        dataTo: json["data_to"],
        canLoadMore: json["can_load_more"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "current_page": currentPage,
        "last_page": lastPage,
        "data_total": dataTotal,
        "data_per_page": dataPerPage,
        "data_from": dataFrom,
        "data_to": dataTo,
        "can_load_more": canLoadMore,
      };
}

class OrderData {
  int? id;
  String? orderNo;
  int? userId;
  int? deliveryServiceId;
  PaymentData? payment;
  Delivery? delivery;
  Delivery? township;
  String? name;
  String? phone;
  String? address;
  dynamic transactionImage;
  int? deliveryFee;
  dynamic cod;
  int? subTotal;
  int? grandTotal;
  DateTime? orderDate;
  String? orderStatus;
  dynamic cancellationRemark;
  dynamic returnRemark;
  dynamic returnTransactionImage;
  dynamic? refundRemark;
  dynamic? refundTransactionImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<OrderItem>? orderItems;

  OrderData({
    this.id,
    this.orderNo,
    this.userId,
    this.deliveryServiceId,
    this.payment,
    this.delivery,
    this.township,
    this.name,
    this.phone,
    this.address,
    this.transactionImage,
    this.deliveryFee,
    this.cod,
    this.subTotal,
    this.grandTotal,
    this.orderDate,
    this.orderStatus,
    this.cancellationRemark,
    this.returnRemark,
    this.returnTransactionImage,
    this.refundRemark,
    this.refundTransactionImage,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["id"],
        orderNo: json["order_no"],
        userId: json["user_id"],
        deliveryServiceId: json["delivery_service_id"],
        payment: json["payment"] == null
            ? null
            : PaymentData.fromJson(json["payment"]),
        delivery: json["delivery"] == null
            ? null
            : Delivery.fromJson(json["delivery"]),
        township: json["township"] == null
            ? null
            : Delivery.fromJson(json["township"]),
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        transactionImage: json["transaction_image"],
        deliveryFee: json["delivery_fee"],
        cod: json["COD"].toString(),
        subTotal: json["sub_total"],
        grandTotal: json["grand_total"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        orderStatus: json["order_status"],
        cancellationRemark: json["cancellation_remark"],
        returnRemark: json["return_remark"],
        returnTransactionImage: json["return_transaction_image"],
    refundRemark: json["refund_remark"],
    refundTransactionImage: json["refund_transaction_image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        orderItems: json["order_items"] == null
            ? []
            : List<OrderItem>.from(
                json["order_items"]!.map((x) => OrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_no": orderNo,
        "user_id": userId,
        "delivery_service_id": deliveryServiceId,
        "payment": payment?.toJson(),
        "delivery": delivery?.toJson(),
        "township": township?.toJson(),
        "name": name,
        "phone": phone,
        "address": address,
        "transaction_image": transactionImage,
        "delivery_fee": deliveryFee,
        "COD": cod,
        "sub_total": subTotal,
        "grand_total": grandTotal,
        "order_date": orderDate?.toIso8601String(),
        "order_status": orderStatus,
        "cancellation_remark": cancellationRemark,
        "return_remark": returnRemark,
        "return_transaction_image": returnTransactionImage,
    "refund_remark": refundRemark,
    "refund_transaction_image": refundTransactionImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "order_items": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
      };
}

class Delivery {
  int? id;
  String? name;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;
  Delivery? region;

  Delivery({
    this.id,
    this.name,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.region,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        region:
            json["region"] == null ? null : Delivery.fromJson(json["region"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "region": region?.toJson(),
      };
}

class OrderItem {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  String? productImage;
  int? productVariationId;
  List<String>? productVariations;
  int? quantity;
  int? unitPrice;
  int? totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderItem({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.productImage,
    this.productVariationId,
    this.productVariations,
    this.quantity,
    this.unitPrice,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productImage: json["product_image"],
        productVariationId: json["product_variation_id"],
        productVariations: json["product_variations"] == null
            ? []
            : List<String>.from(json["product_variations"]!.map((x) => x)),
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        totalPrice: json["total_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "product_image": productImage,
        "product_variation_id": productVariationId,
        "product_variations": productVariations == null
            ? []
            : List<dynamic>.from(productVariations!.map((x) => x)),
        "quantity": quantity,
        "unit_price": unitPrice,
        "total_price": totalPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
