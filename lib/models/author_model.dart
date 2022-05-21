// To parse this JSON data, do
//
//     final author = authorFromJson(jsonString);

import 'dart:convert';

List<Author> authorFromJson(var rawData) =>
    List<Author>.from(rawData.map((x) => Author.fromJson(x)));

String authorToJson(List<Author> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Author {
  Author({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
