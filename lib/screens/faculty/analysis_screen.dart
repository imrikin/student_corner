import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/home.dart';
import 'package:student_corner/screens/faculty/modal/evaluation_modal.dart';
import 'package:student_corner/screens/faculty/modal/student_list_modal.dart';
import 'package:student_corner/screens/faculty/verify_score.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';

import 'http/client.dart';

class AnalysisScreen extends StatefulWidget {
  final String studentName;
  final String slotId;
  final int module;
  final Datum studentDetails;
  const AnalysisScreen(
      {Key? key,
      required this.module,
      required this.studentName,
      required this.studentDetails,
      required this.slotId})
      : super(key: key);

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen>
    with SingleTickerProviderStateMixin {
  List<bool> checked = [false, false, false, false, false, false];
  late TabController _tabController;
  late Future<List<EvaluationModal>> modalDetails;
  List selectedBox = [];
  final GlobalKey _newKey = GlobalKey<ScaffoldState>();

  List<String> bandList = ['', '', '', ""];
  @override
  void initState() {
    modalDetails = evaluationDetails(widget.module);
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  selectedBoxAddAndRemove(value) {
    if (selectedBox.contains(value)) {
      selectedBox.remove(value);
    } else {
      selectedBox.add(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FacultyHome(
              index: 1,
            ),
          ),
        );
        return Future.value(true);
      },
      child: FutureBuilder(
        future: modalDetails,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<EvaluationModal> modal = snapshot.data;
            List<String> tabTitle = [];
            addDataToBandList(value, i) {
              if (bandList.asMap().containsKey(i)) {
                setState(() {
                  bandList[i] = value;
                });
              } else {
                setState(() {
                  bandList.insert(i, value);
                });
              }
            }

            for (var i = 0; i < modal[0].data.length; i++) {
              tabTitle.add(modal[0].data[i].title);
            }

            if (modal[0].success) {
              return Scaffold(
                key: _newKey,
                appBar: AppBar(
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: kPrimary,
                    labelColor: kPrimary,
                    automaticIndicatorColorAdjustment: true,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'semiBold',
                    ),
                    tabs: [
                      for (int i = 0; i < tabTitle.length; i++)
                        Tab(
                          text: tabTitle[i],
                        ),
                    ],
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      color: kPrimary,
                      fontFamily: 'bold',
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
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
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const FacultyHome(
                                          index: 1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: kPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width - 95,
                                child: CustomText(
                                  text:
                                      "${widget.studentName}'s ${widget.module == 0 ? 'Speaking' : 'Writing'}",
                                  fontfamily: 'Hanuman-bold',
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyScoreScreen(
                                      module: widget.module,
                                      studentList: widget.studentDetails,
                                      bandList: bandList,
                                      selectedBox: selectedBox,
                                      evaluationModalData: modal[0].data,
                                      slotID: widget.slotId,
                                    ),
                                  ),
                                );
                                // Get.to(VerifyScoreScreen(
                                //   module: widget.module,
                                // ));
                              },
                              child: const CustomText(
                                text: 'NEXT',
                                color: kPrimary,
                                fontfamily: "Hanuman-black",
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      for (int i = 0; i < tabTitle.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: width * 0.95,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width * 0.95 - 100,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD9D9D9)
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontFamily: 'Hanuman'),
                                          decoration: InputDecoration(
                                              hintText: "Search...",
                                              border: InputBorder.none,
                                              prefixIcon: Icon(
                                                Icons.search_rounded,
                                                color: Colors.black
                                                    .withOpacity(0.95),
                                              ),
                                              hintStyle: const TextStyle(
                                                  fontFamily: 'Hanuman',
                                                  color: Color(0xFFB3B3B3)),
                                              // border: InputBorder.none,
                                              // counterStyle: TextStyle(
                                              //   height: double.minPositive,
                                              // ),
                                              counterText: ""),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                                blurRadius: 5)
                                          ],
                                        ),
                                        child: TextFormField(
                                          initialValue: bandList[i],
                                          onChanged: (value) {
                                            addDataToBandList(value, i);
                                          },
                                          keyboardType: TextInputType.number,
                                          maxLength: 3,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF000000)),
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(
                                              counterText: '',
                                              border: InputBorder.none,
                                              hintText: '8.5',
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF999999))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: width * 0.9,
                                  child: Column(
                                    children: [
                                      for (int j = 0;
                                          j < modal[0].data[i].data.length;
                                          j++)
                                        SizedBox(
                                          width: width * 0.88,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10.0, bottom: 10.0),
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      side: BorderSide.none),
                                                  activeColor: kPrimary,
                                                  checkColor: Colors.white,
                                                  value: modal[0]
                                                      .data[i]
                                                      .data[j]
                                                      .value,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      modal[0]
                                                          .data[i]
                                                          .data[j]
                                                          .value = value!;
                                                      selectedBoxAddAndRemove(
                                                          modal[0]
                                                              .data[i]
                                                              .data[j]
                                                              .id);
                                                    });
                                                  },
                                                ),
                                              ),
                                              Flexible(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      checked[i] = !checked[i];
                                                    });
                                                  },
                                                  child: CustomText(
                                                      size: 12,
                                                      text: modal[0]
                                                          .data[i]
                                                          .data[j]
                                                          .title),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
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
            } else {
              return Scaffold(
                key: _newKey,
                body: const Center(
                  child: CustomText(text: "Something Went Wrong!!!!"),
                ),
              );
            }
          } else {
            log(snapshot.error.toString());
            return Scaffold(
              key: _newKey,
              body: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
        },
      ),
    );
  }
}
