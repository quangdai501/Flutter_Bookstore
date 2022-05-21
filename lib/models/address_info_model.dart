// To parse this JSON data, do
//
//     final addressInfo = addressInfoFromJson(jsonString);

import 'dart:convert';

List<AddressInfo> addressInfoFromJson(var rawData) =>
    List<AddressInfo>.from(rawData.map((x) => AddressInfo.fromJson(x)));

String addressInfoToJson(List<AddressInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressInfo {
  AddressInfo({
    required this.province,
    required this.district,
    required this.ward,
    this.id,
    this.name = "",
    this.phone = "",
    this.address = "",
    this.userId = "",
  });

  District province;
  District district;
  Ward ward;
  String? id;
  String name;
  String phone;
  String address;
  String userId;

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        province: District.fromJson(json["province"]),
        district: District.fromJson(json["district"]),
        ward: Ward.fromJson(json["ward"]),
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "province": province.toJson(),
        "district": district.toJson(),
        "ward": ward.toJson(),
        "_id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "userId": userId,
      };
  toAddresString() {
    return "$address, ${ward.name}, ${district.name}, ${province.name}";
  }
}

class District {
  District({
    this.name = "",
    this.id = 0,
  });

  String name;
  int id;

  factory District.fromJson(Map<String, dynamic> json) => District(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class Ward {
  Ward({
    this.name = "",
    this.id = "",
  });

  String name;
  String id;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
