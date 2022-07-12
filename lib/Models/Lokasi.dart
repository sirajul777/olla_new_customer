// To parse this JSON data, do
//
//     final lokasi = lokasiFromJson(jsonString);

import 'dart:convert';

Lokasi lokasiFromJson(String str) => Lokasi.post(json.decode(str));

String lokasiToJson(Lokasi data) => json.encode(data.toJson());

class Lokasi {
  Lokasi({
    this.title,
    this.customerName,
    this.address,
    this.longitude,
    this.latitude,
    this.mobilePhone,
    this.addressNote,
  });

  String? title;
  String? customerName;
  String? address;
  String? longitude;
  String? latitude;
  String? mobilePhone;
  String? addressNote;

  factory Lokasi.post(Map<String, dynamic> json) => Lokasi(
        title: json["title"],
        customerName: json["customer_name"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        mobilePhone: json["mobile_phone"],
        addressNote: json["address_note"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "customer_name": customerName,
        "address": address,
        "longitude": longitude,
        "latitude": latitude,
        "mobile_phone": mobilePhone,
        "address_note": addressNote,
      };
}
