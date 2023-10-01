// To parse this JSON data, do
//
//     final profileImgModal = profileImgModalFromJson(jsonString);

import 'dart:convert';

List<ProfileImgModal> profileImgModalFromJson(String str) =>
    List<ProfileImgModal>.from(
        json.decode(str).map((x) => ProfileImgModal.fromJson(x)));

String profileImgModalToJson(List<ProfileImgModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileImgModal {
  ProfileImgModal({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  final int status;
  final bool success;
  final String message;
  final List<Datumn> data;

  factory ProfileImgModal.fromJson(Map<String, dynamic> json) =>
      ProfileImgModal(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: List<Datumn>.from(json["data"].map((x) => Datumn.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datumn {
  Datumn({
    required this.id,
    required this.image,
  });

  final String id;
  final String image;

  factory Datumn.fromJson(Map<String, dynamic> json) => Datumn(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
