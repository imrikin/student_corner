import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/const/api.dart';
import 'package:http/http.dart' as http;
import 'package:student_corner/modal/all_pesonal_details.dart';

Future<List<PersonalDetails>> allPersonalDetails() async {
  SharedPreferences userSetting = await SharedPreferences.getInstance();
  String inqueryId = userSetting.getString('inqueryid')!;
  // log(inqueryId);
  // log("inqueryId");
  Map data = {'inqury_id': inqueryId};
  var url = Uri.parse("${APiConst.baseUrl}home.php");
  var response = await http.post(url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data);
  if (response.statusCode == 200) {
    List<PersonalDetails> allPersonalDetailsList =
        personalDetailsFromJson(response.body);
    return allPersonalDetailsList;
  } else {
    throw Exception('Failed');
  }
}
