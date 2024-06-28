// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  String? status;
  ProductDetailData? data;

  ProductDetailModel({
    this.status,
    this.data,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : ProductDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class ProductDetailData {
  Product? product;
  List<Variation>? variations;
  List<ProductVariation>? productVariation;
  bool? inCart;
  bool? isFavourite;
  List<ProductWholesales>? productWholesales;

  ProductDetailData({
    this.product,
    this.variations,
    this.isFavourite,
    this.productVariation,
  });

  ProductDetailData.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['variations'] != null) {
      variations = <Variation>[];
      json['variations'].forEach((v) {
        variations!.add(Variation.fromJson(v));
      });
    }
    if (json['product_variation'] != null) {
      productVariation = <ProductVariation>[];
      json['product_variation'].forEach((v) {
        productVariation!.add(ProductVariation.fromJson(v));
      });
    }
    inCart = json['in_cart'];
    isFavourite = json['is_favourite'];
    if (json['product_wholesales'] != null) {
      productWholesales = <ProductWholesales>[];
      json['product_wholesales'].forEach((v) {
        productWholesales!.add(ProductWholesales.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    if (productVariation != null) {
      data['product_variation'] =
          productWholesales!.map((v) => v.toJson()).toList();
    }

    data['in_cart'] = inCart;
    data['is_favourite'] = isFavourite;
    if (productWholesales != null) {
      data['product_wholesales'] =
          productWholesales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  Brand? brand;
  Category? category;
  String? name;
  String? description;
  List<String>? variants;
  int? defaultPrice;
  int? isWholesale;
  String? createdAt;
  String? updatedAt;
  List<ImageModel>? images;
  VoiceModel? voice;

  Product(
      {this.id,
        this.brand,
        this.category,
        this.name,
        this.description,
        this.variants,
        this.defaultPrice,
        this.isWholesale,
        this.createdAt,
        this.updatedAt,
        this.images,
        this.voice});
  List<String> getImageList() {
    return images?.map((e) => e.image ?? "").toList() ?? [];
  }
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    category =
    json['category'] != null ? Category.fromJson(json['category']) : null;
    name = json['name'];
    description = json['description'];
    variants = json['variants'].cast<String>();
    defaultPrice = json['default_price'];
    isWholesale = json['is_wholesale'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((v) {
        images!.add(ImageModel.fromJson(v));
      });
    }
    voice = json['voice'] != null ? VoiceModel.fromJson(json['voice']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['name'] = name;
    data['description'] = description;
    data['variants'] = variants;
    data['default_price'] = defaultPrice;
    data['is_wholesale'] = isWholesale;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (voice != null) {
      data['voice'] = voice!.toJson();
    }
    return data;
  }

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

class ProductVariation {
  int? id;
  int? productId;
  int? stockQuantity;
  int? originalPrice;
  int? sellPrice;
  List<String>? variations;
  List<dynamic>? wholesales;
  dynamic? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductVariation({
    this.id,
    this.productId,
    this.stockQuantity,
    this.originalPrice,
    this.sellPrice,
    this.createdAt,
    this.updatedAt,
    this.variations,
    this.wholesales,
    this.image
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      ProductVariation(
        id: json["id"],
        productId: json["product_id"],
        stockQuantity: json["stock_quantity"],
        originalPrice: json["original_price"],
        sellPrice: json["sell_price"],
        image: json["image"],
        variations: json["variations"] == null
            ? []
            : List<String>.from(json["variations"]!.map((x) => x)),
        wholesales: json["wholesales"] == null
            ? []
            : List<dynamic>.from(json["wholesales"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "stock_quantity": stockQuantity,
        "original_price": originalPrice,
        "sell_price": sellPrice,
    "image": image,
    "variations": variations == null
            ? []
            : List<String>.from(variations!.map((x) => x)),
    "wholesales": wholesales == null
        ? []
        : List<dynamic>.from(wholesales!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Variation {
  String? name;
  List<String>? values;

  Variation({
    this.name,
    this.values,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        name: json["name"],
        values: json["values"] == null
            ? []
            : List<String>.from(json["values"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "values":
            values == null ? [] : List<dynamic>.from(values!.map((x) => x)),
      };
}


class ProductWholesales {
  int? id;
  int? productId;
  int? quantity;
  int? price;
  bool? isCheck;

  ProductWholesales({
    this.id,
    this.productId,
    this.quantity,
    this.price,
    this.isCheck = false,
  });

  ProductWholesales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    return data;
  }
}
