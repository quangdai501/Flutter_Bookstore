// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'cart_model.dart';

List<Order> orderFromJson(var rawdata) =>
    List<Order>.from(rawdata.map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  Order({
    required this.address,
    this.deliveryStatus,
    this.payment = 'Thanh toán khi nhận hàng',
    this.id,
    required this.billDetail,
    this.userId,
    required this.name,
    required this.total,
    required this.phone,
    this.createdAt,
    this.updatedAt,
    this.orderCode,
    this.paidAt,
  });

  Address address;
  String? deliveryStatus;
  String? payment;
  String? id;
  List<BillDetail> billDetail;
  String? userId;
  String name;
  int total;
  String phone;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? orderCode;
  DateTime? paidAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        address: Address.fromJson(json["address"]),
        deliveryStatus: json["deliveryStatus"],
        payment: json["payment"],
        id: json["_id"],
        billDetail: List<BillDetail>.from(
            json["billDetail"].map((x) => BillDetail.fromJson(x))),
        userId: json["user_id"],
        name: json["name"],
        total: json["total"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        orderCode: json["orderCode"],
        paidAt: json["paidAt"] == null ? null : DateTime.parse(json["paidAt"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "deliveryStatus": deliveryStatus,
        "payment": payment,
        "_id": id,
        "billDetail": List<dynamic>.from(billDetail.map((x) => x.toJson())),
        "user_id": userId,
        "name": name,
        "total": total,
        "phone": phone,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "orderCode": orderCode,
        "paidAt": paidAt == null ? null : paidAt!.toIso8601String(),
      };
}

class Address {
  Address({
    required this.toWardCode,
    required this.toDistrictId,
    required this.province,
    required this.district,
    required this.ward,
    required this.detail,
  });

  String toWardCode;
  String toDistrictId;
  String province;
  String district;
  String ward;
  String detail;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        toWardCode: json["to_ward_code"],
        toDistrictId: json["to_district_id"],
        province: json["province"],
        district: json["district"],
        ward: json["ward"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "to_ward_code": toWardCode,
        "to_district_id": toDistrictId,
        "province": province,
        "district": district,
        "ward": ward,
        "detail": detail,
      };
  @override
  String toString() {
    return '$detail $ward $district $province';
  }
}

List<BillDetail> billDetailFromCart(List<Cart> carts) =>
    carts.map((e) => BillDetail.fromCart(e)).toList();

class BillDetail {
  BillDetail({
    this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
  });

  String? id;
  String productId;
  String name;
  String image;
  int price;
  int qty;

  factory BillDetail.fromJson(Map<String, dynamic> json) => BillDetail(
        id: json["_id"],
        productId: json["productId"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        qty: json["qty"],
      );

  factory BillDetail.fromCart(Cart cart) => BillDetail(
        productId: cart.productId,
        name: cart.name,
        image: cart.image,
        price: cart.price,
        qty: cart.qty,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "image": image,
        "price": price,
        "qty": qty,
      };
}
