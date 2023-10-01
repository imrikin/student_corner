// To parse this JSON data, do
//
//     final notimodal = notimodalFromJson(jsonString);

import 'dart:convert';

List<Notimodal> notiModalFromJson(String str) =>
    List<Notimodal>.from(json.decode(str).map((x) => Notimodal.fromJson(x)));

String notimodalToJson(List<Notimodal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notimodal {
  Notimodal({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool success;
  final int status;
  final String message;
  final List<Datum> data;

  factory Notimodal.fromJson(Map<String, dynamic> json) => Notimodal(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  final String id;
  final String title;
  final String body;
  final String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "date": date,
      };
}
