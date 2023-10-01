// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, use_build_context_synchronously, non_constant_identifier_names, unrelated_type_equality_checks
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/componant/btn_primary.dart';
import 'package:student_corner/componant/expansion_tile_comp.dart';
import 'package:student_corner/componant/loding.dart';
import 'package:student_corner/componant/main_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/ApiRequest.dart';
import 'package:student_corner/const/api.dart';
import 'package:student_corner/const/colors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:student_corner/const/const.dart';
import 'package:student_corner/const/wp_message.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:student_corner/modal/speaking_details_modal.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:student_corner/screens/slot_evalution_details.dart';

String? email;

class NavSpeakingScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffkey;
  const NavSpeakingScreen({Key? key, required this.scaffkey}) : super(key: key);

  @override
  State<NavSpeakingScreen> createState() => _NavSpeakingScreenState();
}

class _NavSpeakingScreenState extends State<NavSpeakingScreen> {
  SharedPreferences? pref;
  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String finalDate = '';
  String? _mySelection;
  String? moduleSelection;
  String? _morningTime;
  String? _eveningTime;
  String? name;
  String? rollno;
  String? mobile;
  String? date;
  String? slot;
  String? time;
  Loading loading = Loading();
  late Future<List<SpeakignModal>> modal;
  var availableSlot = ['Morning', 'Evening'];
  var moduleList = ['Writing', 'Speaking'];
  var morningTime = [
    '10:00',
    '10:15',
    '10:30',
    '10:45',
    "11:00",
    "11:15",
    "11:30",
    "11:45"
  ];
  var eveningTime = [
    '04:00',
    '04:15',
    '04:30',
    '04:45',
    "05:00",
    "05:15",
    "05:30",
    "05:45"
  ];
  Future<void> _selectDate(BuildContext context, moduleSelection) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: today,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      String Day = DateFormat('EEEE').format(selectedDate);
      if (moduleSelection == "Speaking") {
        if (Day == 'Thursday' || Day == 'Tuesday') {
          finalDate = DateFormat('dd/MM/yyyy').format(selectedDate).toString();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Slot only available on Tuesday and Thursday for speaking.."),
          ));
        }
      } else if (moduleSelection == "Writing") {
        if (Day == 'Wednesday' || Day == 'Friday') {
          finalDate = DateFormat('dd/MM/yyyy').format(selectedDate).toString();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Slot only available on Wednesday and Friday for writing.."),
          ));
        }
      }
    }
  }

  _getPrefData() async {
    pref = await SharedPreferences.getInstance();
    name = pref!.getString('name');
    rollno = pref!.getString('rollno');
    email = pref!.getString('email');
    mobile = pref!.getString('mobile');
  }

  _bookSpeaking(slot, time, BuildContext context) async {
    loading.start(context);
    String bookedMessage =
        '''Dear Student,
  Your $slot slot has been booked at $time for $moduleSelection module.
  Best of luck!! ''';
    try {
      Map data = {
        'name': name,
        'rollno': rollno,
        'module': moduleSelection,
        'email': email,
        'date': finalDate.toString(),
        'slot': slot,
        'time': time
      };
      var url = Uri.parse("${APiConst.baseUrl}add_speaking_slot_details.php");
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
          // widget.scaffkey.currentState!.showSnackBar(SnackBar(
          //   backgroundColor: kPrimary,
          //   content: Text(
          //     callBackres[0].message,
          //     style: TextStyle(fontFamily: 'hanuman'),
          //   ),
          //   duration: Duration(seconds: 2),
          // ));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(index: 1),
              ));
          sendWpMessage(bookedMessage, mobile);
        } else {
          loading.stopDialog(context);
          // widget.scaffkey.currentState!.showSnackBar(SnackBar(
          //   backgroundColor: kPrimary,
          //   content: Text(
          //     callBackres[0].message,
          //     style: TextStyle(fontFamily: 'hanuman'),
          //   ),
          //   duration: Duration(seconds: 2),
          // ));
          setState(() {
            _mySelection = null;
            finalDate = '';
          });
        }
      } else {
        loading.stopDialog(context);
        // widget.scaffkey.currentState!.showSnackBar(SnackBar(
        //   backgroundColor: kPrimary,
        //   content: Text(
        //     'Something went wrong!',
        //     style: TextStyle(fontFamily: 'hanuman'),
        //   ),
        //   duration: Duration(seconds: 2),
        // ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    _getPrefData();
    modal = allSpeakingDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                screenName: 'Slot Booking',
                scaffkey: widget.scaffkey,
                homeIndex: 1,
              ),
              Expanded(
                child: SizedBox(
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          alignment: Alignment.centerLeft,
                          width: size.width * 0.85,
                          height: 80.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldCus(
                                  text: " Select Module *",
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  width: 0.5,
                                  textAlign: TextAlign.start,
                                  fontFamily: 'hanuman-bold'),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 5.0),
                                width: size.width * 0.8,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFFC4C4C4).withOpacity(0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isDense: true,
                                      isExpanded: true,
                                      hint: TextFieldCus(
                                          text: 'Select',
                                          color: Color.fromARGB(
                                              255, 107, 107, 107),
                                          fontSize: 20.0,
                                          width: 0.8,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                      value: moduleSelection,
                                      onChanged: (newValue) async {
                                        setState(() {
                                          moduleSelection = newValue!;
                                          finalDate = '';
                                        });
                                      },
                                      items: moduleList.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: TextFieldCus(
                                              text: items,
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              width: 0.8,
                                              textAlign: TextAlign.start,
                                              fontFamily: 'hanuman'),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          alignment: Alignment.centerLeft,
                          width: size.width * 0.85,
                          height: 80.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldCus(
                                  text: " Select Date *",
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  width: 0.5,
                                  textAlign: TextAlign.start,
                                  fontFamily: 'hanuman'),
                              InkWell(
                                onTap: () =>
                                    _selectDate(context, moduleSelection),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 5.0),
                                  width: size.width * 0.8,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color:
                                          Color(0xFFC4C4C4).withOpacity(0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: TextFieldCus(
                                        text: finalDate == ''
                                            ? "Select Date"
                                            : finalDate,
                                        color: finalDate == ''
                                            ? Color.fromARGB(255, 107, 107, 107)
                                            : Colors.black,
                                        fontSize: 20,
                                        width: 0.7,
                                        textAlign: TextAlign.start,
                                        fontFamily: 'hanuman'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          alignment: Alignment.centerLeft,
                          width: size.width * 0.85,
                          height: 80.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldCus(
                                  text: " Select Slot *",
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  width: 0.5,
                                  textAlign: TextAlign.start,
                                  fontFamily: 'hanuman-bold'),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 5.0),
                                width: size.width * 0.8,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFFC4C4C4).withOpacity(0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isDense: true,
                                      isExpanded: true,
                                      hint: TextFieldCus(
                                          text: 'Select',
                                          color: Color.fromARGB(
                                              255, 107, 107, 107),
                                          fontSize: 20.0,
                                          width: 0.8,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                      value: _mySelection,
                                      onChanged: (newValue) async {
                                        setState(() {
                                          _mySelection = newValue!;
                                        });
                                      },
                                      items: availableSlot.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: TextFieldCus(
                                              text: items,
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              width: 0.8,
                                              textAlign: TextAlign.start,
                                              fontFamily: 'hanuman'),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.0),
                          alignment: Alignment.centerLeft,
                          width: size.width * 0.85,
                          height: 80.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldCus(
                                  text: " Select Time *",
                                  color: Colors.black,
                                  fontSize: 13.0,
                                  width: 0.5,
                                  textAlign: TextAlign.start,
                                  fontFamily: 'hanuman-bold'),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 5.0),
                                width: size.width * 0.8,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Color(0xFFC4C4C4).withOpacity(0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isDense: true,
                                      isExpanded: true,
                                      hint: TextFieldCus(
                                          text: 'Select',
                                          color: Color.fromARGB(
                                              255, 107, 107, 107),
                                          fontSize: 20.0,
                                          width: 0.8,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                      value: _mySelection == 'Morning'
                                          ? _eveningTime
                                          : _morningTime,
                                      onChanged: (newValue) async {
                                        setState(() {
                                          _mySelection == 'Morning'
                                              ? _eveningTime = newValue!
                                              : _morningTime = newValue!;
                                        });
                                      },
                                      items: _mySelection == 'Morning'
                                          ? morningTime.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: TextFieldCus(
                                                    text: items,
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                    width: 0.8,
                                                    textAlign: TextAlign.start,
                                                    fontFamily: 'hanuman'),
                                              );
                                            }).toList()
                                          : eveningTime.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: TextFieldCus(
                                                    text: items,
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                    width: 0.8,
                                                    textAlign: TextAlign.start,
                                                    fontFamily: 'hanuman'),
                                              );
                                            }).toList(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: InkWell(
                            onTap: () {
                              if (_mySelection == null ||
                                  moduleSelection == null ||
                                  finalDate == '' ||
                                  (_eveningTime == null &&
                                      _morningTime == null)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("All Value Are Required"),
                                ));
                              } else {
                                // print(moduleSelection);
                                _bookSpeaking(
                                    _mySelection,
                                    _mySelection == 'Morning'
                                        ? _eveningTime
                                        : _morningTime,
                                    context);
                              }
                            },
                            child: BtnPrimary(
                              color: Colors.white,
                              fontFamily: 'Hanuman-black',
                              fontSize: 22.0,
                              text: 'BOOK',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
                          width: size.width,
                          child: Column(
                            children: [
                              TextFieldCus(
                                text: "Booked Speaking Slots",
                                color: Colors.black,
                                fontSize: 20,
                                textAlign: TextAlign.center,
                                fontFamily: 'hanuman-black',
                                width: 0.9,
                              ),
                              FutureBuilder<List<SpeakignModal>>(
                                  future: modal,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      // print(snapshot.data[0].status);
                                      if (snapshot.data[0].status == 200) {
                                        // return Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(top: 15.0),
                                        //   child: Center(
                                        //     child: Wrap(
                                        //       spacing: 20.0,
                                        //       runSpacing: 20.0,
                                        //       children: bookedTestDetails(
                                        //           size, snapshot, context),
                                        //     ),
                                        //   ),
                                        // );
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Column(
                                            children: newBookedTestDetails(
                                                size, snapshot, context),
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFieldCus(
                                            text: 'No data found!!',
                                            color: Colors.black54,
                                            fontSize: 18.0,
                                            textAlign: TextAlign.center,
                                            fontFamily: 'hanuman-bold',
                                            width: 0.9,
                                          ),
                                        );
                                      }
                                    } else {
                                      return CircularProgressIndicator
                                          .adaptive();
                                    }
                                  }),
                            ],
                          ),
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

List<Widget> newBookedTestDetails(
    Size size, AsyncSnapshot snapshot, BuildContext context) {
  List<Widget> element = [];
  List<SpeakignModal> modal = snapshot.data;
  for (var i = 0; i < modal[0].data.length; i++) {
    List bands = [];
    List bandsTitle = [];
    try {
      bands = json.decode(modal[0].data[i].bandArray);
      if (modal[0].data[i].module == "Writing") {
        for (var j = 0; j < writingEvaDetails[0].data.length; j++) {
          bandsTitle.add(writingEvaDetails[0].data[j].title);
        }
      } else if (modal[0].data[i].module == "Speaking") {
        for (var j = 0; j < speakingEvaDetails[0].data.length; j++) {
          bandsTitle.add(speakingEvaDetails[0].data[j].title);
        }
      }
    } catch (e) {
      log(e.toString());
    }

    if (modal[0].data.length > i) {
      element.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
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
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: "Module : ",
                                  fontfamily: 'Hanuman-bold',
                                  size: 12,
                                ),
                                CustomText(
                                  text: modal[0].data[i].module,
                                  size: 12,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 08.0,
                            ),
                            Row(
                              children: [
                                CustomText(
                                  text: "Slot : ",
                                  fontfamily: 'Hanuman-bold',
                                  size: 12,
                                ),
                                CustomText(
                                  text: modal[0].data[i].slot,
                                  size: 12,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 08.0,
                            ),
                            modal[0].data[i].status == "1"
                                ? Row(
                                    children: [
                                      CustomText(
                                        text: "Total Band : ",
                                        fontfamily: 'Hanuman-bold',
                                        size: 12,
                                      ),
                                      CustomText(
                                        text: modal[0].data[i].totalBand,
                                        size: 12,
                                      ),
                                    ],
                                  )
                                : CustomText(
                                    text: "",
                                    size: 12,
                                  ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: "Date : ",
                                  fontfamily: 'Hanuman-bold',
                                  size: 12,
                                ),
                                CustomText(
                                  text: modal[0].data[i].date,
                                  size: 12,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 08.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: "Time : ",
                                  fontfamily: 'Hanuman-bold',
                                  size: 12,
                                ),
                                CustomText(
                                  text: modal[0].data[i].time,
                                  size: 12,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 08.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: modal[0].data[i].status == "0"
                                      ? "Pending"
                                      : "Completed",
                                  fontfamily: 'Hanuman-bold',
                                  color: modal[0].data[i].status == "0"
                                      ? Colors.yellow.shade900
                                      : Colors.green.shade500,
                                  size: 12,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    if (bandsTitle.isNotEmpty && modal[0].data[i].status == "1")
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, left: 5.0),
                                            child: TextFieldCus(
                                                text: bandsTitle[0],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.2,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: TextFieldCus(
                                                text: bands[0],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.07,
                                                textAlign: TextAlign.end,
                                                fontFamily: 'hanuman-black'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, left: 5.0),
                                            child: TextFieldCus(
                                                text: bandsTitle[2],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.2,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: TextFieldCus(
                                                text: bands[2],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.07,
                                                textAlign: TextAlign.end,
                                                fontFamily: 'hanuman-black'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, left: 5.0),
                                            child: TextFieldCus(
                                                text: bandsTitle[1],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.2,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: TextFieldCus(
                                                text: bands[1],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.07,
                                                textAlign: TextAlign.end,
                                                fontFamily: 'hanuman-black'),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.0, left: 5.0),
                                            child: TextFieldCus(
                                                text: bandsTitle[3],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.2,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3.0),
                                            child: TextFieldCus(
                                                text: bands[3],
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                width: 0.07,
                                                textAlign: TextAlign.end,
                                                fontFamily: 'hanuman-black'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          SlotEvaluationScreen(
                                        data: modal[0].data[i],
                                        evaluationModalData:
                                            modal[0].data[i].module ==
                                                    "Speaking"
                                                ? speakingEvaDetails[0].data
                                                : writingEvaDetails[0].data,
                                      ),
                                    ));
                              },
                              child: CustomText(
                                text: "View",
                                color: kPrimary,
                                fontfamily: "Hanuman-bold",
                              ),
                            )
                          ],
                        ),
                      )
                    else
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    builder: (builder) {
                                      return BottomSheet(
                                        date: modal[0].data[i].date,
                                        id: modal[0].data[i].id,
                                        size: size,
                                        slot: modal[0].data[i].slot,
                                        time: modal[0].data[i].time,
                                        module: modal[0].data[i].module,
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.edit_note_rounded,
                                size: 30,
                                color: kPrimary,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showAlertDialog(
                                  context,
                                  modal[0].data[i].id,
                                );
                              },
                              child: Icon(
                                Icons.delete_forever_rounded,
                                size: 30,
                                color: Colors.red,
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
    } else {}
  }

  return element;
}

List<Widget> bookedTestDetails(size, AsyncSnapshot snapshot, context) {
  List<Widget> elements = [];
  for (var i = 0; i < snapshot.data![0].data.length; i++) {
    elements.add(
      Container(
        padding: EdgeInsets.all(13.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(
                  0.0,
                  0.0,
                ),
                blurRadius: 15.0,
                spreadRadius: 2.0,
              )
            ]),
        width: size.width * 0.4,
        child: Column(
          children: [
            TextFieldCus(
                text: "Module : ${snapshot.data[0].data[i].module}",
                color: Colors.black87,
                fontSize: 12,
                width: 0.35,
                textAlign: TextAlign.start,
                fontFamily: 'Hanuman'),
            SizedBox(height: 5.0),
            TextFieldCus(
                text: "Date : ${snapshot.data[0].data[i].date}",
                color: Colors.black87,
                fontSize: 12,
                width: 0.35,
                textAlign: TextAlign.start,
                fontFamily: 'Hanuman'),
            SizedBox(height: 5.0),
            TextFieldCus(
                text: "Slot : ${snapshot.data[0].data[i].slot}",
                color: Colors.black87,
                fontSize: 13,
                width: 0.35,
                textAlign: TextAlign.start,
                fontFamily: 'Hanuman'),
            SizedBox(height: 5.0),
            TextFieldCus(
                text: "Time : ${snapshot.data[0].data[i].time}",
                color: Colors.black87,
                fontSize: 13,
                width: 0.35,
                textAlign: TextAlign.start,
                fontFamily: 'Hanuman'),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        builder: (builder) {
                          return BottomSheet(
                            date: snapshot.data[0].data[i].date,
                            id: snapshot.data[0].data[i].id,
                            size: size,
                            slot: snapshot.data[0].data[i].slot,
                            time: snapshot.data[0].data[i].time,
                            module: snapshot.data[0].data[i].module,
                          );
                        });
                  },
                  child: Icon(
                    Icons.edit_note_rounded,
                    size: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showAlertDialog(
                      context,
                      snapshot.data[0].data[i].id,
                    );
                  },
                  child: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red,
                    size: 20.0,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  return elements;
}

showAlertDialog(BuildContext context, id) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
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
    child: Text(
      "Delete",
      style: TextStyle(
          color: Colors.red,
          fontFamily: 'Hanuman',
          fontWeight: FontWeight.w500),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
      _deleteSpeakingSlot(id, context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Are you sure?"),
    content: Text("Would you like to delete this slot!"),
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

_deleteSpeakingSlot(String id, BuildContext context) async {
  Loading loading = Loading();
  loading.start(context);
  try {
    Map data = {'id': id, 'email': email};
    var url = Uri.parse("${APiConst.baseUrl}delete_speaking_slot_details.php");
    var response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data);

    log(id);
    log(email.toString());

    if (response.statusCode == 200) {
      List<CommoanResponse> responceData =
          commoanResponseFromJson(response.body);
      if (responceData[0].status == 200) {
        loading.stopDialog(context);
        // scaffkey.currentState!.showSnackBar(SnackBar(
        //   backgroundColor: kPrimary,
        //   content: Text(
        //     responceData[0].message,
        //     style: TextStyle(fontFamily: 'hanuman'),
        //   ),
        //   duration: Duration(seconds: 2),
        // ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              index: 1,
            ),
          ),
        );
      } else {
        loading.stopDialog(context);
        // scaffkey.currentState!.showSnackBar(SnackBar(
        //   backgroundColor: kPrimary,
        //   content: Text(
        //     responceData[0].message,
        //     style: TextStyle(fontFamily: 'hanuman'),
        //   ),
        //   duration: Duration(seconds: 2),
        // ));
      }
    } else {
      loading.stopDialog(context);
      // scaffkey.currentState!.showSnackBar(SnackBar(
      //   backgroundColor: kPrimary,
      //   content: Text(
      //     'Something Went Wrong!! Try after some time!',
      //     style: TextStyle(fontFamily: 'hanuman'),
      //   ),
      //   duration: Duration(seconds: 2),
      // ));
    }
  } catch (e) {
    log(e.toString());
  }
}

class BottomSheet extends StatefulWidget {
  final Size size;
  final String id;
  final String module;
  final String date;
  final String slot;
  final String time;
  const BottomSheet(
      {Key? key,
      required this.size,
      required this.date,
      required this.slot,
      required this.time,
      required this.id,
      required this.module})
      : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  SharedPreferences? pref;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  late DateTime checkDate;
  String finalDate = '';
  String? _mySelection;
  String? _morningTime;
  String? _eveningTime;
  String? name;
  String? rollno;
  String? email;
  String? date;
  String? slot;
  String? time;
  String? mobile;
  bool isLoading = false;
  @override
  void initState() {
    _prefValue();
    checkDate = DateFormat('dd/MM/yyyy').parse(widget.date);
    finalDate = DateFormat('dd/MM/yyyy').format(checkDate).toString();
    _mySelection = widget.slot;
    if (widget.slot == 'Morning') {
      _morningTime = widget.time;
    } else if (widget.slot == 'Evening') {
      _eveningTime = widget.time;
    }
    super.initState();
  }

  _prefValue() async {
    pref = await SharedPreferences.getInstance();
    name = pref!.getString('name');
    rollno = pref!.getString('rollno');
    email = pref!.getString('email');
    mobile = pref!.getString('mobile');
  }

  late Future<List<SpeakignModal>> modal;
  var availableSlot = ['Morning', 'Evening'];
  var morningTime = [
    '10:00',
    '10:15',
    '10:30',
    '10:45',
    "11:00",
    "11:15",
    "11:30",
    "11:45"
  ];
  var eveningTime = [
    '04:00',
    '04:15',
    '04:30',
    '04:45',
    "05:00",
    "05:15",
    "05:30",
    "05:45"
  ];
  Future<void> _selectDate(BuildContext context) async {
    var checkDate = DateFormat('dd/MM/yyyy').parse(widget.date);
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: checkDate,
        firstDate: DateTime(2001),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // prints Tuesday
      });
      String Day = DateFormat('EEEE').format(selectedDate);

      if (widget.module == "Speaking") {
        if (Day == 'Thursday' || Day == 'Tuesday') {
          finalDate = DateFormat('dd/MM/yyyy').format(selectedDate).toString();
        } else {
          // _key.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //       "Slot only available on Tuesday and Thursday For Speaking.."),
          // ));
        }
      } else if (widget.module == "Writing") {
        if (Day == 'Wednesday' || Day == 'Friday') {
          finalDate = DateFormat('dd/MM/yyyy').format(selectedDate).toString();
        } else {
          // _key.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //       "Slot only available on Wednesday and Friday For Writing.."),
          // ));
        }
      }
    }
  }

  _updateSpeakingSlot(slot, time, BuildContext context) async {
    String updateMessage =
        "Dear Student,%0AYour $slot slot has been updated at ${finalDate.toString()} $time for ${widget.module} module.%0ABest of luck!!";
    setState(() {
      isLoading = true;
    });
    try {
      Map data = {
        'id': widget.id,
        'name': name,
        'rollno': rollno,
        'email': email,
        'date': finalDate.toString(),
        'slot': slot,
        'time': time
      };
      var url = Uri.parse("${APiConst.baseUrl}update_speaking.php");
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
          sendWpMessage(updateMessage, mobile);
          // Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                index: 1,
              ),
            ),
          );
          // _key.currentState!.showSnackBar(SnackBar(
          //   backgroundColor: kPrimary,
          //   content: Text(
          //     callBackres[0].message,
          //     style: TextStyle(fontFamily: 'hanuman'),
          //   ),
          //   duration: Duration(seconds: 2),
          // ));
        } else {
          // _key.currentState!.showSnackBar(SnackBar(
          //   backgroundColor: kPrimary,
          //   content: Text(
          //     callBackres[0].message,
          //     style: TextStyle(fontFamily: 'hanuman'),
          //   ),
          //   duration: Duration(seconds: 2),
          // ));
          setState(() {
            _mySelection = null;
            finalDate = '';
          });
        }
      } else {
        // _key.currentState!.showSnackBar(SnackBar(
        //   backgroundColor: kPrimary,
        //   content: Text(
        //     'Something went wrong!',
        //     style: TextStyle(fontFamily: 'hanuman'),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.transparent,
          width: widget.size.width,
          child: !isLoading
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      width: 100.0,
                      height: 7.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey.withOpacity(0.3)),
                    ),
                    TextFieldCus(
                        text: 'Edit ${widget.module} Details',
                        color: Colors.black,
                        fontSize: 18.0,
                        width: 1,
                        textAlign: TextAlign.center,
                        fontFamily: 'hanuman-bold'),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: [
                          TextFieldCus(
                              text: " Select date *",
                              color: Colors.black87,
                              fontSize: 13.0,
                              width: 0.9,
                              textAlign: TextAlign.start,
                              fontFamily: 'hanuman-bold'),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 5.0),
                              width: widget.size.width * 0.9,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color(0xFFC4C4C4).withOpacity(0.5)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: TextFieldCus(
                                    text: finalDate == ''
                                        ? "Select Date"
                                        : finalDate,
                                    color: finalDate == ''
                                        ? Color.fromARGB(255, 107, 107, 107)
                                        : Colors.black,
                                    fontSize: 20,
                                    width: 0.7,
                                    textAlign: TextAlign.start,
                                    fontFamily: 'hanuman'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.centerLeft,
                      width: widget.size.width * 0.9,
                      height: 80.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldCus(
                              text: " Select Slot *",
                              color: Colors.black,
                              fontSize: 13.0,
                              width: 0.5,
                              textAlign: TextAlign.start,
                              fontFamily: 'hanuman-bold'),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 5.0),
                            width: widget.size.width * 0.9,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4).withOpacity(0.5)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  hint: TextFieldCus(
                                      text: 'Select',
                                      color: Color.fromARGB(255, 107, 107, 107),
                                      fontSize: 20.0,
                                      width: 0.9,
                                      textAlign: TextAlign.start,
                                      fontFamily: 'hanuman'),
                                  value: _mySelection,
                                  onChanged: (newValue) async {
                                    setState(() {
                                      _mySelection = newValue!;
                                    });
                                  },
                                  items: availableSlot.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: TextFieldCus(
                                          text: items,
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          width: 0.9,
                                          textAlign: TextAlign.start,
                                          fontFamily: 'hanuman'),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.centerLeft,
                      width: widget.size.width * 0.9,
                      height: 80.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldCus(
                              text: " Select Time *",
                              color: Colors.black,
                              fontSize: 13.0,
                              width: 0.5,
                              textAlign: TextAlign.start,
                              fontFamily: 'hanuman-bold'),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 5.0),
                            width: widget.size.width * 0.9,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFC4C4C4).withOpacity(0.5)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  hint: TextFieldCus(
                                      text: 'Select',
                                      color: Color.fromARGB(255, 107, 107, 107),
                                      fontSize: 20.0,
                                      width: 0.9,
                                      textAlign: TextAlign.start,
                                      fontFamily: 'hanuman'),
                                  value: _mySelection == 'Morning'
                                      ? _morningTime
                                      : _eveningTime,
                                  onChanged: (newValue) async {
                                    setState(() {
                                      _mySelection == 'Morning'
                                          ? _morningTime = newValue!
                                          : _eveningTime = newValue!;
                                    });
                                  },
                                  items: _mySelection == 'Morning'
                                      ? morningTime.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: TextFieldCus(
                                                text: items,
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                width: 0.9,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman'),
                                          );
                                        }).toList()
                                      : eveningTime.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: TextFieldCus(
                                                text: items,
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                width: 0.9,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman'),
                                          );
                                        }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _updateSpeakingSlot(
                            _mySelection,
                            _mySelection == 'Morning'
                                ? _morningTime
                                : _eveningTime,
                            context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: TextFieldCus(
                          text: 'Update',
                          color: kPrimary,
                          fontSize: 22.0,
                          textAlign: TextAlign.center,
                          fontFamily: 'hanuman-black',
                          width: 1,
                        ),
                      ),
                    )
                  ],
                )
              : Center(child: CircularProgressIndicator.adaptive()),
        ),
      ),
    );
  }
}
