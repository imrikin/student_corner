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

class EditEducationDetailsScreen extends StatefulWidget {
  final String id;
  final index;
  final List<PersonalDetails>? details;
  const EditEducationDetailsScreen(
      {Key? key, required this.id, this.details, required this.index})
      : super(key: key);

  @override
  State<EditEducationDetailsScreen> createState() =>
      _EditEducationDetailsScreenState();
}

class _EditEducationDetailsScreenState
    extends State<EditEducationDetailsScreen> {
  Loading loaderDialog = Loading();
  late String level;
  late String stream;
  late String institute;
  late String passYear;
  late String result;
  late String backLog;
  int level1 = 1;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // var levelData = [
  //   '10TH',
  //   '12TH',
  //   'Bachelor Degree',
  //   'Master Degree',
  //   'Diploma',
  //   'Phd'
  // ];

  List<String> leveldata1 = [];

  addDataToList() {
    for (int i = 0; i < eduData.length; i++) {
      leveldata1.add(eduData[i].level.toString());
    }
  }

  _editEduDetails(
    type,
    eduid,
    level,
    stream,
    institute,
    passyear,
    result,
    backlog,
    BuildContext context,
  ) async {
    loaderDialog.start(context);
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String inquiryid = pref.getString('inqueryid')!;
      Map data = {
        'eduid': eduid,
        'level': level,
        'stream': stream,
        'institute': institute,
        'passyear': passyear,
        'result': result,
        'backlog': backlog,
        'inquiryid': inquiryid
      };
      var url = Uri.parse("${APiConst.baseUrl}edit_edu_details.php?type=$type");
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
          Navigator.of(context, rootNavigator: true).pop('dialog');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(
                index: 3,
              ),
            ),
          );
          // _key.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     callBackres[0].message.toString(),
          //   ),
          //   duration: Duration(seconds: 5),
          // ));
        } else {
          // _key.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     callBackres[0].message.toString(),
          //   ),
          //   duration: Duration(seconds: 2),
          // ));

          Navigator.of(context, rootNavigator: true).pop('dialog');
        }
      } else {
        // _key.currentState!.showSnackBar(SnackBar(
        //   content: Text(
        //     'Something went wrong!',
        //   ),
        //   duration: Duration(seconds: 2),
        // ));
        Navigator.of(context, rootNavigator: true).pop('dialog');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    addDataToList();
    level = widget.id != ""
        ? widget.details![0].educationdetails[widget.index].eduLevel
        : eduData[0].level;
    stream = widget.id != ""
        ? widget.details![0].educationdetails[widget.index].eduStream
        : '';
    institute = widget.id != ""
        ? widget.details![0].educationdetails[widget.index].eduInstitute
        : '';
    passYear = widget.id != ""
        ? widget.details![0].educationdetails[widget.index].eduPassYear
        : '';
    result = widget.id != ""
        ? widget.details![0].educationdetails[widget.index].eduResult
        : '';
    backLog = widget.id != ""
        ? widget.details![0].educationdetails[widget.index].eduBacklog
        : '';
    super.initState();
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
                    widget.id != ""
                        ? SecondaryAppbar(
                            title: eduData[int.parse(level) - 1].level,
                            homeIndex: 3,
                          )
                        : SecondaryAppbar(
                            title: 'Add Details',
                            homeIndex: 3,
                          ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: widget.id != ''
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        TextFieldCus(
                                            text: " Level",
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            width: 0.85,
                                            textAlign: TextAlign.start,
                                            fontFamily: 'hanuman-bold'),
                                        InputBoxComp(
                                          widget: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 10.0),
                                              child: TextFormField(
                                                readOnly: true,
                                                maxLines: 1,
                                                initialValue: eduData[
                                                        int.parse(level) - 1]
                                                    .level,
                                                style: TextStyle(
                                                    fontFamily: 'Hanuman'),
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "Level",
                                                        hintStyle: TextStyle(
                                                            fontFamily:
                                                                'Hanuman',
                                                            color: Color(
                                                                0xFFB3B3B3)),
                                                        border:
                                                            InputBorder.none,
                                                        counterStyle: TextStyle(
                                                          height: double
                                                              .minPositive,
                                                        ),
                                                        counterText: ""),
                                              )),
                                          width: 0.85,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        TextFieldCus(
                                            text: " Stream",
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            width: 0.85,
                                            textAlign: TextAlign.start,
                                            fontFamily: 'hanuman-bold'),
                                        InputBoxComp(
                                          widget: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: TextFormField(
                                              maxLines: 1,
                                              onChanged: (value) {
                                                stream = value;
                                              },
                                              initialValue: stream,
                                              style: TextStyle(
                                                  fontFamily: 'Hanuman'),
                                              decoration: const InputDecoration(
                                                  hintText: "Stream",
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'Hanuman',
                                                      color: Color(0xFFB3B3B3)),
                                                  border: InputBorder.none,
                                                  counterStyle: TextStyle(
                                                    height: double.minPositive,
                                                  ),
                                                  counterText: ""),
                                            ),
                                          ),
                                          width: 0.85,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        TextFieldCus(
                                            text: " Institute",
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            width: 0.85,
                                            textAlign: TextAlign.start,
                                            fontFamily: 'hanuman-bold'),
                                        InputBoxComp(
                                          widget: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: TextFormField(
                                              maxLines: 1,
                                              onChanged: (value) {
                                                institute = value;
                                              },
                                              initialValue: institute,
                                              style: TextStyle(
                                                  fontFamily: 'Hanuman'),
                                              decoration: const InputDecoration(
                                                  hintText: "Institute",
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'Hanuman',
                                                      color: Color(0xFFB3B3B3)),
                                                  border: InputBorder.none,
                                                  counterStyle: TextStyle(
                                                    height: double.minPositive,
                                                  ),
                                                  counterText: ""),
                                            ),
                                          ),
                                          width: 0.85,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          children: [
                                            TextFieldCus(
                                                text: " Passing Year",
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                width: 0.85,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold'),
                                            InputBoxComp(
                                              widget: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  maxLines: 1,
                                                  onChanged: (value) {
                                                    passYear = value;
                                                  },
                                                  initialValue: passYear,
                                                  style: TextStyle(
                                                      fontFamily: 'Hanuman'),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Year",
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  'Hanuman',
                                                              color: Color(
                                                                  0xFFB3B3B3)),
                                                          border:
                                                              InputBorder.none,
                                                          counterStyle:
                                                              TextStyle(
                                                            height: double
                                                                .minPositive,
                                                          ),
                                                          counterText: ""),
                                                ),
                                              ),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          children: [
                                            TextFieldCus(
                                                text: " Result",
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                width: 0.85,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold'),
                                            InputBoxComp(
                                              widget: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLines: 1,
                                                  onChanged: (value) {
                                                    result = value;
                                                  },
                                                  initialValue: result,
                                                  style: TextStyle(
                                                      fontFamily: 'Hanuman'),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Result",
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  'Hanuman',
                                                              color: Color(
                                                                  0xFFB3B3B3)),
                                                          border:
                                                              InputBorder.none,
                                                          counterStyle:
                                                              TextStyle(
                                                            height: double
                                                                .minPositive,
                                                          ),
                                                          counterText: ""),
                                                ),
                                              ),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          children: [
                                            TextFieldCus(
                                                text: " No. of Backlog",
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                width: 0.85,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold'),
                                            InputBoxComp(
                                              widget: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLines: 1,
                                                  onChanged: (value) {
                                                    backLog = value;
                                                  },
                                                  initialValue: backLog,
                                                  style: TextStyle(
                                                      fontFamily: 'Hanuman'),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Backlog",
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  'Hanuman',
                                                              color: Color(
                                                                  0xFFB3B3B3)),
                                                          border:
                                                              InputBorder.none,
                                                          counterStyle:
                                                              TextStyle(
                                                            height: double
                                                                .minPositive,
                                                          ),
                                                          counterText: ""),
                                                ),
                                              ),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0, bottom: 50.0),
                                    child: InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => const HomeScreen(),
                                        //   ),
                                        // );
                                        // _editEduDetails(
                                        //     0,
                                        //     widget.id,
                                        //     level,
                                        //     stream,
                                        //     institute,
                                        //     year,
                                        //     result,
                                        //     backlog,
                                        //     context);
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
                              )
                            : Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        TextFieldCus(
                                            text: " Level",
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            width: 0.85,
                                            textAlign: TextAlign.start,
                                            fontFamily: 'hanuman-bold'),
                                        InputBoxComp(
                                          widget: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                isDense: true,
                                                isExpanded: true,
                                                hint: TextFieldCus(
                                                    text: 'Select',
                                                    color: Color.fromARGB(
                                                        255, 107, 107, 107),
                                                    fontSize: 18,
                                                    width: 0.8,
                                                    textAlign: TextAlign.start,
                                                    fontFamily: 'hanuman'),
                                                value: level,
                                                onChanged: (newValue) async {
                                                  setState(() {
                                                    level1 =
                                                        (leveldata1.indexOf(
                                                                newValue!) +
                                                            1);
                                                    level = newValue;
                                                  });
                                                },
                                                items: leveldata1
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value: items,
                                                    child: TextFieldCus(
                                                        text: items,
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        width: 0.8,
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontFamily: 'hanuman'),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                          width: 0.85,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        TextFieldCus(
                                            text: " Stream",
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            width: 0.85,
                                            textAlign: TextAlign.start,
                                            fontFamily: 'hanuman-bold'),
                                        InputBoxComp(
                                          widget: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: TextFormField(
                                              onChanged: (value) {
                                                stream = value;
                                              },
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontFamily: 'Hanuman'),
                                              decoration: const InputDecoration(
                                                  hintText: "Stream",
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'Hanuman',
                                                      color: Color(0xFFB3B3B3)),
                                                  border: InputBorder.none,
                                                  counterStyle: TextStyle(
                                                    height: double.minPositive,
                                                  ),
                                                  counterText: ""),
                                            ),
                                          ),
                                          width: 0.85,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        TextFieldCus(
                                            text: " Institute",
                                            color: Colors.black,
                                            fontSize: 13.0,
                                            width: 0.85,
                                            textAlign: TextAlign.start,
                                            fontFamily: 'hanuman-bold'),
                                        InputBoxComp(
                                          widget: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: TextFormField(
                                              maxLines: 1,
                                              onChanged: (value) {
                                                institute = value;
                                              },
                                              style: TextStyle(
                                                  fontFamily: 'Hanuman'),
                                              decoration: const InputDecoration(
                                                  hintText: "Institute",
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'Hanuman',
                                                      color: Color(0xFFB3B3B3)),
                                                  border: InputBorder.none,
                                                  counterStyle: TextStyle(
                                                    height: double.minPositive,
                                                  ),
                                                  counterText: ""),
                                            ),
                                          ),
                                          width: 0.85,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          children: [
                                            TextFieldCus(
                                                text: " Passing Year",
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                width: 0.85,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold'),
                                            InputBoxComp(
                                              widget: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  maxLines: 1,
                                                  onChanged: (value) {
                                                    passYear = value;
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Hanuman'),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Year",
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  'Hanuman',
                                                              color: Color(
                                                                  0xFFB3B3B3)),
                                                          border:
                                                              InputBorder.none,
                                                          counterStyle:
                                                              TextStyle(
                                                            height: double
                                                                .minPositive,
                                                          ),
                                                          counterText: ""),
                                                ),
                                              ),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          children: [
                                            TextFieldCus(
                                                text: " Result",
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                width: 0.85,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold'),
                                            InputBoxComp(
                                              widget: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  maxLines: 1,
                                                  onChanged: (value) {
                                                    result = value;
                                                  },
                                                  style: TextStyle(
                                                      fontFamily: 'Hanuman'),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Result",
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  'Hanuman',
                                                              color: Color(
                                                                  0xFFB3B3B3)),
                                                          border:
                                                              InputBorder.none,
                                                          counterStyle:
                                                              TextStyle(
                                                            height: double
                                                                .minPositive,
                                                          ),
                                                          counterText: ""),
                                                ),
                                              ),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          children: [
                                            TextFieldCus(
                                                text: " No. of Backlog",
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                width: 0.85,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold'),
                                            InputBoxComp(
                                              widget: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) {
                                                    backLog = value;
                                                  },
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontFamily: 'Hanuman'),
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText: "Backlog",
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  'Hanuman',
                                                              color: Color(
                                                                  0xFFB3B3B3)),
                                                          border:
                                                              InputBorder.none,
                                                          counterStyle:
                                                              TextStyle(
                                                            height: double
                                                                .minPositive,
                                                          ),
                                                          counterText: ""),
                                                ),
                                              ),
                                              width: 0.4,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width * 0.4,
                                        margin: EdgeInsets.only(top: 10.0),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25.0, bottom: 50.0),
                                    child: InkWell(
                                      onTap: () {
                                        _editEduDetails(
                                            1,
                                            '0',
                                            level1.toString(),
                                            stream,
                                            institute,
                                            passYear,
                                            result,
                                            backLog,
                                            context);
                                      },
                                      child: BtnPrimary(
                                        color: Colors.white,
                                        fontFamily: 'Hanuman-black',
                                        fontSize: 20.0,
                                        text: 'Save',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
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
