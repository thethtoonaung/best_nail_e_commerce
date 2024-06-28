// To parse this JSON data, do
//
//     final notiModel = notiModelFromJson(jsonString);

import 'dart:convert';

NotiModel notiModelFromJson(String str) => NotiModel.fromJson(json.decode(str));

String notiModelToJson(NotiModel data) => json.encode(data.toJson());

class NotiModel {
  List<NotiData>? data;

  NotiModel({
    this.data,
  });

  factory NotiModel.fromJson(Map<String, dynamic> json) => NotiModel(
        data: json["data"] == null
            ? []
            : List<NotiData>.from(
                json["data"]!.map((x) => NotiData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotiData {
  int? id;
  String? title;
  String? body;
  int? read;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotiData({
    this.id,
    this.title,
    this.body,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  factory NotiData.fromJson(Map<String, dynamic> json) => NotiData(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        read: json["read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "read": read,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
