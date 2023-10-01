// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/const/api.dart';
import 'package:http/http.dart' as http;
import 'package:student_corner/home.dart';
import 'package:student_corner/modal/all_mock_test_modal.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:student_corner/modal/main_cat_modal_new.dart';
import 'package:student_corner/modal/material_cat_modal.dart';
import 'package:student_corner/modal/material_modal_new.dart';
import 'package:student_corner/modal/noti_modal.dart';
import 'package:student_corner/modal/profile_img_modal.dart';
import 'package:student_corner/modal/reading_answer_modal.dart';
import 'package:student_corner/modal/speaking_details_modal.dart';

Future<List<AllMockTestModal>> allMockTest(subUrl) async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String inqueryId = userSetting.getString('inqueryid')!;
  Map data = {'inqury_id': inqueryId};
  var url = Uri.parse(APiConst.baseUrl + subUrl);
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<AllMockTestModal> allMockTestDetails =
        allMockTestModalFromJson(response.body);
    return allMockTestDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<SpeakignModal>> allSpeakingDetails() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String rollno = userSetting.getString('rollno')!;
  String email = userSetting.getString('email')!;
  Map data = {'rollno': rollno, 'email': email};
  var url = Uri.parse("${APiConst.baseUrl}get-all-speaking-details.php");
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<SpeakignModal> allDetails = speakignModalFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<CommoanResponse>> profilePercent() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String inquiryid = userSetting.getString('inqueryid')!;
  Map data = {'inquiryid': inquiryid};
  var url = Uri.parse("${APiConst.baseUrl}profile_percent.php");
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<CommoanResponse> allDetails = commoanResponseFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<ReadingAnswerModal>> readingAnserApi(subId, moduale) async {
  Map data = {'sub_id': subId, 'module': moduale};
  var url = Uri.parse("${APiConst.baseUrl}get_reading_ans.php");
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<ReadingAnswerModal> allDetails =
        readingAnswerModalFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<MaterialCatModel>> allMaterialApi() async {
  var url = Uri.parse("${APiConst.baseUrl}get_material_cat.php");
  var response = await http.post(url, headers: {
    "Accept": "application/json",
    "Content-Type": "application/x-www-form-urlencoded"
  });
  if (response.statusCode == 200) {
    List<MaterialCatModel> allDetails = materialCatModelFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<MaterialCatModel>> subCategoryModal(mainCateID) async {
  Map data = {'mainID': mainCateID};
  var url = Uri.parse("${APiConst.baseUrl}get_sub_cat_mate.php");
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<MaterialCatModel> allDetails = materialCatModelFromJson(response.body);
    return allDetails;
  } else {
    throw Exception('Failed');
  }
}

Future<List<MaterialModelNew>> materialModalNew(mainId, subId) async {
  Map data = {'mainId': mainId, 'subId': subId};
  // var url = Uri.parse('http://192.168.29.156:8080/abdevops/get_material.php');
  var url = Uri.parse('https://abdevops.com/get_material.php');
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<MaterialModelNew> modal = materialModelNewFromJson(response.body);
    return modal;
  } else {
    throw Exception('Failed');
  }
}

Future<List<MainCategoryModalNew>> mainCateModalNew() async {
  // var url = Uri.parse('http://192.168.29.156:8080/abdevops/get_main_cat.php');
  var url = Uri.parse('https://abdevops.com/get_main_cat.php');
  var response = await http.post(
    url,
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
  );
  if (response.statusCode == 200) {
    List<MainCategoryModalNew> modal =
        mainCategoryModalNewFromJson(response.body);
    return modal;
  } else {
    throw Exception('Failed');
  }
}

Future<List<MainCategoryModalNew>> subCateModalNew(mainId) async {
  Map data = {
    'mainId': mainId,
  };
  // var url = Uri.parse('http://192.168.29.156:8080/abdevops/get_sub_cat.php');
  var url = Uri.parse('https://abdevops.com/get_sub_cat.php');
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<MainCategoryModalNew> modal =
        mainCategoryModalNewFromJson(response.body);
    return modal;
  } else {
    throw Exception('Failed');
  }
}

uploadProfilePic(fileValue) async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String inquiryId = userSetting.getString('inqueryid')!;
  // var url = Uri.parse('http://192.168.29.156:8080/abdevops/upload_image.php');
  var url = Uri.parse('https://abdevops.com/upload_image.php');
  var request = http.MultipartRequest("POST", url);
  request.fields['inquiryId'] = inquiryId;
  // request.files.add(await http.MultipartFile.fromBytes(
  //     'file', await File.fromUri(fileValue).readAsBytes()));
  request.files.add(await http.MultipartFile.fromPath('file', fileValue));
  request.send().then((value) {
    if (value.statusCode == 200) {
      Get.to(const HomeScreen(index: 0));
      Get.snackbar('Success', "Image Updated Successfully!!");
    } else {
      Get.snackbar('Fail', "Some error occurs try again!!");
    }
  });
}

Future getImageFromLocals() async {
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  uploadProfilePic(image!.path);
  return image;
}

Future<List<Notimodal>> getNotificationDetails() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String inquiryid = userSetting.getString('inqueryid')!;
  Map data = {
    'inq_id': inquiryid,
  };
  // var url = Uri.parse('http://192.168.29.156:8080/abdevops/get_noti_info.php');
  var url = Uri.parse('https://abdevops.com/get_noti_info.php');
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<Notimodal> modal = notiModalFromJson(response.body.toString());
    return modal;
  } else {
    throw Exception('Failed');
  }
}

Future<List<ProfileImgModal>> getProfileImg() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String inquiryid = userSetting.getString('inqueryid')!;
  Map data = {
    'inq_id': inquiryid,
  };
  // var url = Uri.parse('http://192.168.29.156:8080/abdevops/get_image.php');
  var url = Uri.parse('https://abdevops.com/get_image.php');
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    return profileImgModalFromJson(response.body);
  } else {
    throw Exception('Failed');
  }
}
