// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/notification_screen.dart';

class MainAppbar extends StatefulWidget {
  final String screenName;
  final int homeIndex;
  final GlobalKey<ScaffoldState> scaffkey;
  const MainAppbar(
      {Key? key,
      required this.screenName,
      required this.scaffkey,
      required this.homeIndex})
      : super(key: key);

  @override
  State<MainAppbar> createState() => _MainAppbarState();
}

class _MainAppbarState extends State<MainAppbar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 55,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                widget.scaffkey.currentState!.openDrawer();
              },
              child: Icon(
                Icons.menu_rounded,
                size: 32,
                color: kPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.only(top: 3.0),
              child: TextFieldCus(
                  text: widget.screenName,
                  color: Colors.black,
                  fontSize: 22.0,
                  textAlign: TextAlign.center,
                  fontFamily: 'Hanuman-black'),
            ),
          ),
          Expanded(
              child: Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(
                        homeIndex: widget.homeIndex,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
