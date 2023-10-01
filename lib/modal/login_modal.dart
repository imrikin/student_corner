import 'dart:convert';

List<LoginModal> loginModalFromJson(String str) =>
    List<LoginModal>.from(json.decode(str).map((x) => LoginModal.fromJson(x)));

String loginModalToJson(List<LoginModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModal {
  LoginModal({
    required this.success,
    required this.status,
    required this.message,
    required this.inquiryId,
    required this.role,
  });

  final bool success;
  final int status;
  final String message;
  final String inquiryId;
  final String role;

  factory LoginModal.fromJson(Map<String, dynamic> json) => LoginModal(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        inquiryId: json["inquiry_id"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "inquiry_id": inquiryId,
        "role": role,
      };
}
