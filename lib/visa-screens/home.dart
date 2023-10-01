import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/visa-screens/bottom_nav_screen/applications_nav_screen.dart';
import 'package:student_corner/visa-screens/bottom_nav_screen/home_screen.dart';
import 'package:student_corner/visa-screens/bottom_nav_screen/profile_screen.dart';
import 'package:student_corner/visa-screens/bottom_nav_screen/wishlist_nav_screen.dart';

class VisaHome extends StatefulWidget {
  const VisaHome({super.key});

  @override
  State<VisaHome> createState() => _VisaHomeState();
}

class _VisaHomeState extends State<VisaHome> {
  int curruntIndex = 0;
  String userId = '';

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString("userid") ?? '';
    });
  }

  List<Widget> bootomScreen = [
    const HomeScreenNew(),
    const ApplicationsScreenNew(),
    const WishlistScreenNew(),
    const ProfileScreenNew()
  ];
  List<String> screenName = [
    "Dashboard",
    "Applications",
    "Wishlist",
    "Account"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().primaryBackground,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Stack(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  // margin: const EdgeInsets.only(right: 25.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9).withOpacity(0.5),
                    // border: Border.all(color: CustomColors().black, width: 1),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  child: IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: CustomColors().primaryColor,
                      )),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CustomColors().red),
                  ),
                ),
              ],
            ),
          )
        ],
        centerTitle: true,
        title: CustomText(
          data: screenName[curruntIndex],
          fontSize: 20,
          color: CustomColors().primaryColor,
          fontWeight: CustomString().bold,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 28,
        currentIndex: curruntIndex,
        onTap: (value) {
          setState(() {
            curruntIndex = value;
          });
        },
        elevation: 0,
        backgroundColor: CustomColors().white,
        selectedItemColor: CustomColors().primaryColor,
        unselectedItemColor: CustomColors().grey,
        items: const [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.insert_drive_file_outlined),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.favorite_outline_rounded),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: bootomScreen[curruntIndex],
      ),
    );
  }
}
