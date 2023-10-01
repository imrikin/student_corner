// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'dart:ui' as ui;
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/componant/main_appbar.dart';
import 'package:student_corner/componant/main_box_comp.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/all_personal_details.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/modal/all_mock_test_modal.dart';
import 'package:student_corner/modal/all_pesonal_details.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:student_corner/modal/profile_img_modal.dart';

class NavHomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffkey;
  final GlobalKey btnKey;
  const NavHomeScreen({
    Key? key,
    required this.scaffkey,
    required this.btnKey,
  }) : super(key: key);

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  late Future<List<PersonalDetails>> details;
  late Future<List<AllMockTestModal>> detailsMockTest0;
  late Future<List<AllMockTestModal>> detailsMockTest1;
  late Future<List<CommoanResponse>> percent;
  late Future<List<ProfileImgModal>> profileImg;
  SharedPreferences? pref;
  var inquiryId;
  @override
  void initState() {
    // secureScreen();
    getPref();
    profileImg = getProfileImg();
    details = allPersonalDetails();
    percent = profilePercent();
    detailsMockTest0 = allMockTest("mock_test_details_home.php?type=0");
    detailsMockTest1 = allMockTest("mock_test_details_home.php?type=1");
    super.initState();
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  getPref() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var uipadtop = MediaQueryData.fromWindow(ui.window).padding.top;
    var uipadbot = MediaQueryData.fromWindow(ui.window).padding.bottom;
    Size size123 = MediaQuery.of(context).size;
    return Container(
      // height: size123.height - 100,
      color: kPrimaryBackGround,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'images/png/library.png',
                width: size123.width,
                height: size123.height * 0.45,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              MainAppbar(
                screenName: 'Home',
                scaffkey: widget.scaffkey,
                homeIndex: 0,
              ),
              FutureBuilder<List<PersonalDetails>>(
                future: details,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    pref!.setString(
                        'email', snapshot.data![0].personaldetails[0].email);
                    pref!.setString(
                        'name',
                        snapshot.data![0].personaldetails[0].fname +
                            " " +
                            snapshot.data![0].personaldetails[0].lname);
                    pref!.setString(
                        'rollno', snapshot.data![0].personaldetails[0].rollNo);
                    pref!.setString(
                        'mobile', snapshot.data![0].personaldetails[0].mobile);

                    return SingleChildScrollView(
                      child: SizedBox(
                        width: size123.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: percent,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data[0].status == 200) {
                                      double circuler = int.parse(
                                              snapshot.data[0].inquiryId) /
                                          100;
                                      return Container(
                                        margin: EdgeInsets.only(top: 15.0),
                                        width: size123.width,
                                        height: 100.0,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 100.0,
                                              width: size123.width * 0.8,
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              alignment: Alignment.center,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  TextFieldCus(
                                                      text:
                                                          "Complete Your Profile",
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      width: 0.6,
                                                      textAlign:
                                                          TextAlign.center,
                                                      fontFamily: 'hanuman'),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(
                                                            index: 3,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: TextFieldCus(
                                                          text: " Finish Now",
                                                          color: kPrimary,
                                                          fontSize: 20.0,
                                                          width: 0.6,
                                                          textAlign:
                                                              TextAlign.center,
                                                          fontFamily:
                                                              'hanuman-black'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              right: 10.0,
                                              top: 38.0,
                                              height: 80.0,
                                              width: 80.0,
                                              child: GFProgressBar(
                                                  percentage: circuler,
                                                  width: 80,
                                                  radius: 78,
                                                  animation: true,
                                                  circleWidth: 10.0,
                                                  type: GFProgressType.circular,
                                                  backgroundColor:
                                                      Colors.black26,
                                                  progressBarColor: kPrimary
                                                      .withOpacity(0.9)),
                                            ),
                                            Positioned(
                                              right: 20.0,
                                              top: 30.0,
                                              child: TextFieldCus(
                                                  text:
                                                      "${snapshot.data[0].inquiryId} %",
                                                  color: kPrimary,
                                                  fontSize: 18.0,
                                                  width: 0.15,
                                                  textAlign: TextAlign.center,
                                                  fontFamily: 'hanuman-black'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Visibility(child: Container());
                                    }
                                  } else {
                                    return Visibility(child: Container());
                                  }
                                },
                              ),
                              MainBoxComp(
                                size: size123,
                                height: 100.0,
                                widgets: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: (size123.width * 0.9) - 50,
                                          height: 20,
                                        ),
                                        Container(
                                          width: 50,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0)),
                                              color: kPrimary),
                                          child: TextFieldCus(
                                              text: snapshot.data![0]
                                                  .personaldetails[0].modual,
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              textAlign: TextAlign.center,
                                              fontFamily: 'hanuman-bold'),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            getImageFromLocals();
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(left: 18.0),
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(60.0),
                                              color: kPrimary.withOpacity(0.7),
                                            ),
                                            child: FutureBuilder(
                                              future: profileImg,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<dynamic>
                                                      snapshot) {
                                                if (snapshot.hasData) {
                                                  List<ProfileImgModal> modal =
                                                      snapshot.data;
                                                  if (modal[0].status == 200) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60.0),
                                                      child: Image.network(
                                                        modal[0].data[0].image,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    );
                                                  } else {
                                                    return Icon(
                                                      Icons
                                                          .supervisor_account_rounded,
                                                      color: Colors.white,
                                                      size: 36.0,
                                                    );
                                                  }
                                                } else {
                                                  return CircularProgressIndicator
                                                      .adaptive();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 15.0,
                                          ),
                                          child: Column(
                                            children: [
                                              TextFieldCus(
                                                  text: snapshot
                                                          .data![0]
                                                          .personaldetails[0]
                                                          .fname +
                                                      " " +
                                                      snapshot
                                                          .data![0]
                                                          .personaldetails[0]
                                                          .lname,
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  width: 0.40,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman-bold'),
                                              TextFieldCus(
                                                  text: snapshot
                                                      .data![0]
                                                      .personaldetails[0]
                                                      .mobile,
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                  width: 0.40,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman-bold'),
                                              TextFieldCus(
                                                  text: snapshot
                                                              .data![0]
                                                              .personaldetails[
                                                                  0]
                                                              .isCoching ==
                                                          '1'
                                                      ? "In-Coaching"
                                                      : "Coaching",
                                                  color: kPrimaryGreen,
                                                  fontSize: 14.0,
                                                  width: 0.40,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman-bold'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              decoration: BoxDecoration(
                                                color: kPrimary,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 8.0),
                                                child: TextFieldCus(
                                                    text: snapshot
                                                        .data![0]
                                                        .personaldetails[0]
                                                        .rollNo,
                                                    color: Colors.white,
                                                    fontSize: 16.0,
                                                    width: 0.17,
                                                    textAlign: TextAlign.center,
                                                    fontFamily: 'Hanuman-bold'),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Visibility(
                                visible: false,
                                child: MainBoxComp(
                                  size: size123,
                                  height: 175,
                                  widgets: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: TextFieldCus(
                                                text: "Speaking Details",
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                width: 0.8,
                                                textAlign: TextAlign.center,
                                                fontFamily: 'Hanuman-black'),
                                          ),
                                          Container(
                                            width: size123.width * 0.8,
                                            height: 2,
                                            decoration: BoxDecoration(
                                                color:
                                                    kPrimary.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1.0)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.0),
                                        width: size123.width * 0.8,
                                        child: Row(
                                          children: [
                                            TextFieldCus(
                                                text: "Upcoming Slot :",
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.3,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'Hanuman-black'),
                                            TextFieldCus(
                                                text: "22th May 11:00 to 11:15",
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.5,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'Hanuman')
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 7.0),
                                        width: size123.width * 0.8,
                                        child: Row(
                                          children: [
                                            TextFieldCus(
                                                text: "Last Slot :",
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.3,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'Hanuman-black'),
                                            TextFieldCus(
                                                text: "22th May 11:00 to 11:15",
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.5,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'Hanuman')
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 12.0, bottom: 12.0),
                                        width: size123.width * 0.8,
                                        child: InkWell(
                                          onTap: () {
                                            final BottomNavigationBar
                                                navigationBar =
                                                widget.btnKey.currentWidget
                                                    as BottomNavigationBar;
                                            navigationBar.onTap!(1);
                                          },
                                          child: TextFieldCus(
                                              text: "Book A Slot Now",
                                              color: kPrimary,
                                              fontSize: 14.0,
                                              textAlign: TextAlign.center,
                                              fontFamily: 'hanuman-black'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              FutureBuilder(
                                future: detailsMockTest0,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data![0].status == 200) {
                                      return MainBoxComp(
                                        size: size123,
                                        height: 185.0,
                                        widgets: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: TextFieldCus(
                                                  text: "Mock Test Result",
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  width: 0.8,
                                                  textAlign: TextAlign.center,
                                                  fontFamily: 'Hanuman-black'),
                                            ),
                                            Container(
                                              width: size123.width * 0.8,
                                              height: 2,
                                              decoration: BoxDecoration(
                                                color:
                                                    kPrimary.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1.0),
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              width: size123.width * 0.8,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: size123.width * 0.5,
                                                    child: Row(
                                                      children: [
                                                        TextFieldCus(
                                                            text:
                                                                "Overall Band :",
                                                            color: Colors.black,
                                                            fontSize: 16.0,
                                                            width: 0.33,
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontFamily:
                                                                'hanuman'),
                                                        TextFieldCus(
                                                            text: snapshot
                                                                .data![0]
                                                                .data[0]
                                                                .overall,
                                                            color: kPrimary,
                                                            fontSize: 16.0,
                                                            width: 0.15,
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontFamily:
                                                                'hanuman-black'),
                                                      ],
                                                    ),
                                                  ),
                                                  TextFieldCus(
                                                      text: snapshot.data![0]
                                                          .data[0].date,
                                                      color: Colors.black,
                                                      fontSize: 12.0,
                                                      width: 0.3,
                                                      textAlign: TextAlign.end,
                                                      fontFamily: 'hanuman')
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              width: size123.width * 0.8,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: size123.width * 0.4,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .headphones_rounded,
                                                          color: kPrimary
                                                              .withOpacity(0.9),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0,
                                                                  left: 5.0),
                                                          child: TextFieldCus(
                                                              text:
                                                                  "Listening :",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontFamily:
                                                                  'hanuman'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0),
                                                          child: TextFieldCus(
                                                              text: snapshot
                                                                  .data![0]
                                                                  .data[0]
                                                                  .listening,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.07,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              fontFamily:
                                                                  'hanuman-black'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size123.width * 0.4,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.book_rounded,
                                                          color: kPrimary
                                                              .withOpacity(0.9),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0,
                                                                  left: 5.0),
                                                          child: TextFieldCus(
                                                              text: "Reading :",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontFamily:
                                                                  'hanuman'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0),
                                                          child: TextFieldCus(
                                                              text: snapshot
                                                                  .data![0]
                                                                  .data[0]
                                                                  .reading,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.07,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              fontFamily:
                                                                  'hanuman-black'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              width: size123.width * 0.8,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: size123.width * 0.4,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.menu_book,
                                                          color: kPrimary
                                                              .withOpacity(0.9),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0,
                                                                  left: 5.0),
                                                          child: TextFieldCus(
                                                              text: "Writing :",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontFamily:
                                                                  'hanuman'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0),
                                                          child: TextFieldCus(
                                                              text: snapshot
                                                                  .data![0]
                                                                  .data[0]
                                                                  .writing,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.07,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              fontFamily:
                                                                  'hanuman-black'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size123.width * 0.4,
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.mic_rounded,
                                                          color: kPrimary
                                                              .withOpacity(0.9),
                                                          size: 24,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0,
                                                                  left: 5.0),
                                                          child: TextFieldCus(
                                                              text:
                                                                  "Speaking :",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontFamily:
                                                                  'hanuman'),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 3.0),
                                                          child: TextFieldCus(
                                                              text: snapshot
                                                                  .data![0]
                                                                  .data[0]
                                                                  .speaking,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12.0,
                                                              width: 0.07,
                                                              textAlign:
                                                                  TextAlign.end,
                                                              fontFamily:
                                                                  'hanuman-black'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return MainBoxComp(
                                        size: size123,
                                        height: 175.0,
                                        widgets: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: TextFieldCus(
                                                  text: "Mock Test Result",
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  width: 0.8,
                                                  textAlign: TextAlign.center,
                                                  fontFamily: 'Hanuman-black'),
                                            ),
                                            Container(
                                              width: size123.width * 0.8,
                                              height: 2,
                                              decoration: BoxDecoration(
                                                color:
                                                    kPrimary.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1.0),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: TextFieldCus(
                                                    text: 'No details found!!',
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    textAlign: TextAlign.center,
                                                    width: size123.width * 0.91,
                                                    fontFamily: 'hanuman'),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  } else {
                                    return MainBoxComp(
                                      size: size123,
                                      height: 175.0,
                                      widgets: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: TextFieldCus(
                                                text: "Mock Test Result",
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                width: 0.8,
                                                textAlign: TextAlign.center,
                                                fontFamily: 'Hanuman-black'),
                                          ),
                                          Container(
                                            width: size123.width * 0.8,
                                            height: 2,
                                            decoration: BoxDecoration(
                                              color: kPrimary.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(1.0),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextFieldCus(
                                                text: 'Something Went Wrong!!',
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                textAlign: TextAlign.center,
                                                width: size123.width * 0.91,
                                                fontFamily: 'hanuman'),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: FutureBuilder(
                                  future: detailsMockTest1,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data![0].status == 200) {
                                        return MainBoxComp(
                                          size: size123,
                                          height: 185.0,
                                          widgets: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: TextFieldCus(
                                                    text: "Best Performance",
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    width: 0.8,
                                                    textAlign: TextAlign.center,
                                                    fontFamily:
                                                        'Hanuman-black'),
                                              ),
                                              Container(
                                                width: size123.width * 0.8,
                                                height: 2,
                                                decoration: BoxDecoration(
                                                  color:
                                                      kPrimary.withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                width: size123.width * 0.8,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          size123.width * 0.5,
                                                      child: Row(
                                                        children: [
                                                          TextFieldCus(
                                                              text:
                                                                  "Overall Band :",
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16.0,
                                                              width: 0.33,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontFamily:
                                                                  'hanuman'),
                                                          TextFieldCus(
                                                              text: snapshot
                                                                  .data![0]
                                                                  .data[0]
                                                                  .overall,
                                                              color: kPrimary,
                                                              fontSize: 16.0,
                                                              width: 0.15,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              fontFamily:
                                                                  'hanuman-black'),
                                                        ],
                                                      ),
                                                    ),
                                                    TextFieldCus(
                                                        text: snapshot.data![0]
                                                            .data[0].date,
                                                        color: Colors.black,
                                                        fontSize: 12.0,
                                                        width: 0.3,
                                                        textAlign:
                                                            TextAlign.end,
                                                        fontFamily: 'hanuman')
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                width: size123.width * 0.8,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          size123.width * 0.4,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .headphones_rounded,
                                                            color: kPrimary
                                                                .withOpacity(
                                                                    0.9),
                                                            size: 24,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0,
                                                                    left: 5.0),
                                                            child: TextFieldCus(
                                                                text:
                                                                    "Listening :",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                fontFamily:
                                                                    'hanuman'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0),
                                                            child: TextFieldCus(
                                                                text: snapshot
                                                                    .data![0]
                                                                    .data[0]
                                                                    .listening,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.07,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                fontFamily:
                                                                    'hanuman-black'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          size123.width * 0.4,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.book_rounded,
                                                            color: kPrimary
                                                                .withOpacity(
                                                                    0.9),
                                                            size: 24,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0,
                                                                    left: 5.0),
                                                            child: TextFieldCus(
                                                                text:
                                                                    "Reading :",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                fontFamily:
                                                                    'hanuman'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0),
                                                            child: TextFieldCus(
                                                                text: snapshot
                                                                    .data![0]
                                                                    .data[0]
                                                                    .reading,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.07,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                fontFamily:
                                                                    'hanuman-black'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                width: size123.width * 0.8,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          size123.width * 0.4,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.menu_book,
                                                            color: kPrimary
                                                                .withOpacity(
                                                                    0.9),
                                                            size: 24,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0,
                                                                    left: 5.0),
                                                            child: TextFieldCus(
                                                                text:
                                                                    "Writing :",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                fontFamily:
                                                                    'hanuman'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0),
                                                            child: TextFieldCus(
                                                                text: snapshot
                                                                    .data![0]
                                                                    .data[0]
                                                                    .writing,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.07,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                fontFamily:
                                                                    'hanuman-black'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          size123.width * 0.4,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.mic_rounded,
                                                            color: kPrimary
                                                                .withOpacity(
                                                                    0.9),
                                                            size: 24,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0,
                                                                    left: 5.0),
                                                            child: TextFieldCus(
                                                                text:
                                                                    "Speaking :",
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.2,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                fontFamily:
                                                                    'hanuman'),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 3.0),
                                                            child: TextFieldCus(
                                                                text: snapshot
                                                                    .data![0]
                                                                    .data[0]
                                                                    .speaking,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 12.0,
                                                                width: 0.07,
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                fontFamily:
                                                                    'hanuman-black'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return MainBoxComp(
                                          size: size123,
                                          height: 175.0,
                                          widgets: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8.0),
                                                child: TextFieldCus(
                                                    text: "Best Performance",
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    width: 0.8,
                                                    textAlign: TextAlign.center,
                                                    fontFamily:
                                                        'Hanuman-black'),
                                              ),
                                              Container(
                                                width: size123.width * 0.8,
                                                height: 2,
                                                decoration: BoxDecoration(
                                                  color:
                                                      kPrimary.withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.0),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: TextFieldCus(
                                                      text:
                                                          'No details found!!',
                                                      color: Colors.black,
                                                      fontSize: 14.0,
                                                      textAlign:
                                                          TextAlign.center,
                                                      width:
                                                          size123.width * 0.91,
                                                      fontFamily: 'hanuman'),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    } else {
                                      return MainBoxComp(
                                        size: size123,
                                        height: 175.0,
                                        widgets: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: TextFieldCus(
                                                  text: "Best Performance",
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  width: 0.8,
                                                  textAlign: TextAlign.center,
                                                  fontFamily: 'Hanuman-black'),
                                            ),
                                            Container(
                                              width: size123.width * 0.8,
                                              height: 2,
                                              decoration: BoxDecoration(
                                                color:
                                                    kPrimary.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(1.0),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextFieldCus(
                                                  text:
                                                      'Something Went Wrong!!',
                                                  color: Colors.black,
                                                  fontSize: 14.0,
                                                  textAlign: TextAlign.center,
                                                  width: size123.width * 0.91,
                                                  fontFamily: 'hanuman'),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: SizedBox(
                        height: size123.height - uipadtop - uipadbot - 55.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
