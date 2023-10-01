import 'dart:convert';

List<EvaluationModal> evaluationModalFromJson(String str) =>
    List<EvaluationModal>.from(
        json.decode(str).map((x) => EvaluationModal.fromJson(x)));

String evaluationModalToJson(List<EvaluationModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EvaluationModal {
  EvaluationModal({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<EvaluationModalDatum> data;

  factory EvaluationModal.fromJson(Map<String, dynamic> json) =>
      EvaluationModal(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: List<EvaluationModalDatum>.from(
            json["data"].map((x) => EvaluationModalDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EvaluationModalDatum {
  EvaluationModalDatum({
    required this.id,
    required this.title,
    required this.data,
  });

  final String id;
  final String title;
  final List<DatumDatum> data;

  factory EvaluationModalDatum.fromJson(Map<String, dynamic> json) =>
      EvaluationModalDatum(
        id: json["id"],
        title: json["title"],
        data: List<DatumDatum>.from(
            json["data"].map((x) => DatumDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatumDatum {
  DatumDatum({
    required this.id,
    required this.title,
    required this.value,
  });

  final String id;
  final String title;
  bool value;

  factory DatumDatum.fromJson(Map<String, dynamic> json) => DatumDatum(
        id: json["id"],
        title: json["title"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "value": value,
      };
}
