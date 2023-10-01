import 'package:flutter/material.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/screens/new/screens/students/bottom_nav_screen/book_slot_screen.dart';
import 'package:student_corner/screens/new/screens/students/bottom_nav_screen/home_screen.dart';
import 'package:student_corner/screens/new/screens/students/bottom_nav_screen/mock_test_scree.dart';
import 'package:student_corner/screens/new/screens/students/bottom_nav_screen/profile_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int curruntIndex = 0;
  List<Widget> bootomScreen = [
    const HomeScreenNew(),
    const BookSlotScreenNew(),
    const MockTestScreen(),
    const ProfileScreenNew()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors().primaryBackground,
      appBar: AppBar(
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
            icon: Icon(Icons.notifications_outlined),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.insert_drive_file_outlined),
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
