import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/modal/evaluation_modal.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';

import '../modal/speaking_details_modal.dart';

class SlotEvaluationScreen extends StatefulWidget {
  final Datum data;
  final List<EvaluationModalDatum> evaluationModalData;
  const SlotEvaluationScreen(
      {Key? key, required this.data, required this.evaluationModalData})
      : super(key: key);

  @override
  State<SlotEvaluationScreen> createState() => _SlotEvaluationScreenState();
}

class _SlotEvaluationScreenState extends State<SlotEvaluationScreen> {
  final GlobalKey _key = GlobalKey<ScaffoldState>();
  List fc = [];
  List lr = [];
  List gra = [];
  List pr = [];
  List bands = [];

  setDataBullet() {
    List dataArray = json.decode(widget.data.dataArray);
    for (var j = 0; j < dataArray.length; j++) {
      for (var k = 0; k < widget.evaluationModalData.length; k++) {
        for (var l = 0; l < widget.evaluationModalData[k].data.length; l++) {
          if (dataArray[j] == widget.evaluationModalData[k].data[l].id) {
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
  }

  @override
  void initState() {
    bands = json.decode(widget.data.bandArray);
    setDataBullet();
    super.initState();
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
                        Navigator.of(context).pop();
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
                                text: 'Module : ${widget.data.module}',
                                size: 13,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CustomText(
                                text: 'Total Band : ${widget.data.totalBand}',
                                size: 13,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: 'Slot : ${widget.data.time}',
                                size: 13,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              CustomText(
                                text: 'Date : ${widget.data.date}',
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
                                        text: "Band : ${bands[i]}",
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
