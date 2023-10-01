// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/all_personal_details.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/const/const.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/modal/all_pesonal_details.dart';
import 'package:student_corner/modal/profile_img_modal.dart';
import 'package:student_corner/screens/all_material_screen.dart';
import 'package:student_corner/screens/login_screen.dart';
import 'package:student_corner/screens/under_constuction_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  SharedPreferences? userSetting;
  bool login = true;
  late Future<List<PersonalDetails>> details;
  late Future<List<ProfileImgModal>> profileImg;
  getSharedPref() async {
    login = false;
    userSetting = await SharedPreferences.getInstance();
    setState(() {
      userSetting!.setBool('login', false);
    });

    Navigator.of(context, rootNavigator: true).pop('dialog');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void initState() {
    profileImg = getProfileImg();
    details = allPersonalDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: details,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data[0].status == 200) {
                  return UserAccountsDrawerHeader(
                    currentAccountPicture: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60.0),
                        color: Colors.white,
                      ),
                      child: FutureBuilder(
                        future: profileImg,
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            List<ProfileImgModal> modal = snapshot.data;
                            if (modal[0].status == 200) {
                              return InkWell(
                                onTap: () {
                                  getImageFromLocals();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(60.0),
                                  child: Image.network(
                                    modal[0].data[0].image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            } else {
                              return Icon(
                                Icons.supervisor_account_rounded,
                                color: Colors.white,
                                size: 36.0,
                              );
                            }
                          } else {
                            return CircularProgressIndicator.adaptive();
                          }
                        },
                      ),
                    ),
                    accountEmail: Text(
                      snapshot.data![0].personaldetails[0].email,
                      style: TextStyle(fontFamily: 'hanuman'),
                    ),
                    accountName: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Text(
                        snapshot.data![0].personaldetails[0].fname +
                            " " +
                            snapshot.data![0].personaldetails[0].lname,
                        style: TextStyle(
                            fontSize: 24.0, fontFamily: 'hanuman-bold'),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
              } else {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
            },
          ),
          ListTile(
              leading: Icon(Icons.home_rounded),
              title: TextFieldCus(
                  text: 'Home',
                  color: Colors.black,
                  fontSize: 18.0,
                  textAlign: TextAlign.start,
                  fontFamily: 'hanuman'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(index: 0),
                  ),
                );
              }),
          ListTile(
            leading: Icon(Icons.picture_as_pdf_rounded),
            title: TextFieldCus(
                text: 'Library',
                color: Colors.black,
                fontSize: 18.0,
                textAlign: TextAlign.start,
                fontFamily: 'hanuman'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllMaterialScreen(),
                ),
              );
            },
          ),
          ListTile(
              leading: Icon(Icons.home_rounded),
              title: TextFieldCus(
                  text: 'Course Finder',
                  color: Colors.black,
                  fontSize: 18.0,
                  textAlign: TextAlign.start,
                  fontFamily: 'hanuman'),
              onTap: () {
                launchUrl(Uri.parse(
                    "https://flywayimmigration.in/crmportal/studentcorner/direct-suggested-course.php"));
              }),
          ListTile(
            leading: Icon(Icons.privacy_tip_rounded),
            title: TextFieldCus(
                text: 'Privacy Policy',
                color: Colors.black,
                fontSize: 18.0,
                textAlign: TextAlign.start,
                fontFamily: 'hanuman'),
            onTap: () {
              launchUrl(Uri.parse(policy));
            },
          ),
          ListTile(
              leading: Icon(Icons.policy_rounded),
              title: TextFieldCus(
                  text: 'Tems of Condition',
                  color: Colors.black,
                  fontSize: 18.0,
                  textAlign: TextAlign.start,
                  fontFamily: 'hanuman'),
              onTap: () {
                launchUrl(Uri.parse(terms));
              }),
          ListTile(
            leading: Icon(Icons.share_rounded),
            title: TextFieldCus(
                text: 'Refer & Earn',
                color: Colors.black,
                fontSize: 18.0,
                textAlign: TextAlign.start,
                fontFamily: 'hanuman'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const UnderConstScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: TextFieldCus(
                text: 'Logout',
                color: Colors.black,
                fontSize: 18.0,
                textAlign: TextAlign.start,
                fontFamily: 'hanuman'),
            onTap: () {
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
          ),
        ],
      ),
    );
  }
}
