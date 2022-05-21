// To parse this JSON data, do
//
//     final servisList = servisListFromJson(jsonString);

import 'dart:convert';

ServisList servisListFromJson(String str) =>
    ServisList.fromJson(json.decode(str));

String servisListToJson(ServisList data) => json.encode(data.toJson());

class ServisList {
  ServisList({
    this.data,
  });

  List<Datum>? data;

  factory ServisList.fromJson(Map<String, dynamic> json) => ServisList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.status,
    this.images,
    this.description,
  });

  int? id;
  String? name;
  String? status;
  String? images;
  String? description;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        images: json["images"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "images": images,
        "description": description == null ? null : description,
      };
}
