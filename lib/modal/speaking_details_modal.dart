import 'dart:convert';

List<SpeakignModal> speakignModalFromJson(String str) =>
    List<SpeakignModal>.from(
        json.decode(str).map((x) => SpeakignModal.fromJson(x)));

String speakignModalToJson(List<SpeakignModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpeakignModal {
  SpeakignModal({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool success;
  final int status;
  final String message;
  final List<Datum> data;

  factory SpeakignModal.fromJson(Map<String, dynamic> json) => SpeakignModal(
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
    required this.no,
    required this.id,
    required this.date,
    required this.slot,
    required this.time,
    required this.status,
    required this.module,
    required this.totalBand,
    required this.bandArray,
    required this.dataArray,
  });

  final int no;
  final String id;
  final String date;
  final String slot;
  final String time;
  final String status;
  final String module;
  final String totalBand;
  final String bandArray;
  final String dataArray;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        no: json["no"],
        id: json["id"],
        date: json["date"],
        slot: json["slot"],
        time: json["time"],
        status: json["status"],
        module: json["module"],
        totalBand: json["total_band"],
        bandArray: json["band_array"],
        dataArray: json["data_array"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "id": id,
        "date": date,
        "slot": slot,
        "time": time,
        "status": status,
        "module": module,
        "total_band": totalBand,
        "band_array": bandArray,
        "data_array": dataArray,
      };
}
