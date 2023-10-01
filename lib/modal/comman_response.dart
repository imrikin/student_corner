import 'dart:convert';

List<CommoanResponse> commoanResponseFromJson(String str) =>
    List<CommoanResponse>.from(
        json.decode(str).map((x) => CommoanResponse.fromJson(x)));

String commoanResponseToJson(List<CommoanResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommoanResponse {
  CommoanResponse({
    required this.success,
    required this.status,
    required this.message,
    required this.inquiryId,
  });

  final bool success;
  final int status;
  final String message;
  final String inquiryId;

  factory CommoanResponse.fromJson(Map<String, dynamic> json) =>
      CommoanResponse(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        inquiryId: json["inquiry_id"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "inquiry_id": inquiryId,
      };
}
