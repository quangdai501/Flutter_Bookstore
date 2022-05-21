// To parse this JSON data, do
//
//     final publisher = publisherFromJson(jsonString);

import 'dart:convert';

List<Publisher> publisherFromJson(var rawData) =>
    List<Publisher>.from(rawData.map((x) => Publisher.fromJson(x)));

String publisherToJson(List<Publisher> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Publisher {
  Publisher({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory Publisher.fromJson(Map<String, dynamic> json) => Publisher(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
