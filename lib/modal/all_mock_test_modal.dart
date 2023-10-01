import 'dart:convert';

List<AllMockTestModal> allMockTestModalFromJson(String str) =>
    List<AllMockTestModal>.from(
        json.decode(str).map((x) => AllMockTestModal.fromJson(x)));

String allMockTestModalToJson(List<AllMockTestModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllMockTestModal {
  AllMockTestModal({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool success;
  final int status;
  final String message;
  final List<Datum> data;

  factory AllMockTestModal.fromJson(Map<String, dynamic> json) =>
      AllMockTestModal(
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
    required this.date,
    required this.day,
    required this.overall,
    required this.listening,
    required this.reading,
    required this.writing,
    required this.speaking,
  });

  final String id;
  final String date;
  final String day;
  final String overall;
  final String listening;
  final String reading;
  final String writing;
  final String speaking;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        date: json["date"],
        day: json["day"],
        overall: json["overall"],
        listening: json["listening"],
        reading: json["reading"],
        writing: json["writing"],
        speaking: json["speaking"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "day": day,
        "overall": overall,
        "listening": listening,
        "reading": reading,
        "writing": writing,
        "speaking": speaking,
      };
}
