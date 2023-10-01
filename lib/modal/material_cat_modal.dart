import 'dart:convert';

List<MaterialCatModel> materialCatModelFromJson(String str) =>
    List<MaterialCatModel>.from(
        json.decode(str).map((x) => MaterialCatModel.fromJson(x)));

String materialCatModelToJson(List<MaterialCatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialCatModel {
  MaterialCatModel({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datum> data;

  factory MaterialCatModel.fromJson(Map<String, dynamic> json) =>
      MaterialCatModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.icon,
  });

  final String id;
  final String title;
  final String icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "icon": icon,
      };
}
