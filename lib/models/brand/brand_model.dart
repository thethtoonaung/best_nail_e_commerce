// To parse this JSON data, do
//
//     final brandModel = brandModelFromJson(jsonString);

import 'dart:convert';

BrandModel brandModelFromJson(String str) =>
    BrandModel.fromJson(json.decode(str));

String brandModelToJson(BrandModel data) => json.encode(data.toJson());

class BrandModel {
  List<BrandData>? data;

  BrandModel({
    this.data,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        data: json["data"] == null
            ? []
            : List<BrandData>.from(
                json["data"]!.map((x) => BrandData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BrandData {
  int? id;
  String? name;
  String? image;

  BrandData({
    this.id,
    this.name,
    this.image,
  });

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
