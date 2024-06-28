// To parse this JSON data, do
//
//     final createOrderModel = createOrderModelFromJson(jsonString);

import 'dart:convert';

import 'order_model.dart';


CreateOrderModel createOrderModelFromJson(String str) =>
    CreateOrderModel.fromJson(json.decode(str));

String createOrderModelToJson(CreateOrderModel data) =>
    json.encode(data.toJson());

class CreateOrderModel {
  String? status;
  String? message;
  OrderData? order;

  CreateOrderModel({
    this.status,
    this.message,
    this.order,
  });

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderModel(
        status: json["status"],
        message: json["message"],
        order: json["order"] == null ? null : OrderData.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "order": order?.toJson(),
      };
}
