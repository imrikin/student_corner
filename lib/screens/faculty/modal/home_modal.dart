import 'dart:convert';

List<HomeDetailsModal> homeDetailsModalFromJson(String str) =>
    List<HomeDetailsModal>.from(
        json.decode(str).map((x) => HomeDetailsModal.fromJson(x)));

String homeDetailsModalToJson(List<HomeDetailsModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeDetailsModal {
  HomeDetailsModal({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datum> data;

  factory HomeDetailsModal.fromJson(Map<String, dynamic> json) =>
      HomeDetailsModal(
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
    required this.todaySpeaking,
    required this.todayWriting,
    required this.totalSpeaking,
    required this.totalWriting,
    required this.pendingSpeaking,
    required this.pendingWriting,
  });

  final int todaySpeaking;
  final int todayWriting;
  final int totalSpeaking;
  final int totalWriting;
  final int pendingSpeaking;
  final int pendingWriting;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        todaySpeaking: json["todaySpeaking"],
        todayWriting: json["todayWriting"],
        totalSpeaking: json["totalSpeaking"],
        totalWriting: json["totalWriting"],
        pendingSpeaking: json["pendingSpeaking"],
        pendingWriting: json["pendingWriting"],
      );

  Map<String, dynamic> toJson() => {
        "todaySpeaking": todaySpeaking,
        "todayWriting": todayWriting,
        "totalSpeaking": totalSpeaking,
        "totalWriting": totalWriting,
        "pendingSpeaking": pendingSpeaking,
        "pendingWriting": pendingWriting,
      };
}
