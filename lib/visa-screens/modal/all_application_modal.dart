// To parse this JSON data, do
//
//     final AllApplicationDetails = AllApplicationDetailsFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

AllApplicationDetails allApplicationDetailsFromJson(String str) =>
    AllApplicationDetails.fromJson(json.decode(str));

String allApplicationDetailsToJson(AllApplicationDetails data) =>
    json.encode(data.toJson());

class AllApplicationDetails {
  final bool? status;
  final String? statusCode;
  final String? message;
  final List<CountryWiseStage>? countryWiseStage;
  final int? totalApplication;
  final int? offerRecevied;
  final List<ApplicationData>? data;

  AllApplicationDetails({
    this.status,
    this.statusCode,
    this.message,
    this.countryWiseStage,
    this.totalApplication,
    this.offerRecevied,
    this.data,
  });

  factory AllApplicationDetails.fromJson(Map<String, dynamic> json) =>
      AllApplicationDetails(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        countryWiseStage: json["countryWiseStage"] == null
            ? []
            : List<CountryWiseStage>.from(json["countryWiseStage"]!
                .map((x) => CountryWiseStage.fromJson(x))),
        totalApplication: json["totalApplication"],
        offerRecevied: json["offerRecevied"],
        data: json["data"] == null
            ? []
            : List<ApplicationData>.from(
                json["data"]!.map((x) => ApplicationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "countryWiseStage": countryWiseStage == null
            ? []
            : List<dynamic>.from(countryWiseStage!.map((x) => x.toJson())),
        "totalApplication": totalApplication,
        "offerRecevied": offerRecevied,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CountryWiseStage {
  final String? country;
  final String? stage;
  final String? doneOrnot;
  final String? date;

  CountryWiseStage({
    this.country,
    this.stage,
    this.doneOrnot,
    this.date,
  });

  factory CountryWiseStage.fromJson(Map<String, dynamic> json) =>
      CountryWiseStage(
        country: json["country"],
        stage: json["stage"],
        doneOrnot: json["doneOrnot"],
        date: json["date"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "stage": stage,
        "doneOrnot": doneOrnot,
        "date": date,
      };
}

class ApplicationData {
  final String? admissionId;
  final String? country;
  final Map<String, String?>? university;
  final String? intakeMonth;
  final String? intakeYear;
  final dynamic program;
  final String? campus;
  final String? credentials;
  final String? courseLength;
  final String? applicationdate;
  final String? submissiondate;
  final String? selectiondate;
  final String? applicationStatus;
  final String? finalSelection;
  final String? coursedate;
  final String? hInquiryId;
  final String? branchId;
  final String? admissionCopy;
  final String? offerType;
  final String? offerexpire;
  final String? fees;
  final String? feesdate;
  final String? feestotalamount;
  final String? feespaidamount;
  final String? feesremainamount;
  final String? feesCopy;
  final String? studentId;
  final String? offerCondition;
  final String? feesReceipt;
  final String? decilneReason;
  final String? isSds;

  final String? lastUpdate;
  final String? feesRefund;
  final String? scholarship;
  final String? appCredentials;
  final String? appCredentialsLink;
  final String? appCredentialsId;
  final String? appCredentialsPassword;
  final String? i20Received;
  final String? i20ReceivedDate;
  final String? i20Status;

  ApplicationData({
    this.admissionId,
    this.country,
    this.university,
    this.intakeMonth,
    this.intakeYear,
    this.program,
    this.campus,
    this.credentials,
    this.courseLength,
    this.applicationdate,
    this.submissiondate,
    this.selectiondate,
    this.applicationStatus,
    this.finalSelection,
    this.coursedate,
    this.hInquiryId,
    this.branchId,
    this.admissionCopy,
    this.lastUpdate,
    this.offerType,
    this.offerexpire,
    this.fees,
    this.feesdate,
    this.feestotalamount,
    this.feespaidamount,
    this.feesremainamount,
    this.feesCopy,
    this.studentId,
    this.offerCondition,
    this.feesReceipt,
    this.decilneReason,
    this.isSds,
    this.feesRefund,
    this.scholarship,
    this.appCredentials,
    this.appCredentialsLink,
    this.appCredentialsId,
    this.appCredentialsPassword,
    this.i20Received,
    this.i20ReceivedDate,
    this.i20Status,
  });

  factory ApplicationData.fromJson(Map<String, dynamic> json) =>
      ApplicationData(
        admissionId: json["admission_id"],
        country: json["country"],
        university: Map.from(json["university"]!)
            .map((k, v) => MapEntry<String, String?>(k, v)),
        intakeMonth: json["intake_month"],
        intakeYear: json["intake_year"],
        program: json["program"],
        campus: json["campus"],
        credentials: json["credentials"],
        courseLength: json["course_length"],
        applicationdate: json["applicationdate"].toString() == null
            ? ""
            : json["applicationdate"],
        submissiondate: json["submissiondate"],
        selectiondate: json["selectiondate"],
        lastUpdate: json["last_update"].toString(),
        applicationStatus: json["application_status"],
        finalSelection: json["final_selection"],
        coursedate: json["coursedate"],
        hInquiryId: json["h_inquiry_id"],
        branchId: json["branch_id"],
        admissionCopy: json["admission_copy"],
        offerType: json["offer_type"],
        offerexpire: json["offerexpire"],
        fees: json["fees"],
        feesdate: json["feesdate"],
        feestotalamount: json["feestotalamount"],
        feespaidamount: json["feespaidamount"],
        feesremainamount: json["feesremainamount"],
        feesCopy: json["fees_copy"],
        studentId: json["student_id"],
        offerCondition: json["offer_condition"],
        feesReceipt: json["fees_receipt"],
        decilneReason: json["decilne_reason"],
        isSds: json["is_sds"],
        feesRefund: json["fees_refund"],
        scholarship: json["scholarship"],
        appCredentials: json["app_credentials"],
        appCredentialsLink: json["app_credentials_link"],
        appCredentialsId: json["app_credentials_id"],
        appCredentialsPassword: json["app_credentials_password"],
        i20Received: json["i20_received"],
        i20ReceivedDate: json["i20_received_date"] ?? "",
        i20Status: json["i_20_status"],
      );

  Map<String, dynamic> toJson() => {
        "admission_id": admissionId,
        "country": country,
        "university": Map.from(university!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "intake_month": intakeMonth,
        "intake_year": intakeYear,
        "program": program,
        "campus": campus,
        "credentials": credentials,
        "course_length": courseLength,
        "applicationdate": applicationdate,
        "submissiondate": submissiondate,
        "selectiondate": selectiondate,
        "application_status": applicationStatus,
        "final_selection": finalSelection,
        "coursedate": coursedate,
        "h_inquiry_id": hInquiryId,
        "branch_id": branchId,
        "admission_copy": admissionCopy,
        "offer_type": offerType,
        "offerexpire": offerexpire,
        "fees": fees,
        "feesdate": feesdate,
        "feestotalamount": feestotalamount,
        "feespaidamount": feespaidamount,
        "feesremainamount": feesremainamount,
        "fees_copy": feesCopy,
        "student_id": studentId,
        "offer_condition": offerCondition,
        "fees_receipt": feesReceipt,
        "decilne_reason": decilneReason,
        "is_sds": isSds,
        "last_update": lastUpdate?.toString(),
        "fees_refund": feesRefund,
        "scholarship": scholarship,
        "app_credentials": appCredentials,
        "app_credentials_link": appCredentialsLink,
        "app_credentials_id": appCredentialsId,
        "app_credentials_password": appCredentialsPassword,
        "i20_received": i20Received,
        "i20_received_date": i20ReceivedDate,
        "i_20_status": i20Status,
      };
}
