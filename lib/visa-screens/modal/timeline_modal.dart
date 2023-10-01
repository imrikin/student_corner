// To parse this JSON data, do
//
//     final timelineModal = timelineModalFromJson(jsonString);

import 'dart:convert';

TimelineModal timelineModalFromJson(String str) =>
    TimelineModal.fromJson(json.decode(str));

String timelineModalToJson(TimelineModal data) => json.encode(data.toJson());

class TimelineModal {
  final String? status;
  final String? date;
  final String? description;
  final String url;
  final String condition;
  final int position;
  final bool? hasAttachments;

  TimelineModal({
    required this.status,
    required this.date,
    required this.description,
    required this.position,
    this.condition = "",
    required this.hasAttachments,
    this.url = "",
  });

  factory TimelineModal.fromJson(Map<String, dynamic> json) => TimelineModal(
        status: json["status"],
        date: json["date"],
        description: json["description"],
        hasAttachments: json["hasAttachments"],
        position: json["position"],
        condition: json["condition"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "date": date,
        "description": description,
        "hasAttachments": hasAttachments,
        "position": position,
        "condition": condition,
      };
}
