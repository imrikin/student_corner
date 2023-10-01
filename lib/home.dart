// ignore_for_file: prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/bottom-nav-screen/home_screen.dart';
import 'package:student_corner/bottom-nav-screen/mock_test_screen.dart';
import 'package:student_corner/bottom-nav-screen/profile_screen.dart';
import 'package:student_corner/bottom-nav-screen/speaking_screen.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/drawer.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';
import 'package:student_corner/screens/new/screens/students/bottom_nav_screen/home_screen.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  const HomeScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int pageIndex;
  bool isLogin = false;
  SharedPreferences? userSetting;

  _changepage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  Future<bool> navigation() async {
    Navigator.pop(context);

    return (true);
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final GlobalKey _keyBtn = GlobalKey();

  getSharedPref() async {
    userSetting = await SharedPreferences.getInstance();
    isLogin = userSetting!.getBool("login")!;
  }

  @override
  void initState() {
    getSharedPref();
    scaffkey = _key;
    pageIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      NavHomeScreen(
        btnKey: _keyBtn,
        scaffkey: _key,
      ),
      NavSpeakingScreen(
        scaffkey: _key,
      ),
      NavMockTestScreen(
        scaffkey: _key,
      ),
      NavProfileScreen(
        scaffkey: _key,
      ),
    ];
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      // color: kPrimaryBackGround,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustomColors().primaryBackground,
        key: _key,
        appBar: pageIndex == 4
            ? AppBar(
                actions: [
                  Container(
                    width: 36,
                    height: 36,
                    margin: const EdgeInsets.only(right: 25.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColors().black, width: 1),
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.notifications_outlined,
                          size: 20,
                        )),
                  )
                ],
                centerTitle: true,
                title: CustomText(
                  data: "Home",
                  fontSize: 20,
                  color: CustomColors().blackLight,
                  fontWeight: CustomString().medium,
                ),
                leading: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    // print("object");
                  },
                  icon: Icon(
                    Icons.menu_rounded,
                    color: CustomColors().black,
                  ),
                ),
              )
            : null,
        drawer: const NavDrawer(),
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: pages[pageIndex]),
        bottomNavigationBar: NavBar(context),
      ),
    );
  }

  BottomNavigationBar NavBar(BuildContext context) {
    return BottomNavigationBar(
      key: _keyBtn,
      currentIndex: pageIndex,
      onTap: (index) {
        _changepage(index);
      },
      showUnselectedLabels: true,
      selectedItemColor: kPrimary,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            Icons.home_rounded,
            size: 28,
          ),
        ),
        const BottomNavigationBarItem(
          label: 'Slot',
          icon: Icon(
            Icons.category_rounded,
            size: 28,
          ),
        ),
        const BottomNavigationBarItem(
          label: 'Mock Test',
          icon: Icon(
            Icons.book_rounded,
            size: 28,
          ),
        ),
        const BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            Icons.supervised_user_circle_sharp,
            size: 28,
          ),
        ),
      ],
    );
  }
}
