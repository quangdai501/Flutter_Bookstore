// To parse this JSON data, do
//
//     final query = queryFromJson(jsonString);

import 'dart:convert';

String queryToJson(Query data) => json.encode(data.toJson());

class Query {
  Query({
    required this.page,
    this.size,
    this.search,
    this.authors,
    this.categories,
    this.publishers,
    this.sort,
    this.from,
    this.to,
  });

  int page;
  int? size = 12;
  String? search;
  String? authors;
  String? categories;
  String? publishers;
  String? sort;
  double? from;
  double? to;

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "size": size,
      "search": search,
      "authors": authors,
      "categories": categories,
      "publishers": publishers,
      "sort": sort,
      "from": from,
      "to": to
    };
  }
}
