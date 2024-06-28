import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  List<BannerData>? data;

  BannerModel({
    this.data,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        data: json["data"] == null
            ? []
            : List<BannerData>.from(
                json["data"]!.map((x) => BannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BannerData {
  int? id;
  String? name;
  String? image;
  int? productId;
  DateTime? createdAt;
  DateTime? updatedAt;

  BannerData({
    this.id,
    this.name,
    this.image,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        productId: json["product_id"],
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
        "image": image,
        "product_id": productId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
