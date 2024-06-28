// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  List<PaymentData>? data;

  PaymentModel({
    this.data,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        data: json["data"] == null
            ? []
            : List<PaymentData>.from(
                json["data"]!.map((x) => PaymentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PaymentData {
  int? id;
  String? name;
  String? paymentName;
  String? account;
  String? logo;
  String? qr;
  DateTime? createdAt;
  DateTime? updatedAt;

  PaymentData({
    this.id,
    this.name,
    this.paymentName,
    this.account,
    this.logo,
    this.qr,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        id: json["id"],
        name: json["name"],
        paymentName: json["payment_name"],
        account: json["account"],
        logo: json["logo"],
        qr: json["QR"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "payment_name": paymentName,
        "account": account,
        "logo": logo,
        "QR": qr,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
