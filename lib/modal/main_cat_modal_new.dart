// To parse this JSON data, do
//
//     final mainCategoryModalNew = mainCategoryModalNewFromJson(jsonString);

import 'dart:convert';

List<MainCategoryModalNew> mainCategoryModalNewFromJson(String str) =>
    List<MainCategoryModalNew>.from(
        json.decode(str).map((x) => MainCategoryModalNew.fromJson(x)));

String mainCategoryModalNewToJson(List<MainCategoryModalNew> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MainCategoryModalNew {
  MainCategoryModalNew({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datum> data;

  factory MainCategoryModalNew.fromJson(Map<String, dynamic> json) =>
      MainCategoryModalNew(
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
  });

  final String id;
  final String title;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
