// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/componant/loding.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:student_corner/screens/faculty/home.dart';
import 'package:student_corner/screens/faculty/http/client.dart';
import 'package:student_corner/screens/faculty/modal/student_list_modal.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:http/http.dart' as http;

import 'modal/evaluation_modal.dart';

class VerifyScoreScreen extends StatefulWidget {
  final int module;
  final String slotID;
  final Datum studentList;
  final List selectedBox;
  final List<String> bandList;
  final List<EvaluationModalDatum> evaluationModalData;
  const VerifyScoreScreen(
      {Key? key,
      required this.module,
      required this.studentList,
      required this.selectedBox,
      required this.bandList,
      required this.evaluationModalData,
      required this.slotID})
      : super(key: key);

  @override
  State<VerifyScoreScreen> createState() => _VerifyScoreScreenState();
}

class _VerifyScoreScreenState extends State<VerifyScoreScreen> {
  final GlobalKey _key = GlobalKey<ScaffoldState>();
  double totalBand = 0.0;
  double tempBandSum = 0.0;
  String finalBandScore = '';

  List<String> fc = [];
  List<String> lr = [];
  List<String> gra = [];
  List<String> pr = [];
  @override
  void initState() {
    for (var i = 0; i < widget.bandList.length; i++) {
      tempBandSum = tempBandSum + double.parse(widget.bandList[i]);
    }
    totalBand = tempBandSum / 4;
    totalBand = double.parse(totalBand.toStringAsFixed(2));
    String tempBand = totalBand.toString().split('.')[1];
    String tempBandBeforeDot = totalBand.toString().split('.')[0];

    if (int.parse(tempBand) < 25) {
      finalBandScore = '$tempBandBeforeDot.0';
    } else if (int.parse(tempBand) >= 25 && int.parse(tempBand) < 75) {
      finalBandScore = '$tempBandBeforeDot.5';
    } else if (int.parse(tempBand) >= 75) {
      int tempPreBand = int.parse(tempBandBeforeDot) + 1;
      finalBandScore = '$tempPreBand.0';
    }

    for (var j = 0; j < widget.selectedBox.length; j++) {
      for (var k = 0; k < widget.evaluationModalData.length; k++) {
        for (var l = 0; l < widget.evaluationModalData[k].data.length; l++) {
          if (widget.selectedBox[j] ==
              widget.evaluationModalData[k].data[l].id) {
            switch (k) {
              case 0:
                fc.add(widget.evaluationModalData[k].data[l].title);
                break;
              case 1:
                lr.add(widget.evaluationModalData[k].data[l].title);
                break;
              case 2:
                gra.add(widget.evaluationModalData[k].data[l].title);
                break;
              case 3:
                pr.add(widget.evaluationModalData[k].data[l].title);
                break;
              default:
                fc = [];
                lr = [];
                gra = [];
                pr = [];
                break;
            }
          }
        }
      }
    }

    super.initState();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Hanuman',
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        "Submit",
        style: TextStyle(
            color: Colors.red,
            fontFamily: 'Hanuman',
            fontWeight: FontWeight.w500),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
        addSlotResult(
            widget.slotID, finalBandScore, widget.bandList, widget.selectedBox);

        // print(addData[0].message.toString());
        // _deleteSpeakingSlot(id, context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Are you sure?"),
      content: const Text("Would you like to submit this result!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  addSlotResult(slotId, totalBand, bandArray, dataArray) async {
    Loading loading = Loading();
    loading.start(context);
    SharedPreferences userSetting = await SharedPreferences.getInstance();
    String addedBy = userSetting.getString('inqueryid')!;
    Map data = {
      'slotId': slotId,
      'totalBand': totalBand,
      'bandArray': json.encode(bandArray),
      'dataArray': json.encode(dataArray),
      'addedBy': addedBy,
    };

    // print(data.toString());

    var url = Uri.parse("${APiConst.baseUrlFlyway}update_slot_data.php");
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      List<CommoanResponse> apiResponse =
          commoanResponseFromJson(response.body);
      if (apiResponse[0].success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(apiResponse[0].message),
        ));
        Future.delayed(
            const Duration(milliseconds: 5000),
            () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          FacultyHome(index: widget.module == 0 ? 1 : 2)),
                ));
        loading.stopDialog(context);
      } else {
        loading.stopDialog(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(apiResponse[0].message),
        ));
      }
      // print(apiResponse[0].message);
      return apiResponse;
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: 55,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 55,
                        height: 55,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: kPrimary,
                          ),
                        ),
                      ),
                      const CustomText(
                        text: "Verify Score",
                        fontfamily: 'Hanuman-bold',
                        size: 20,
                      ),
                    ],
                  ),
                  Positioned(
                    right: 20,
                    child: InkWell(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: const CustomText(
                        text: 'Done',
                        color: kPrimary,
                        fontfamily: "Hanuman-black",
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Name : ${widget.studentList.name}',
                                size: 13,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CustomText(
                                text: 'Roll No. : ${widget.studentList.rollNo}',
                                size: 13,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CustomText(
                                text:
                                    'Module : ${widget.module == 0 ? 'Speaking' : 'Writing'}',
                                size: 13,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: 'Total Band : $finalBandScore',
                                size: 13,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CustomText(
                                text: 'Slot : ${widget.studentList.time}',
                                size: 13,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CustomText(
                                text: 'Date : ${widget.studentList.date}',
                                size: 13,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 15.0),
                      child: Column(
                        children: [
                          for (int i = 0;
                              i < widget.evaluationModalData.length;
                              i++)
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.9 - 90,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: CustomText(
                                          text: widget
                                              .evaluationModalData[i].title,
                                          size: 15,
                                          fontfamily: 'Hanuman-bold',
                                        ),
                                      ),
                                      CustomText(
                                        text:
                                            "Band : ${widget.bandList[i].toString()}",
                                        size: 12,
                                      )
                                    ],
                                  ),
                                  Builder(builder: (context) {
                                    switch (i) {
                                      case 0:
                                        return Column(
                                          children: bulletData(width, fc),
                                        );
                                      case 1:
                                        return Column(
                                          children: bulletData(width, lr),
                                        );
                                      case 2:
                                        return Column(
                                          children: bulletData(width, gra),
                                        );
                                      case 3:
                                        return Column(
                                          children: bulletData(width, pr),
                                        );
                                      default:
                                        return const CustomText(
                                            text: 'Error in looping!!');
                                    }
                                    // return BulletData(width: width);
                                  }),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> bulletData(double width, List list) {
  List<Widget> element = [];

  for (int i = 0; i < list.length; i++) {
    element.add(
      Container(
        width: width * 0.85,
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black87,
              ),
            ),
            Flexible(
              child: CustomText(size: 12, text: list[i]),
            )
          ],
        ),
      ),
    );
  }
  return element;
}
