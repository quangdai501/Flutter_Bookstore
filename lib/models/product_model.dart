// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

import 'package:final_project/models/category_model.dart';
import 'package:final_project/models/publisher_model.dart';
import 'package:final_project/models/review_model.dart';

import 'author_model.dart';

List<Product> productFromJson(var rawData) =>
    List<Product>.from(rawData.map((x) => Product.fromJson(x)));
// List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.authorId,
    required this.publisherId,
    required this.description,
    required this.price,
    required this.quantity,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
    required this.publisher,
    required this.author,
    required this.reviews,
  });

  String id;
  String name;
  String categoryId;
  String authorId;
  String publisherId;
  String description;
  int price;
  int quantity;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  Category category;
  Publisher publisher;
  Author author;
  List<Review> reviews = <Review>[];

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["_id"],
      name: json["name"],
      categoryId: json["category"],
      authorId: json["author"],
      publisherId: json["publisherId"],
      description: json["description"],
      price: json["price"],
      quantity: json["quantity"],
      image: json["image"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      category: Category.fromJson(json["categorys"]),
      publisher: Publisher.fromJson(json["publisher"]),
      author: Author.fromJson(json["authors"]),
      reviews: json["reviews"] == null
          ? <Review>[]
          : reviewFromJson(json["reviews"]));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category": categoryId,
        "author": authorId,
        "publisherId": publisherId,
        "description": description,
        "price": price,
        "quantity": quantity,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "categorys": category.toJson(),
        "publisher": publisher.toJson(),
        "authors": author.toJson(),
        "reviews": reviewToJson(reviews)
      };
}
