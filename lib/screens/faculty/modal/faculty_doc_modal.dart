import 'dart:convert';

List<FacultyDocumentModal> facultyDocumentModalFromJson(String str) =>
    List<FacultyDocumentModal>.from(
        json.decode(str).map((x) => FacultyDocumentModal.fromJson(x)));

String facultyDocumentModalToJson(List<FacultyDocumentModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FacultyDocumentModal {
  FacultyDocumentModal({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datum> data;

  factory FacultyDocumentModal.fromJson(Map<String, dynamic> json) =>
      FacultyDocumentModal(
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
    required this.idProof,
    required this.passbook,
    required this.photo,
  });

  final String idProof;
  final String passbook;
  final String photo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idProof: json["id_proof"],
        passbook: json["passbook"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id_proof": idProof,
        "passbook": passbook,
        "photo": photo,
      };
}
