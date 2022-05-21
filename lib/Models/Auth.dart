// To parse this JSON data, do
//
//     final auth = authFromJson(jsonString);

import 'dart:convert';

Auth authFromJson(String str) => Auth.login(json.decode(str));

String authToJson(Auth data) => json.encode(data.toJson());

class Auth {
  Auth({
    this.code,
    this.message,
    this.data,
  });

  int? code;
  String? message;
  Data? data;

  factory Auth.login(Map<String, dynamic> json) => Auth(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.secretCode,
  });

  String? secretCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        secretCode: json["secret_code"],
      );

  Map<String, dynamic> toJson() => {
        "secret_code": secretCode,
      };
}
