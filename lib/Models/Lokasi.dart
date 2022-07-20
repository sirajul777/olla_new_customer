// To parse this JSON data, do
//
//     final getLokasi = getLokasiFromJson(jsonString);

import 'dart:convert';

// GetLokasi getLokasiFromJson(String str) => GetLokasi.getLoc(json.decode(str));

// String getLokasiToJson(GetLokasi data) => json.encode(data.toJson());

class GetLokasi {
  GetLokasi({
    this.ress,
  });

  List<Ress>? ress;

  factory GetLokasi.getLoc(List collection) {
    // print(collection);
    return GetLokasi(
      ress: List<Ress>.from(collection.map((key) => Ress.fromJson(key))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(ress!.map((x) => x.toJson())),
      };
}

class Ress {
  Ress({
    this.id,
    this.userId,
    this.title,
    this.customerName,
    this.address,
    this.addressNote,
    this.longitude,
    this.latitude,
    this.mobilePhone,
  });

  int? id;
  int? userId;
  String? title;
  String? customerName;
  String? address;
  String? addressNote;
  String? longitude;
  String? latitude;
  String? mobilePhone;

  factory Ress.fromJson(Map<String, dynamic> json) => Ress(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        customerName: json["customer_name"],
        address: json["address"],
        addressNote: json["address_note"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        mobilePhone: json["mobile_phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "customer_name": customerName,
        "address": address,
        "address_note": addressNote,
        "longitude": longitude,
        "latitude": latitude,
        "mobile_phone": mobilePhone,
      };
}

// Lokasi authFromJson(String str) => Lokasi.post(json.decode(str));
// String authToJson(Lokasi data) => json.encode(data.toJson());

class Lokasi {
  Lokasi({
    this.code,
    this.message,
    // this.data,
  });

  int? code;
  String? message;
  // List? data;

  factory Lokasi.post(Map<String, dynamic> json) => Lokasi(
        code: json["code"],
        message: json["message"],
        // data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        // "data": data!,
      };
}

// class DataLokasi {
//   DataLokasi({
//     this.data,
//   });

//   String? data;

//   factory DataLokasi.fromJson(Map<String, dynamic> json) => DataLokasi(
//         data: json["data"],
//       );

//   Map<String, dynamic> toJson() => {
//         "secret_code": data,
//       };
// }
