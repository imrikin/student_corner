import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/visa-screens/custom_text_widget.dart';

import '../../componant/text_field.dart';
import '../../const/colors.dart';
import '../../screens/login_screen.dart';

class ProfileScreenNew extends StatefulWidget {
  const ProfileScreenNew({super.key});

  @override
  State<ProfileScreenNew> createState() => _ProfileScreenNewState();
}

class _ProfileScreenNewState extends State<ProfileScreenNew> {
  late SharedPreferences userSetting;
  bool login = false;

  getSharedPref() async {
    login = false;
    userSetting = await SharedPreferences.getInstance();
    setState(() {
      userSetting.setBool('login', false);
    });

    Navigator.of(context, rootNavigator: true).pop('dialog');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void initState() {
    // getSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const TextFieldCus(
                            text: 'Are You Sure ?',
                            color: Colors.black,
                            fontSize: 18,
                            textAlign: TextAlign.center,
                            fontFamily: 'hanuman'),
                        actions: [
                          const TextFieldCus(
                              text: 'Cancel',
                              color: Colors.black,
                              fontSize: 18,
                              width: 0.2,
                              textAlign: TextAlign.center,
                              fontFamily: 'hanuman'),
                          InkWell(
                            onTap: () {
                              getSharedPref();
                            },
                            child: const TextFieldCus(
                                text: 'Logout',
                                color: kPrimary,
                                fontSize: 18,
                                width: 0.2,
                                textAlign: TextAlign.center,
                                fontFamily: 'hanuman'),
                          ),
                        ],
                      ));
            },
            child: const CustomText(data: "Logout"),
          ),
        ],
      ),
    );
  }
}
