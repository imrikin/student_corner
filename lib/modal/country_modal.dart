import 'dart:convert';

List<CountryModal> countryModalFromJson(String str) => List<CountryModal>.from(
    json.decode(str).map((x) => CountryModal.fromJson(x)));

String countryModalToJson(List<CountryModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModal {
  CountryModal({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool success;
  final int status;
  final String message;
  final List<Datumcountry> data;

  factory CountryModal.fromJson(Map<String, dynamic> json) => CountryModal(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: List<Datumcountry>.from(
            json["data"].map((x) => Datumcountry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datumcountry {
  Datumcountry({
    required this.id,
    required this.country,
  });

  final String id;
  final String country;

  factory Datumcountry.fromJson(Map<String, dynamic> json) => Datumcountry(
        id: json["id"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
      };
}
