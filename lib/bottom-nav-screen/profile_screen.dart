// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, deprecated_member_use, use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/componant/loding.dart';
import 'package:student_corner/componant/main_appbar.dart';
import 'package:student_corner/componant/main_box_comp.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/all_personal_details.dart';
import 'package:student_corner/const/api.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/const/const.dart';
import 'package:student_corner/modal/all_pesonal_details.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:student_corner/modal/education_level.dart';
import 'package:student_corner/modal/profile_img_modal.dart';
import 'package:student_corner/screens/edit_education_details.dart';
import 'package:student_corner/screens/edit_personal_details.dart';
import 'package:student_corner/screens/edit_study_aboard_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class NavProfileScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffkey;
  const NavProfileScreen({Key? key, required this.scaffkey}) : super(key: key);

  @override
  State<NavProfileScreen> createState() => _NavProfileScreenState();
}

class _NavProfileScreenState extends State<NavProfileScreen> {
  List<Datum> callBackres = eduData;
  late Future<List<PersonalDetails>> details;
  late Future<List<ProfileImgModal>> profileImg;
  SharedPreferences? userSetting;
  String country1 = '';
  String country2 = '';
  Loading loading = Loading();
  @override
  void initState() {
    profileImg = getProfileImg();
    for (var i = 0; i < eduData.length; i++) {}
    details = allPersonalDetails();
    // print(callBackres[]);
    super.initState();
  }

  List<String> education = [
    'Bachelor Degree - 2021',
    '12TH - 2018',
    '10TH - 2016'
  ];

  _deleteEduDetails(id) async {
    loading.start(context);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String inquiryid = pref.getString('inqueryid')!;
      Map data = {'eduid': id, 'inquiryid': inquiryid};
      var url = Uri.parse("${APiConst.baseUrl}delete_edu_details.php");
      var response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data);
      if (response.statusCode == 200) {
        List<CommoanResponse> callBackres =
            commoanResponseFromJson(response.body);

        if (callBackres[0].status == 200) {
          setState(() {
            details = allPersonalDetails();
          });
          loading.stopDialog(context);
          // widget.scaffkey.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     callBackres[0].message.toString(),
          //   ),
          //   duration: Duration(seconds: 5),
          // ));
        } else {
          loading.stopDialog(context);
          // widget.scaffkey.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     callBackres[0].message.toString(),
          //   ),
          //   duration: Duration(seconds: 2),
          // ));
        }
      } else {
        loading.stopDialog(context);
        // widget.scaffkey.currentState!.showSnackBar(SnackBar(
        //   content: Text(
        //     'Something went wrong!',
        //   ),
        //   duration: Duration(seconds: 2),
        // ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // var uipadtop = MediaQueryData.fromWindow(ui.window).padding.top;
    // var uipadbot = MediaQueryData.fromWindow(ui.window).padding.bottom;
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kPrimaryBackGround,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'images/png/library.png',
                width: size.width,
                height: size.height * 0.45,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              MainAppbar(
                screenName: 'Profile',
                scaffkey: widget.scaffkey,
                homeIndex: 3,
              ),
              FutureBuilder<List<PersonalDetails>>(
                future: details,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    for (var i = 0; i < countryData.length; i++) {
                      if (countryData[i].id ==
                          snapshot.data![0].studyaboardpref[0].country1) {
                        country1 = countryData[i].country;
                      }
                      if (countryData[i].id ==
                          snapshot.data![0].studyaboardpref[0].country2) {
                        country2 = countryData[i].country;
                      }
                    }
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: size.width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              MainBoxComp(
                                size: size,
                                height: 105.0,
                                widgets: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 18.0),
                                          width: size.width * 0.15,
                                          height: size.width * 0.15,
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
                                                  return InkWell(
                                                    onTap: () {
                                                      getImageFromLocals();
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60.0),
                                                      child: Image.network(
                                                        modal[0].data[0].image,
                                                        fit: BoxFit.fill,
                                                      ),
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
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, top: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  fontSize: 16.0,
                                                  width: 0.40,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman-bold'),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              TextFieldCus(
                                                  text: snapshot
                                                      .data![0]
                                                      .personaldetails[0]
                                                      .mobile,
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  width: 0.40,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman-bold'),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              TextFieldCus(
                                                  text: snapshot.data![0]
                                                      .personaldetails[0].email,
                                                  color: Colors.black,
                                                  fontSize: 11.0,
                                                  width: 0.45,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman-bold'),
                                              SizedBox(
                                                height: 3.0,
                                              ),
                                              TextFieldCus(
                                                  text: snapshot
                                                          .data![0]
                                                          .personaldetails[0]
                                                          .joiningDate +
                                                      " " +
                                                      snapshot
                                                          .data![0]
                                                          .personaldetails[0]
                                                          .duration,
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  width: 0.45,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman-bold'),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 50,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10.0)),
                                                  color: kPrimary),
                                              child: TextFieldCus(
                                                  text: snapshot
                                                      .data![0]
                                                      .personaldetails[0]
                                                      .modual,
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  textAlign: TextAlign.center,
                                                  fontFamily: 'hanuman-bold'),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20.0, bottom: 5.0),
                                              alignment: Alignment.center,
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
                                                    fontSize: 15.0,
                                                    width: 0.17,
                                                    textAlign: TextAlign.center,
                                                    fontFamily: 'Hanuman-bold'),
                                              ),
                                            ),
                                            TextFieldCus(
                                                text: snapshot.data![0]
                                                    .personaldetails[0].batch,
                                                color: kPrimaryGreen,
                                                fontSize: 14.0,
                                                width: 0.2,
                                                textAlign: TextAlign.center,
                                                fontFamily: 'hanuman-bold'),
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
                              MainBoxComp(
                                size: size,
                                height: 145.0,
                                widgets: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: TextFieldCus(
                                                text: "Personal Information",
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                width: 0.75,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold'),
                                          ),
                                          Visibility(
                                            visible: true,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15.0),
                                              child: InkWell(
                                                onTap: () {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((_) =>
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  EditPersonalDetailsScreen(
                                                                      pModal: snapshot
                                                                          .data![
                                                                              0]
                                                                          .personaldetails),
                                                            ),
                                                          ));
                                                },
                                                child: Icon(
                                                  Icons.edit_note_rounded,
                                                  size: 26.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.85,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: kPrimary.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Column(
                                        children: [
                                          TextFieldCus(
                                              text:
                                                  'Name : ${snapshot.data![0].personaldetails[0].fname + " " + snapshot.data![0].personaldetails[0].lname}',
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              width: 0.8,
                                              textAlign: TextAlign.start,
                                              fontFamily: 'hanuman'),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextFieldCus(
                                                  text:
                                                      'City : ${snapshot.data![0].personaldetails[0].city}',
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  width: 0.4,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman'),
                                              TextFieldCus(
                                                  text:
                                                      'Zip Code : ${snapshot.data![0].personaldetails[0].zipcode}',
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  width: 0.4,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextFieldCus(
                                                  text:
                                                      'Gender : ${snapshot.data![0].personaldetails[0].gender}',
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  width: 0.4,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman'),
                                              TextFieldCus(
                                                  text:
                                                      'DOB : ${snapshot.data![0].personaldetails[0].dob}',
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  width: 0.4,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Container(
                                width: size.width * 0.91,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      offset: const Offset(
                                        0.0,
                                        10.0,
                                      ),
                                      blurRadius: 15.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextFieldCus(
                                              text: "Educational Information",
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              width: 0.85,
                                              textAlign: TextAlign.start,
                                              fontFamily: 'hanuman-bold'),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.85,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: kPrimary.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        width: size.width * 0.85,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            for (int position = 0;
                                                position <
                                                    snapshot
                                                        .data![0]
                                                        .educationdetails
                                                        .length;
                                                position++)
                                              // Text(position.toString()),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextFieldCus(
                                                            text: eduData[int.parse(snapshot
                                                                        .data![
                                                                            0]
                                                                        .educationdetails[
                                                                            position]
                                                                        .eduLevel) -
                                                                    1]
                                                                .level,
                                                            color: Colors.black,
                                                            fontSize: 14.0,
                                                            width: 0.65,
                                                            textAlign:
                                                                TextAlign.start,
                                                            fontFamily:
                                                                'hanuman'),
                                                        InkWell(
                                                          onTap: () {
                                                            // setState(() {
                                                            //   _deleteEduDetails(
                                                            //       snapshot
                                                            //           .data![0]
                                                            //           .educationdetails[
                                                            //               position]
                                                            //           .id);
                                                            // });
                                                            Navigator
                                                                .pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => EditEducationDetailsScreen(
                                                                    id: snapshot
                                                                        .data![
                                                                            0]
                                                                        .educationdetails[
                                                                            position]
                                                                        .id,
                                                                    details:
                                                                        snapshot
                                                                            .data,
                                                                    index:
                                                                        position),
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .edit_note_rounded,
                                                            size: 22.0,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              _deleteEduDetails(
                                                                  snapshot
                                                                      .data![0]
                                                                      .educationdetails[
                                                                          position]
                                                                      .id);
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .delete_forever_outlined,
                                                            size: 22.0,
                                                            color:
                                                                Colors.red[600],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.0),
                                                    width: size.width * 0.8,
                                                    height: 1,
                                                    decoration: BoxDecoration(
                                                      color: kPrimary
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ],
                                        )),
                                    Visibility(
                                      visible: true,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditEducationDetailsScreen(
                                                  id: '',
                                                  index: 0,
                                                ),
                                              ),
                                            );
                                          },
                                          child: TextFieldCus(
                                              text: 'Add New',
                                              color: kPrimary,
                                              fontSize: 16,
                                              width: 0.8,
                                              textAlign: TextAlign.center,
                                              fontFamily: 'hanuman-bold'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              MainBoxComp(
                                size: size,
                                height: 145.0,
                                widgets: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextFieldCus(
                                              text: "Study Aboard Preference",
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              width: 0.75,
                                              textAlign: TextAlign.start,
                                              fontFamily: 'hanuman-bold'),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditStudyAboardPrefScreen(
                                                      details: details,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                Icons.edit_note_rounded,
                                                size: 26.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.width * 0.85,
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: kPrimary.withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(1.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Column(
                                        children: [
                                          TextFieldCus(
                                              text:
                                                  'Country : ${country1 == '' ? '' : '$country1 ,'} $country2',
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              width: 0.8,
                                              textAlign: TextAlign.start,
                                              fontFamily: 'hanuman'),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          TextFieldCus(
                                              text:
                                                  'Course : ${snapshot.data![0].studyaboardpref[0].prefCourse}',
                                              color: Colors.black,
                                              fontSize: 13.0,
                                              width: 0.8,
                                              textAlign: TextAlign.start,
                                              fontFamily: 'hanuman'),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextFieldCus(
                                                  text:
                                                      'Intake : ${snapshot.data![0].studyaboardpref[0].prefIntake}',
                                                  color: Colors.black,
                                                  fontSize: 13.0,
                                                  width: 0.8,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                ),
                                child: Row(
                                  children: [
                                    TextFieldCus(
                                        text: "Need Help?",
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        width: 0.55,
                                        textAlign: TextAlign.end,
                                        fontFamily: 'Hanuman'),
                                    InkWell(
                                      onTap: () async {
                                        const url = 'tel:+918553712345';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: TextFieldCus(
                                          text: " Call Us",
                                          color: Color(0xFFEC6820),
                                          fontSize: 16.0,
                                          width: 0.45,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'Hanuman-black'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width,
                                margin: EdgeInsets.only(top: 50.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      width: size.width * 0.3,
                                      height: 0.5,
                                      color: Colors.black,
                                    ),
                                    TextFieldCus(
                                        text: 'FOLLOW US',
                                        color: Color(0xFFEC6820),
                                        fontSize: 16.0,
                                        textAlign: TextAlign.center,
                                        width: 0.34,
                                        fontFamily: 'hanuman-black'),
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      width: size.width * 0.3,
                                      height: 0.5,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 30.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await launch(facebook,
                                              universalLinksOnly: true);
                                        },
                                        child: Image.asset(
                                            "images/png/facebook.png")),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                          "images/png/instagram.png"),
                                      onTap: () async {
                                        await launch(insta,
                                            universalLinksOnly: true);
                                      },
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await launch(twitter,
                                            universalLinksOnly: true);
                                      },
                                      child:
                                          Image.asset("images/png/twitter.png"),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          await launch(youtube,
                                              universalLinksOnly: true);
                                        },
                                        child: Image.asset(
                                            "images/png/youtube.png")),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    InkWell(
                                        onTap: () async {
                                          await launch(whatsapp,
                                              universalLinksOnly: true);
                                        },
                                        child: Image.asset(
                                            "images/png/whatsapp.png")),
                                  ],
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
                        height: size.height - 55.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
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
