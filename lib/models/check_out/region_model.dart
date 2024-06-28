import 'dart:convert';

RegionModel regionModelFromJson(String str) =>
    RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  List<RegionData>? data;

  RegionModel({
    this.data,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
        data: json["data"] == null
            ? []
            : List<RegionData>.from(
                json["data"]!.map((x) => RegionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RegionData {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  RegionData({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory RegionData.fromJson(Map<String, dynamic> json) => RegionData(
        id: json["id"],
        name: json["name"],
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
