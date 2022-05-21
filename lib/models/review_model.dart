// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(var rawdata) =>
    List<Review>.from(rawdata.map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    required this.id,
    required this.product,
    required this.user,
    required this.comment,
    required this.createdAt,
    required this.name,
    required this.rating,
    required this.updatedAt,
  });

  String id;
  String product;
  String user;
  String comment;
  DateTime createdAt;
  String name;
  int rating;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        product: json["product"],
        user: json["user"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        rating: json["rating"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product,
        "user": user,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "rating": rating,
        "updatedAt": updatedAt.toIso8601String(),
      };
}
