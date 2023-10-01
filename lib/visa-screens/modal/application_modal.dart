// To parse this JSON data, do
//
//     final loginNew = loginNewFromJson(jsonString);

import 'dart:convert';

LoginNew loginNewFromJson(String str) => LoginNew.fromJson(json.decode(str));

String loginNewToJson(LoginNew data) => json.encode(data.toJson());

class LoginNew {
  final String? status;
  final String? statusCode;
  final String? message;
  final Data? data;

  LoginNew({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory LoginNew.fromJson(Map<String, dynamic> json) => LoginNew(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final String? admissionId;
  final String? country;
  final University? university;
  final String? intakeMonth;
  final String? intakeYear;
  final dynamic program;
  final String? campus;
  final String? credentials;
  final String? courseLength;
  final DateTime? applicationdate;
  final String? submissiondate;
  final String? selectiondate;
  final String? applicationStatus;
  final String? finalSelection;
  final String? coursedate;
  final String? hInquiryId;
  final String? branchId;
  final String? admissionCopy;
  final dynamic offerType;
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
  final String? feesRefund;
  final String? scholarship;
  final String? appCredentials;
  final String? appCredentialsLink;
  final String? appCredentialsId;
  final String? appCredentialsPassword;
  final String? i20Received;
  final DateTime? i20ReceivedDate;
  final dynamic i20Status;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        admissionId: json["admission_id"],
        country: json["country"],
        university: json["university"] == null
            ? null
            : University.fromJson(json["university"]),
        intakeMonth: json["intake_month"],
        intakeYear: json["intake_year"],
        program: json["program"],
        campus: json["campus"],
        credentials: json["credentials"],
        courseLength: json["course_length"],
        applicationdate: json["applicationdate"] == null
            ? null
            : DateTime.parse(json["applicationdate"]),
        submissiondate: json["submissiondate"],
        selectiondate: json["selectiondate"],
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
        i20ReceivedDate: json["i20_received_date"] == null
            ? null
            : DateTime.parse(json["i20_received_date"]),
        i20Status: json["i_20_status"],
      );

  Map<String, dynamic> toJson() => {
        "admission_id": admissionId,
        "country": country,
        "university": university?.toJson(),
        "intake_month": intakeMonth,
        "intake_year": intakeYear,
        "program": program,
        "campus": campus,
        "credentials": credentials,
        "course_length": courseLength,
        "applicationdate":
            "${applicationdate!.year.toString().padLeft(4, '0')}-${applicationdate!.month.toString().padLeft(2, '0')}-${applicationdate!.day.toString().padLeft(2, '0')}",
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
        "fees_refund": feesRefund,
        "scholarship": scholarship,
        "app_credentials": appCredentials,
        "app_credentials_link": appCredentialsLink,
        "app_credentials_id": appCredentialsId,
        "app_credentials_password": appCredentialsPassword,
        "i20_received": i20Received,
        "i20_received_date":
            "${i20ReceivedDate!.year.toString().padLeft(4, '0')}-${i20ReceivedDate!.month.toString().padLeft(2, '0')}-${i20ReceivedDate!.day.toString().padLeft(2, '0')}",
        "i_20_status": i20Status,
      };
}

class University {
  final String? universityId;
  final String? universityName;
  final dynamic uniLogo;
  final String? campus;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? website;
  final String? intlName;
  final String? intlContact;
  final String? intlEmail;
  final String? commName;
  final String? commContact;
  final String? commEmail;
  final String? cmsName;
  final String? cmsContact;
  final String? cmsEmail;
  final String? ourShare;
  final String? modeOurShare;
  final String? status;
  final DateTime? agreementDate;
  final String? agreementCopy;
  final String? certificateCopy;
  final String? addedDate;
  final String? videoLink;
  final String? applicationEmail;
  final String? yearTarget;
  final String? commissionFrequency;
  final String? noOfPayment;
  final String? primeOrNot;
  final String? universityPriority;
  final String? remarks;
  final dynamic uniBanner;
  final dynamic intake;
  final dynamic examAccepted;
  final dynamic applicationFees;
  final dynamic tutionFees;
  final dynamic examEntryRequire;
  final dynamic applicationGuideline;
  final dynamic mapLink;
  final dynamic studyArea;

  University({
    this.universityId,
    this.universityName,
    this.uniLogo,
    this.campus,
    this.address,
    this.city,
    this.state,
    this.country,
    this.website,
    this.intlName,
    this.intlContact,
    this.intlEmail,
    this.commName,
    this.commContact,
    this.commEmail,
    this.cmsName,
    this.cmsContact,
    this.cmsEmail,
    this.ourShare,
    this.modeOurShare,
    this.status,
    this.agreementDate,
    this.agreementCopy,
    this.certificateCopy,
    this.addedDate,
    this.videoLink,
    this.applicationEmail,
    this.yearTarget,
    this.commissionFrequency,
    this.noOfPayment,
    this.primeOrNot,
    this.universityPriority,
    this.remarks,
    this.uniBanner,
    this.intake,
    this.examAccepted,
    this.applicationFees,
    this.tutionFees,
    this.examEntryRequire,
    this.applicationGuideline,
    this.mapLink,
    this.studyArea,
  });

  factory University.fromJson(Map<String, dynamic> json) => University(
        universityId: json["university_id"],
        universityName: json["university_name"],
        uniLogo: json["uni_logo"],
        campus: json["campus"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        website: json["website"],
        intlName: json["intl_name"],
        intlContact: json["intl_contact"],
        intlEmail: json["intl_email"],
        commName: json["comm_name"],
        commContact: json["comm_contact"],
        commEmail: json["comm_email"],
        cmsName: json["cms_name"],
        cmsContact: json["cms_contact"],
        cmsEmail: json["cms_email"],
        ourShare: json["our_share"],
        modeOurShare: json["mode_our_share"],
        status: json["status"],
        agreementDate: json["agreement_date"] == null
            ? null
            : DateTime.parse(json["agreement_date"]),
        agreementCopy: json["agreement_copy"],
        certificateCopy: json["certificate_copy"],
        addedDate: json["added_date"],
        videoLink: json["video_link"],
        applicationEmail: json["application_email"],
        yearTarget: json["year_target"],
        commissionFrequency: json["commission_frequency"],
        noOfPayment: json["no_of_payment"],
        primeOrNot: json["prime_or_not"],
        universityPriority: json["university_priority"],
        remarks: json["remarks"],
        uniBanner: json["uni_banner"],
        intake: json["intake"],
        examAccepted: json["exam_accepted"],
        applicationFees: json["application_fees"],
        tutionFees: json["tution_fees"],
        examEntryRequire: json["exam_entry_require"],
        applicationGuideline: json["application_guideline"],
        mapLink: json["map_link"],
        studyArea: json["study_area"],
      );

  Map<String, dynamic> toJson() => {
        "university_id": universityId,
        "university_name": universityName,
        "uni_logo": uniLogo,
        "campus": campus,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "website": website,
        "intl_name": intlName,
        "intl_contact": intlContact,
        "intl_email": intlEmail,
        "comm_name": commName,
        "comm_contact": commContact,
        "comm_email": commEmail,
        "cms_name": cmsName,
        "cms_contact": cmsContact,
        "cms_email": cmsEmail,
        "our_share": ourShare,
        "mode_our_share": modeOurShare,
        "status": status,
        "agreement_date":
            "${agreementDate!.year.toString().padLeft(4, '0')}-${agreementDate!.month.toString().padLeft(2, '0')}-${agreementDate!.day.toString().padLeft(2, '0')}",
        "agreement_copy": agreementCopy,
        "certificate_copy": certificateCopy,
        "added_date": addedDate,
        "video_link": videoLink,
        "application_email": applicationEmail,
        "year_target": yearTarget,
        "commission_frequency": commissionFrequency,
        "no_of_payment": noOfPayment,
        "prime_or_not": primeOrNot,
        "university_priority": universityPriority,
        "remarks": remarks,
        "uni_banner": uniBanner,
        "intake": intake,
        "exam_accepted": examAccepted,
        "application_fees": applicationFees,
        "tution_fees": tutionFees,
        "exam_entry_require": examEntryRequire,
        "application_guideline": applicationGuideline,
        "map_link": mapLink,
        "study_area": studyArea,
      };
}
