// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/profile_nav.dart';
import 'package:student_corner/screens/faculty/speaking_nav.dart';
import 'package:student_corner/screens/faculty/faculty_home.dart';
import 'package:student_corner/screens/faculty/writing_nav.dart';

class FacultyHome extends StatefulWidget {
  final int index;
  const FacultyHome({Key? key, this.index = 0}) : super(key: key);

  @override
  State<FacultyHome> createState() => _FacultyHomeState();
}

class _FacultyHomeState extends State<FacultyHome> {
  final GlobalKey _keyBtn = GlobalKey();
  int pageIndex = 1;

  _changepage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  void initState() {
    pageIndex = widget.index;
    super.initState();
  }

  final pages = [
    FacultyNavHome(),
    const FacultyNavSpeaking(),
    const FacultyNavWriting(),
    const FacultyNavProfile(),
  ];

  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        backgroundColor: kPrimaryBackGround,
        bottomNavigationBar: NavBar(context),
        body: SafeArea(
          child: pages[pageIndex],
        ),
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
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(
            Icons.home_rounded,
            size: 28,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Speaking',
          icon: Icon(
            Icons.category_rounded,
            size: 28,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Writing',
          icon: Icon(
            Icons.book_rounded,
            size: 28,
          ),
        ),
        BottomNavigationBarItem(
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
