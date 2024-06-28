import 'dart:convert';

TownshipModel townshipModelFromJson(String str) =>
    TownshipModel.fromJson(json.decode(str));

String townshipModelToJson(TownshipModel data) => json.encode(data.toJson());

class TownshipModel {
  String? status;
  List<TownShipData>? data;

  TownshipModel({
    this.status,
    this.data,
  });

  factory TownshipModel.fromJson(Map<String, dynamic> json) => TownshipModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<TownShipData>.from(
                json["data"]!.map((x) => TownShipData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TownShipData {
  int? id;
  String? name;
  TownShipData? region;
  DateTime? createdAt;
  DateTime? updatedAt;

  TownShipData({
    this.id,
    this.name,
    this.region,
    this.createdAt,
    this.updatedAt,
  });

  factory TownShipData.fromJson(Map<String, dynamic> json) => TownShipData(
        id: json["id"],
        name: json["name"],
        region: json["region"] == null
            ? null
            : TownShipData.fromJson(json["region"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "region": region?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
