import 'package:http/http.dart' as http;

sendWpMessage(message, mobile) async {
  String key = "984842e549163d577b2e95ca5805ccd9";
  String url =
      "http://bulkcampaigns.com/api/wapi?apikey=$key&mobile=$mobile&msg=$message";

  var response = await http.get(
    Uri.parse(url),
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
  );
  if (response.statusCode == 200) {}
}
