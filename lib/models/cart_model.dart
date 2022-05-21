// To parse this JSON data, do
//
//     final Cart = CartFromJson(jsonString);

import 'dart:convert';

import 'package:final_project/models/product_model.dart';

List<Cart> cartFromJson(String str) =>
    List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

String cartToJson(List<Cart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cart {
  Cart({
    required this.productId,
    required this.name,
    required this.price,
    required this.qty,
    required this.image,
  });

  String productId;
  String name;
  int price;
  int qty;
  String image;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        productId: json["productId"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        image: json["image"],
      );
  factory Cart.fromProduct(Product product, int qty) => Cart(
        productId: product.id,
        name: product.name,
        price: product.price,
        qty: qty,
        image: product.image,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "price": price,
        "qty": qty,
        "image": image,
      };
}
