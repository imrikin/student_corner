import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/screens/faculty/modal/evaluation_modal.dart';
import 'package:http/http.dart' as http;
import 'package:student_corner/screens/faculty/modal/faculty_doc_modal.dart';
import 'package:student_corner/screens/faculty/modal/home_modal.dart';
import 'package:student_corner/screens/faculty/modal/personal_details_modal.dart';
import 'package:student_corner/screens/faculty/modal/student_list_modal.dart';

class APiConst {
  // static String baseUrl = 'http://192.168.29.156:8080/abdevops/';
  static String baseUrl = 'https://abdevops.com/';
  static String baseUrlFlyway =
      'https://flywayimmigration.in/crmportal/mobile-app/faculty/';
}

Future<List<EvaluationModal>> evaluationDetails(module) async {
  var url = module == 0
      ? Uri.parse("${APiConst.baseUrl}get_speaking_eve_data.php")
      : Uri.parse("${APiConst.baseUrl}get_writing_eve_data.php");
  var response = await http.get(
    url,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
  );
  if (response.statusCode == 200) {
    List<EvaluationModal> allDetails = evaluationModalFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<StudentList>> studentList(module) async {
  var url = module == 0
      ? Uri.parse("${APiConst.baseUrlFlyway}get_slot_list.php?module=Speaking")
      : Uri.parse("${APiConst.baseUrlFlyway}get_slot_list.php?module=Writing");
  var response = await http.get(
    url,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
  );
  if (response.statusCode == 200) {
    List<StudentList> allDetails = studentListFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<HomeDetailsModal>> homeDetailsList() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String facultyId = userSetting.getString('inqueryid')!;
  Map data = {'facultyId': facultyId};
  var url = Uri.parse("${APiConst.baseUrlFlyway}get_home_data.php");
  var response = await http.post(
    url,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: data,
  );
  if (response.statusCode == 200) {
    List<HomeDetailsModal> allDetails = homeDetailsModalFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<FacultyDocumentModal>> docData() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String facultyId = userSetting.getString('inqueryid')!;
  Map data = {'username': facultyId};
  var url = Uri.parse("${APiConst.baseUrl}get_document.php");
  var response = await http.post(
    url,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: data,
  );
  if (response.statusCode == 200) {
    List<FacultyDocumentModal> allDetails =
        facultyDocumentModalFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<FacultyDetailsModal>> personalDetails() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String facultyId = userSetting.getString('inqueryid')!;
  Map data = {'username': facultyId};
  var url = Uri.parse("${APiConst.baseUrlFlyway}faculty_details.php");
  var response = await http.post(
    url,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: data,
  );
  if (response.statusCode == 200) {
    List<FacultyDetailsModal> allDetails =
        facultyDetailsModalFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}
