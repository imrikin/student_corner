import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MainAppBar extends StatelessWidget {
  final String title;
  const MainAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontfamily: 'Hanuman-black',
            size: 22,
          ),
          InkWell(
            onTap: () async {
              SharedPreferences userSetting =
                  await SharedPreferences.getInstance();
              String username = userSetting.getString('inqueryid')!;

              launchUrl(Uri.parse(
                  "https://flywayimmigration.in/classroom/helper/login_check.php?username=$username&from=facultyApp"));
            },
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: const Icon(
                Icons.language_rounded,
                size: 26,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
