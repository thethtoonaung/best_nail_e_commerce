// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import '../products/product_detail_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  List<CartData>? data;

  CartModel({
    this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        data: json["data"] == null
            ? []
            : List<CartData>.from(
                json["data"]!.map((x) => CartData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CartData {
  int? id;
  int? userId;
  Product? product;
  ProductVariation? productVariation;
  int? quantity;
  int? unitPrice;
  bool? isWholesale;
  int? wholesaleUnitPrice;
  int? totalPrice;

  List<CartWholesales>? cartWholesales;

  CartData(
      {this.id,
        this.userId,
        this.product,
        this.productVariation,
        this.quantity,
        this.unitPrice,
        this.isWholesale,
        this.wholesaleUnitPrice,
        this.totalPrice,
        this.cartWholesales});

  CartData.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      userId = json['user_id'];
      product =
      json['product'] != null ? Product.fromJson(json['product']) : null;
      productVariation = json['product_variation'] != null
          ? ProductVariation.fromJson(json['product_variation'])
          : null;
      quantity = json['quantity'];
      unitPrice = toint(json['unit_price']);
      isWholesale = json['is_wholesale'];
      wholesaleUnitPrice = toint(json['wholesale_unit_price']);
      totalPrice = json['total_price'];

      if (json['cart_wholesales'] != null) {
        cartWholesales = <CartWholesales>[];
        json['cart_wholesales'].forEach((v) {
          cartWholesales!.add(CartWholesales.fromJson(v));
        });
      }
    } catch (e) {
      print(e);
    }
  }

  toint(dynamic aa) {
    if (aa is double) {
      return aa.round();
    } else {
      return aa;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (productVariation != null) {
      data['product_variation'] = productVariation!.toJson();
    }
    data['quantity'] = quantity;
    data['unit_price'] = unitPrice;
    data['is_wholesale'] = isWholesale;
    data['wholesale_unit_price'] = wholesaleUnitPrice;
    data['total_price'] = totalPrice;

    if (cartWholesales != null) {
      data['cart_wholesales'] = cartWholesales!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class CartWholesales {
  int? id;
  int? cartId;
  int? productVariationId;
  int? quantity;

  CartWholesales(
      {this.id, this.cartId, this.productVariationId, this.quantity});

  CartWholesales.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    productVariationId = json['product_variation_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_id'] = cartId;
    data['product_variation_id'] = productVariationId;
    data['quantity'] = quantity;
    return data;
  }
}