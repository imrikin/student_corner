import 'dart:convert';

List<ReadingAnswerModal> readingAnswerModalFromJson(String str) =>
    List<ReadingAnswerModal>.from(
        json.decode(str).map((x) => ReadingAnswerModal.fromJson(x)));

class ReadingAnswerModal {
  ReadingAnswerModal({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool success;
  final int status;
  final String message;
  final List<Datum> data;

  factory ReadingAnswerModal.fromRawJson(String str) =>
      ReadingAnswerModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReadingAnswerModal.fromJson(Map<String, dynamic> json) =>
      ReadingAnswerModal(
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
    required this.url,
    required this.title,
  });

  final String id;
  final String url;
  final String title;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        url: json["url"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "title": title,
      };
}
