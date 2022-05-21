// To parse this JSON data, do
//
//     final paymentMethos = paymentMethosFromJson(jsonString);

import 'dart:convert';

PaymentMethos paymentMethosFromJson(String str) =>
    PaymentMethos.fromJson(json.decode(str));

String paymentMethosToJson(PaymentMethos data) => json.encode(data.toJson());

class PaymentMethos {
  PaymentMethos({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  List<Datum>? data;

  factory PaymentMethos.fromJson(Map<String, dynamic> json) => PaymentMethos(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.image,
  });

  int? id;
  String? name;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
