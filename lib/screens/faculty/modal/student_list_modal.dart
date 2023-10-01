import 'dart:convert';

List<StudentList> studentListFromJson(String str) => List<StudentList>.from(
    json.decode(str).map((x) => StudentList.fromJson(x)));

String studentListToJson(List<StudentList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentList {
  StudentList({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datum> data;

  factory StudentList.fromJson(Map<String, dynamic> json) => StudentList(
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
    required this.name,
    required this.rollNo,
    required this.time,
    required this.status,
    required this.date,
  });

  final String id;
  final String name;
  final String rollNo;
  final String time;
  final String status;
  final String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        rollNo: json["roll_no"],
        time: json["time"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "roll_no": rollNo,
        "time": time,
        "status": status,
        "date": date,
      };
}
