// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  List<ProductData>? data;
  int? currentPage;
  int? lastPage;
  int? dataTotal;
  int? dataPerPage;
  int? dataFrom;
  int? dataTo;
  bool? canLoadMore;

  ProductModel({
    this.data,
    this.currentPage,
    this.lastPage,
    this.dataTotal,
    this.dataPerPage,
    this.dataFrom,
    this.dataTo,
    this.canLoadMore,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        data: json["data"] == null
            ? []
            : List<ProductData>.from(
                json["data"]!.map((x) => ProductData.fromJson(x))),
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

class ProductData {
  int? id;
  Brand? brand;
  Category? category;
  String? name;
  String? description;
  List<String>? variants;
  int? defaultPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ImageModel>? images;
  VoiceModel? voice;

  ProductData({
    this.id,
    this.brand,
    this.category,
    this.name,
    this.description,
    this.variants,
    this.defaultPrice,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.voice,
  });

  List<String> getImageList() {
    return images?.map((e) => e.image ?? "").toList() ?? [];
  }

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        name: json["name"],
        description: json["description"],
        variants: json["variants"] == null
            ? []
            : List<String>.from(json["variants"]!.map((x) => x)),
        defaultPrice: json["default_price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? []
            : List<ImageModel>.from(
                json["images"]!.map((x) => ImageModel.fromJson(x))),
        voice:
            json["voice"] == null ? null : VoiceModel.fromJson(json["voice"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand?.toJson(),
        "category": category?.toJson(),
        "name": name,
        "description": description,
        "variants":
            variants == null ? [] : List<String>.from(variants!.map((x) => x)),
        "default_price": defaultPrice,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "voice": voice,
      };
}

class Brand {
  int? id;
  String? name;
  String? image;

  Brand({
    this.id,
    this.name,
    this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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

class VoiceModel {
  int? id;
  String? voice;

  VoiceModel({
    this.id,
    this.voice,
  });

  factory VoiceModel.fromJson(Map<String, dynamic> json) => VoiceModel(
        id: json["id"],
        voice: json["voice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "voice": voice,
      };
}

class ImageModel {
  int? id;
  String? image;

  ImageModel({
    this.id,
    this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Category {
  int? id;
  dynamic parentId;
  String? name;
  String? icon;

  Category({
    this.id,
    this.parentId,
    this.name,
    this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        parentId: json["parent_id"],
        name: json["name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "name": name,
        "icon": icon,
      };
}
