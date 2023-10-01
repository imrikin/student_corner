// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:student_corner/componant/expansion_tile_comp.dart';
import 'package:student_corner/componant/main_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/modal/all_mock_test_modal.dart';
import 'package:student_corner/modal/test_modal.dart';

class NavMockTestScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffkey;
  const NavMockTestScreen({Key? key, required this.scaffkey}) : super(key: key);

  @override
  State<NavMockTestScreen> createState() => _NavMockTestScreenState();
}

class _NavMockTestScreenState extends State<NavMockTestScreen> {
  late Future<List<TestModal>> testDDetails;
  late Future<List<AllMockTestModal>> details;
  @override
  void initState() {
    details = allMockTest("all_mock_test.php");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var uipadtop = MediaQueryData.fromWindow(ui.window).padding.top;
    var uipadbot = MediaQueryData.fromWindow(ui.window).padding.bottom;
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
                screenName: 'Mock Test Results',
                scaffkey: widget.scaffkey,
                homeIndex: 2,
              ),
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FutureBuilder<List<AllMockTestModal>>(
                          future: details,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data![0].status == 200) {
                                return Column(
                                  children: widgets(snapshot, size, context),
                                );
                              } else {
                                return LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return SizedBox(
                                      height: size.height -
                                          uipadtop -
                                          uipadbot -
                                          55.0,
                                      child: TextFieldCus(
                                        text: "No data found!",
                                        color: Colors.black,
                                        fontSize: 18,
                                        textAlign: TextAlign.center,
                                        fontFamily: 'hanuman-bold',
                                        width: size.width,
                                      ),
                                    );
                                  },
                                );
                              }
                            } else {
                              return SizedBox(
                                height:
                                    size.height - uipadtop - uipadbot - 55.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> widgets(AsyncSnapshot snapshot, Size size, BuildContext context) {
  List<Widget> element = [];
  for (int i = 0; i < snapshot.data![0].data.length; i++) {
    element.add(
      Padding(
        padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
        child: ExpansionTileComp(
          widgets: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  unselectedWidgetColor: Colors.black,
                  colorScheme: ColorScheme.light(primary: kPrimary)),
              child: ExpansionTile(
                title: Row(
                  children: [
                    Column(
                      children: [
                        TextFieldCus(
                            text: snapshot.data![0].data[i].date.toString(),
                            color: Colors.black,
                            fontSize: 15.0,
                            width: 0.3,
                            textAlign: TextAlign.start,
                            fontFamily: 'hanuman'),
                        TextFieldCus(
                            text: snapshot.data![0].data[i].day,
                            color: Colors.black,
                            fontSize: 15.0,
                            width: 0.3,
                            textAlign: TextAlign.start,
                            fontFamily: 'hanuman'),
                      ],
                    ),
                    TextFieldCus(
                        text:
                            "Overall Band : ${snapshot.data![0].data[i].overall}",
                        color: Colors.black,
                        fontSize: 14.0,
                        width: 0.4,
                        textAlign: TextAlign.start,
                        fontFamily: 'hanuman'),
                  ],
                ),
                children: [
                  ListTile(
                    title: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.4,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.headphones_rounded,
                                      color: kPrimary.withOpacity(0.9),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3.0, left: 5.0),
                                      child: TextFieldCus(
                                          text: "Listening :",
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.2,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: TextFieldCus(
                                          text: snapshot
                                              .data![0].data[i].listening,
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.07,
                                          textAlign: TextAlign.end,
                                          fontFamily: 'hanuman-black'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.4,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.book_rounded,
                                      color: kPrimary.withOpacity(0.9),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3.0, left: 5.0),
                                      child: TextFieldCus(
                                          text: "Reading :",
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.2,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: TextFieldCus(
                                          text:
                                              snapshot.data![0].data[i].reading,
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.07,
                                          textAlign: TextAlign.end,
                                          fontFamily: 'hanuman-black'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          width: size.width * 0.8,
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.4,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.menu_book,
                                      color: kPrimary.withOpacity(0.9),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3.0, left: 5.0),
                                      child: TextFieldCus(
                                          text: "Writing :",
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.2,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: TextFieldCus(
                                          text:
                                              snapshot.data![0].data[i].writing,
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.07,
                                          textAlign: TextAlign.end,
                                          fontFamily: 'hanuman-black'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.4,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.mic_rounded,
                                      color: kPrimary.withOpacity(0.9),
                                      size: 24,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3.0, left: 5.0),
                                      child: TextFieldCus(
                                          text: "Speaking :",
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.2,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 3.0),
                                      child: TextFieldCus(
                                          text: snapshot
                                              .data![0].data[i].speaking,
                                          color: Colors.black,
                                          fontSize: 12.0,
                                          width: 0.07,
                                          textAlign: TextAlign.end,
                                          fontFamily: 'hanuman-black'),
                                    ),
                                  ],
                                ),
                              ),
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
          size: size,
        ),
      ),
    );
  }
  return element;
}
