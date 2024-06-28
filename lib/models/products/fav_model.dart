import 'dart:convert';
import 'product_model.dart';

FavModel favModelFromJson(String str) => FavModel.fromJson(json.decode(str));

String favModelToJson(FavModel data) => json.encode(data.toJson());

class FavModel {
  List<FavData>? data;

  FavModel({
    this.data,
  });

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
        data: json["data"] == null
            ? []
            : List<FavData>.from(json["data"]!.map((x) => FavData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FavData {
  int? id;
  ProductData? product;
  DateTime? createdAt;
  DateTime? updatedAt;

  FavData({
    this.id,
    this.product,
    this.createdAt,
    this.updatedAt,
  });

  factory FavData.fromJson(Map<String, dynamic> json) => FavData(
        id: json["id"],
        product: json["product"] == null
            ? null
            : ProductData.fromJson(json["product"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
