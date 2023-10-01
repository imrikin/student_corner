import 'dart:convert';

EvaluationBandModal evaluationBandModalFromJson(String str) =>
    EvaluationBandModal.fromJson(json.decode(str));

String evaluationBandModalToJson(EvaluationBandModal data) =>
    json.encode(data.toJson());

class EvaluationBandModal {
  EvaluationBandModal({
    required this.type,
    required this.band,
  });

  final String type;
  String band;

  factory EvaluationBandModal.fromJson(Map<String, dynamic> json) =>
      EvaluationBandModal(
        type: json["type"],
        band: json["band"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "band": band,
      };
}
