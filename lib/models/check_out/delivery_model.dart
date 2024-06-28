// To parse this JSON data, do
//
//     final deliveryModel = deliveryModelFromJson(jsonString);

import 'dart:convert';

DeliveryModel deliveryModelFromJson(String str) =>
    DeliveryModel.fromJson(json.decode(str));

String deliveryModelToJson(DeliveryModel data) => json.encode(data.toJson());

class DeliveryModel {
  String? status;
  List<DeliveryData>? data;

  DeliveryModel({
    this.status,
    this.data,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) => DeliveryModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DeliveryData>.from(
                json["data"]!.map((x) => DeliveryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DeliveryData {
  int? id;
  String? name;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;

  DeliveryData({
    this.id,
    this.name,
    this.logo,
    this.createdAt,
    this.updatedAt,
  });

  factory DeliveryData.fromJson(Map<String, dynamic> json) => DeliveryData(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
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
        "logo": logo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
