// To parse this JSON data, do
//
//     final searchDeliveryModel = searchDeliveryModelFromJson(jsonString);

import 'dart:convert';

SearchDeliveryModel searchDeliveryModelFromJson(String str) =>
    SearchDeliveryModel.fromJson(json.decode(str));

String searchDeliveryModelToJson(SearchDeliveryModel data) =>
    json.encode(data.toJson());

class SearchDeliveryModel {
  String? status;
  SearchDeliveryData? data;

  SearchDeliveryModel({
    this.status,
    this.data,
  });

  factory SearchDeliveryModel.fromJson(Map<String, dynamic> json) =>
      SearchDeliveryModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : SearchDeliveryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class SearchDeliveryData {
  int? id;
  Delivery? region;
  Delivery? township;
  Delivery? delivery;
  int? fees;
  String? cod;
  int? duration;
  String? remark;
  DateTime? createdAt;
  DateTime? updatedAt;

  SearchDeliveryData({
    this.id,
    this.region,
    this.township,
    this.delivery,
    this.fees,
    this.cod,
    this.duration,
    this.remark,
    this.createdAt,
    this.updatedAt,
  });

  factory SearchDeliveryData.fromJson(Map<String, dynamic> json) =>
      SearchDeliveryData(
        id: json["id"],
        region:
            json["region"] == null ? null : Delivery.fromJson(json["region"]),
        township: json["township"] == null
            ? null
            : Delivery.fromJson(json["township"]),
        delivery: json["delivery"] == null
            ? null
            : Delivery.fromJson(json["delivery"]),
        fees: json["fees"],
        cod: json["COD"],
        duration: json["duration"],
        remark: json["remark"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "region": region?.toJson(),
        "township": township?.toJson(),
        "delivery": delivery?.toJson(),
        "fees": fees,
        "COD": cod,
        "duration": duration,
        "remark": remark,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Delivery {
  int? id;
  String? name;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? regionId;

  Delivery({
    this.id,
    this.name,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.regionId,
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
        regionId: json["region_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "region_id": regionId,
      };
}
