// To parse this JSON data, do
//
//     final productVariationsSearchModel = productVariationsSearchModelFromJson(jsonString);

import 'dart:convert';

import 'product_detail_model.dart';

ProductVariationsSearchModel productVariationsSearchModelFromJson(String str) =>
    ProductVariationsSearchModel.fromJson(json.decode(str));

String productVariationsSearchModelToJson(ProductVariationsSearchModel data) =>
    json.encode(data.toJson());

class ProductVariationsSearchModel {
  String? status;
  ProductVariationSearch? data;

  ProductVariationsSearchModel({
    this.status,
    this.data,
  });

  factory ProductVariationsSearchModel.fromJson(Map<String, dynamic> json) =>
      ProductVariationsSearchModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : ProductVariationSearch.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class ProductVariationSearch {
  List<Variation>? variations;
  ProductVariation? productVariation;

  ProductVariationSearch({
    this.variations,
    this.productVariation,
  });

  factory ProductVariationSearch.fromJson(Map<String, dynamic> json) =>
      ProductVariationSearch(
        variations: json["variations"] == null
            ? []
            : List<Variation>.from(
                json["variations"]!.map((x) => Variation.fromJson(x))),
        productVariation: json["product_variation"] == null
            ? null
            : ProductVariation.fromJson(json["product_variation"]),
      );

  Map<String, dynamic> toJson() => {
        "variations": variations == null
            ? []
            : List<dynamic>.from(variations!.map((x) => x.toJson())),
        "product_variation": productVariation?.toJson(),
      };
}
