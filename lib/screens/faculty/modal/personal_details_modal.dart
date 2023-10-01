import 'dart:convert';

List<FacultyDetailsModal> facultyDetailsModalFromJson(String str) =>
    List<FacultyDetailsModal>.from(
        json.decode(str).map((x) => FacultyDetailsModal.fromJson(x)));

String facultyDetailsModalToJson(List<FacultyDetailsModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacultyDetailsModal {
  FacultyDetailsModal({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datum> data;

  factory FacultyDetailsModal.fromJson(Map<String, dynamic> json) =>
      FacultyDetailsModal(
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
    required this.name,
    required this.mobile,
    required this.email,
    required this.branch,
    required this.userType,
    required this.dob,
    required this.holderName,
    required this.bankName,
    required this.bankBranch,
    required this.acNo,
    required this.ifsc,
    required this.idProof,
  });

  final String name;
  final String mobile;
  final String email;
  final String branch;
  final String userType;
  final String dob;
  final String holderName;
  final String bankName;
  final String bankBranch;
  final String acNo;
  final String ifsc;
  final String idProof;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        branch: json["branch"],
        userType: json["userType"],
        dob: json["DOB"],
        holderName: json["holderName"],
        bankName: json["bankName"],
        bankBranch: json["bankBranch"],
        acNo: json["acNo"],
        ifsc: json["IFSC"],
        idProof: json["idProof"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "email": email,
        "branch": branch,
        "userType": userType,
        "DOB": dob,
        "holderName": holderName,
        "bankName": bankName,
        "bankBranch": bankBranch,
        "acNo": acNo,
        "IFSC": ifsc,
        "idProof": idProof,
      };
}
