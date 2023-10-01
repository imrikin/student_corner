// To parse this JSON data, do
//
//     final loginNew = loginNewFromJson(jsonString);

import 'dart:convert';

List<LoginNew> loginNewFromJson(String str) =>
    List<LoginNew>.from(json.decode(str).map((x) => LoginNew.fromJson(x)));

String loginNewToJson(List<LoginNew> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginNew {
  final bool success;
  final int status;
  final String message;
  final bool inAdmission;
  final bool inCoaching;
  final String inquiryId;
  final String role;

  LoginNew({
    required this.success,
    required this.status,
    required this.message,
    required this.inAdmission,
    required this.inCoaching,
    required this.inquiryId,
    required this.role,
  });

  factory LoginNew.fromJson(Map<String, dynamic> json) => LoginNew(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        inAdmission: json["in_admission"],
        inCoaching: json["in_coaching"],
        inquiryId: json["inquiry_id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "in_admission": inAdmission,
        "in_coaching": inCoaching,
        "inquiry_id": inquiryId,
        "role": role,
      };
}
