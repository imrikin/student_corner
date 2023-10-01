// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/componant/btn_primary.dart';
import 'package:student_corner/componant/input_box_comp.dart';
import 'package:student_corner/componant/loding.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/api.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/modal/all_pesonal_details.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:http/http.dart' as http;

class EditStudyAboardPrefScreen extends StatefulWidget {
  final Future<List<PersonalDetails>> details;
  const EditStudyAboardPrefScreen({Key? key, required this.details})
      : super(key: key);

  @override
  State<EditStudyAboardPrefScreen> createState() =>
      _EditStudyAboardPrefScreenState();
}

class _EditStudyAboardPrefScreenState extends State<EditStudyAboardPrefScreen> {
  String? country1;
  String? country2;
  int? country3;
  String? course;
  String? intake;
  List<String> leveldata1 = [];
  int changes = 0;
  var countryId1;
  var countryId2;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool loader = false;

  addDataToList() {
    for (int i = 0; i < countryData.length; i++) {
      leveldata1.add(countryData[i].country.toString());
    }
  }

  @override
  void initState() {
    addDataToList();
    super.initState();
  }

  Loading loading = Loading();

  _updatePrefInfo(cotext) async {
    loading.start;
    setState(() {
      loader = true;
    });
    for (var i = 0; i < countryData.length; i++) {
      if (countryData[i].country == country1) {
        loading.stopDialog(context);
        countryId1 = countryData[i].id;
      }
      if (countryData[i].country == country2) {
        loading.stopDialog(context);
        countryId2 = countryData[i].id;
      }
      loading.stopDialog(context);
    }
    if (countryId1 == null) {
      loading.stopDialog(context);
      // _key.currentState!.showSnackBar(SnackBar(
      //   content: Text('Select Country Preferance 1'),
      //   duration: Duration(seconds: 2),
      // ));
      setState(() {
        loader = false;
      });
    } else if (countryId2 == null) {
      loading.stopDialog(context);
      // _key.currentState!.showSnackBar(SnackBar(
      //   content: Text('Select Country Preferance 2'),
      //   duration: Duration(seconds: 2),
      // ));
      setState(() {
        loader = false;
      });
    } else {
      try {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String inquiryid = pref.getString('inqueryid')!;
        Map data = {
          'country1': countryId1,
          'country2': countryId2,
          'course': course,
          'intake': intake,
          'inquiryid': inquiryid
        };
        var url =
            Uri.parse("${APiConst.baseUrl}edit_study_aboard_pref_details.php");
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
            loading.stopDialog(context);
            // _key.currentState!.showSnackBar(SnackBar(
            //   content: Text(
            //     callBackres[0].message.toString(),
            //   ),
            //   action: SnackBarAction(
            //       label: 'Home',
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => HomeScreen(
            //               index: 3,
            //             ),
            //           ),
            //         );
            //       }),
            //   duration: Duration(seconds: 5),
            // ));
            setState(() {
              loader = false;
            });
          } else {
            loading.stopDialog(context);
            // _key.currentState!.showSnackBar(SnackBar(
            //   content: Text(
            //     callBackres[0].message.toString(),
            //   ),
            //   duration: Duration(seconds: 2),
            // ));
          }
          setState(() {
            loader = false;
          });
        } else {
          loading.stopDialog(context);
          // _key.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     'Something went wrong!',
          //   ),
          //   duration: Duration(seconds: 2),
          // ));
        }
        setState(() {
          loader = false;
        });
      } catch (e) {
        loading.stopDialog(context);
        log(e.toString());
        setState(() {
          loader = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(index: 3),
            ));
        return Future.value(true);
      },
      child: Scaffold(
        key: _key,
        body: SafeArea(
          child: Container(
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
                    SecondaryAppbar(
                      title: 'Study Aboard Details',
                      homeIndex: 3,
                    ),
                    Expanded(
                      child: Container(
                        child: loader
                            ? CircularProgressIndicator.adaptive()
                            : FutureBuilder(
                                future: widget.details,
                                builder: (BuildContext context,
                                    AsyncSnapshot<dynamic> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data[0].status == 200) {
                                      if (changes == 0) {
                                        for (var i = 0;
                                            i < countryData.length;
                                            i++) {
                                          if (countryData[i].id ==
                                              snapshot
                                                  .data![0]
                                                  .studyaboardpref[0]
                                                  .country1) {
                                            country1 = countryData[i].country;
                                          }
                                          if (countryData[i].id ==
                                              snapshot
                                                  .data![0]
                                                  .studyaboardpref[0]
                                                  .country2) {
                                            country2 = countryData[i].country;
                                          }
                                        }
                                      }
                                      course = snapshot.data![0]
                                          .studyaboardpref[0].prefCourse;
                                      intake = snapshot.data![0]
                                          .studyaboardpref[0].prefIntake;

                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0),
                                                  width: size.width * 0.4,
                                                  child: Column(
                                                    children: [
                                                      TextFieldCus(
                                                          text:
                                                              " Country Pref 1",
                                                          color: Colors.black,
                                                          fontSize: 13.0,
                                                          width: 0.85,
                                                          textAlign:
                                                              TextAlign.start,
                                                          fontFamily:
                                                              'hanuman-bold'),
                                                      InputBoxComp(
                                                        widget: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                isDense: true,
                                                                isExpanded:
                                                                    true,
                                                                hint: TextFieldCus(
                                                                    text:
                                                                        'Select',
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            107,
                                                                            107,
                                                                            107),
                                                                    fontSize:
                                                                        18,
                                                                    width: 0.8,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    fontFamily:
                                                                        'hanuman'),
                                                                value: country1,
                                                                onChanged:
                                                                    (newValue) async {
                                                                  setState(() {
                                                                    changes = 1;
                                                                    country1 =
                                                                        newValue;
                                                                  });
                                                                },
                                                                items: leveldata1
                                                                    .map((String
                                                                        items) {
                                                                  return DropdownMenuItem(
                                                                    value:
                                                                        items,
                                                                    child: TextFieldCus(
                                                                        text:
                                                                            items,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18.0,
                                                                        width:
                                                                            0.8,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        fontFamily:
                                                                            'hanuman'),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            )),
                                                        width: 0.85,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10.0),
                                                  width: size.width * 0.4,
                                                  child: Column(
                                                    children: [
                                                      TextFieldCus(
                                                          text:
                                                              " Country Pref 2",
                                                          color: Colors.black,
                                                          fontSize: 13.0,
                                                          width: 0.85,
                                                          textAlign:
                                                              TextAlign.start,
                                                          fontFamily:
                                                              'hanuman-bold'),
                                                      InputBoxComp(
                                                        widget: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0,
                                                                    right:
                                                                        10.0),
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton<
                                                                      String>(
                                                                isDense: true,
                                                                isExpanded:
                                                                    true,
                                                                hint: TextFieldCus(
                                                                    text:
                                                                        'Select',
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            107,
                                                                            107,
                                                                            107),
                                                                    fontSize:
                                                                        18,
                                                                    width: 0.8,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    fontFamily:
                                                                        'hanuman'),
                                                                value: country2,
                                                                onChanged:
                                                                    (newValue) async {
                                                                  setState(() {
                                                                    changes = 1;
                                                                    country2 =
                                                                        newValue;
                                                                  });
                                                                },
                                                                items: leveldata1
                                                                    .map((String
                                                                        items) {
                                                                  return DropdownMenuItem(
                                                                    value:
                                                                        items,
                                                                    child: TextFieldCus(
                                                                        text:
                                                                            items,
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            18.0,
                                                                        width:
                                                                            0.8,
                                                                        textAlign:
                                                                            TextAlign
                                                                                .start,
                                                                        fontFamily:
                                                                            'hanuman'),
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            )),
                                                        width: 0.85,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Column(
                                                children: [
                                                  TextFieldCus(
                                                      text: " Course",
                                                      color: Colors.black,
                                                      fontSize: 13.0,
                                                      width: 0.85,
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontFamily:
                                                          'hanuman-bold'),
                                                  InputBoxComp(
                                                    widget: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: TextFormField(
                                                        maxLines: 1,
                                                        onChanged: (value) {
                                                          course = value;
                                                        },
                                                        initialValue: course,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Hanuman'),
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    "Course",
                                                                hintStyle: TextStyle(
                                                                    fontFamily:
                                                                        'Hanuman',
                                                                    color: Color(
                                                                        0xFFB3B3B3)),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                counterStyle:
                                                                    TextStyle(
                                                                  height: double
                                                                      .minPositive,
                                                                ),
                                                                counterText:
                                                                    ""),
                                                      ),
                                                    ),
                                                    width: 0.85,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(top: 10.0),
                                              child: Column(
                                                children: [
                                                  TextFieldCus(
                                                      text: " Intake",
                                                      color: Colors.black,
                                                      fontSize: 13.0,
                                                      width: 0.85,
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontFamily:
                                                          'hanuman-bold'),
                                                  InputBoxComp(
                                                    widget: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: TextFormField(
                                                        maxLines: 1,
                                                        onChanged: (value) {
                                                          intake = value;
                                                        },
                                                        initialValue: intake,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Hanuman'),
                                                        decoration:
                                                            const InputDecoration(
                                                                hintText:
                                                                    "Intake",
                                                                hintStyle: TextStyle(
                                                                    fontFamily:
                                                                        'Hanuman',
                                                                    color: Color(
                                                                        0xFFB3B3B3)),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                counterStyle:
                                                                    TextStyle(
                                                                  height: double
                                                                      .minPositive,
                                                                ),
                                                                counterText:
                                                                    ""),
                                                      ),
                                                    ),
                                                    width: 0.85,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, bottom: 50.0),
                                              child: InkWell(
                                                onTap: () {
                                                  _updatePrefInfo(context);
                                                },
                                                child: BtnPrimary(
                                                  color: Colors.white,
                                                  fontFamily: 'Hanuman-black',
                                                  fontSize: 20.0,
                                                  text: 'Update',
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator
                                          .adaptive();
                                    }
                                  } else {
                                    return CircularProgressIndicator.adaptive();
                                  }
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
