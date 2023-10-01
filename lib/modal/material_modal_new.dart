import 'dart:convert';

List<MaterialModelNew> materialModelNewFromJson(String str) =>
    List<MaterialModelNew>.from(
        json.decode(str).map((x) => MaterialModelNew.fromJson(x)));

String materialModelNewToJson(List<MaterialModelNew> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialModelNew {
  MaterialModelNew({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datum> data;

  factory MaterialModelNew.fromJson(Map<String, dynamic> json) =>
      MaterialModelNew(
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
    required this.url,
    required this.type,
  });

  final String id;
  final String title;
  final String url;
  final String type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "type": type,
      };
}
