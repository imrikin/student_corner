import 'dart:convert';

List<PersonalDetails> personalDetailsFromJson(String str) =>
    List<PersonalDetails>.from(
        json.decode(str).map((x) => PersonalDetails.fromJson(x)));

String personalDetailsToJson(List<PersonalDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonalDetails {
  PersonalDetails({
    required this.success,
    required this.status,
    required this.message,
    required this.personaldetails,
    required this.educationdetails,
    required this.studyaboardpref,
  });

  final bool success;
  final int status;
  final String message;
  final List<Personaldetail> personaldetails;
  final List<Educationdetail> educationdetails;
  final List<Studyaboardpref> studyaboardpref;

  factory PersonalDetails.fromJson(Map<String, dynamic> json) =>
      PersonalDetails(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        personaldetails: List<Personaldetail>.from(
            json["personaldetails"].map((x) => Personaldetail.fromJson(x))),
        educationdetails: List<Educationdetail>.from(
            json["educationdetails"].map((x) => Educationdetail.fromJson(x))),
        studyaboardpref: List<Studyaboardpref>.from(
            json["studyaboardpref"].map((x) => Studyaboardpref.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "personaldetails":
            List<dynamic>.from(personaldetails.map((x) => x.toJson())),
        "educationdetails":
            List<dynamic>.from(educationdetails.map((x) => x.toJson())),
        "studyaboardpref":
            List<dynamic>.from(studyaboardpref.map((x) => x.toJson())),
      };
}

class Educationdetail {
  Educationdetail({
    required this.id,
    required this.eduLevel,
    required this.eduStream,
    required this.eduInstitute,
    required this.eduPassYear,
    required this.eduResult,
    required this.eduBacklog,
  });

  final String id;
  final String eduLevel;
  final String eduStream;
  final String eduInstitute;
  final String eduPassYear;
  final String eduResult;
  final String eduBacklog;

  factory Educationdetail.fromJson(Map<String, dynamic> json) =>
      Educationdetail(
        id: json["id"],
        eduLevel: json["edu_level"],
        eduStream: json["edu_stream"],
        eduInstitute: json["edu_institute"],
        eduPassYear: json["edu_pass_year"],
        eduResult: json["edu_result"],
        eduBacklog: json["edu_backlog"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "edu_level": eduLevel,
        "edu_stream": eduStream,
        "edu_institute": eduInstitute,
        "edu_pass_year": eduPassYear,
        "edu_result": eduResult,
        "edu_backlog": eduBacklog,
      };
}

class Personaldetail {
  Personaldetail({
    required this.fname,
    required this.lname,
    required this.mobile,
    required this.isCoching,
    required this.modual,
    required this.rollNo,
    required this.email,
    required this.joiningDate,
    required this.duration,
    required this.batch,
    required this.city,
    required this.area,
    required this.zipcode,
    required this.gender,
    required this.dob,
  });

  final String fname;
  final String lname;
  final String mobile;
  final String isCoching;
  final String modual;
  final String rollNo;
  final String email;
  final String joiningDate;
  final String duration;
  final String batch;
  final String city;
  final String area;
  final String zipcode;
  final String gender;
  final String dob;

  factory Personaldetail.fromJson(Map<String, dynamic> json) => Personaldetail(
        fname: json["fname"],
        lname: json["lname"],
        mobile: json["mobile"],
        isCoching: json["isCoching"],
        modual: json["modual"],
        rollNo: json["roll_no"],
        email: json["email"],
        joiningDate: json["joining_date"],
        duration: json["duration"],
        batch: json["batch"],
        city: json["city"],
        area: json["area"],
        zipcode: json["zipcode"],
        gender: json["gender"],
        dob: json["dob"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "lname": lname,
        "mobile": mobile,
        "isCoching": isCoching,
        "modual": modual,
        "roll_no": rollNo,
        "email": email,
        "joining_date": joiningDate,
        "duration": duration,
        "batch": batch,
        "city": city,
        "area": area,
        "zipcode": zipcode,
        "gender": gender,
        "dob": dob,
      };
}

class Studyaboardpref {
  Studyaboardpref({
    required this.country1,
    required this.country2,
    required this.prefCourse,
    required this.prefIntake,
  });

  final String country1;
  final String country2;
  final String prefCourse;
  final String prefIntake;

  factory Studyaboardpref.fromJson(Map<String, dynamic> json) =>
      Studyaboardpref(
        country1: json["country1"],
        country2: json["country2"],
        prefCourse: json["pref_course"],
        prefIntake: json["pref_intake"],
      );

  Map<String, dynamic> toJson() => {
        "country1": country1,
        "country2": country2,
        "pref_course": prefCourse,
        "pref_intake": prefIntake,
      };
}
