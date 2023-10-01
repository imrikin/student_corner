import 'dart:convert';

List<EducationLevel> educationLevelFromJson(String str) =>
    List<EducationLevel>.from(
        json.decode(str).map((x) => EducationLevel.fromJson(x)));

String educationLevelToJson(List<EducationLevel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EducationLevel {
  EducationLevel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool success;
  final int status;
  final String message;
  final List<Datum> data;

  factory EducationLevel.fromJson(Map<String, dynamic> json) => EducationLevel(
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
    required this.level,
  });

  final String id;
  final String level;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "level": level,
      };
}
