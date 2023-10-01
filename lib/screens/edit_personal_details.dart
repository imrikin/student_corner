// ignore_for_file: prefer__ructors, deprecated_member_use, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/componant/input_box_comp.dart';
import 'package:student_corner/componant/loding.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/api.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/modal/all_pesonal_details.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:http/http.dart' as http;

class EditPersonalDetailsScreen extends StatefulWidget {
  final List<Personaldetail> pModal;
  const EditPersonalDetailsScreen({Key? key, required this.pModal})
      : super(key: key);

  @override
  State<EditPersonalDetailsScreen> createState() =>
      _EditPersonalDetailsScreenState();
}

class _EditPersonalDetailsScreenState extends State<EditPersonalDetailsScreen> {
  final genderList = ['MALE', 'FEMALE'];
  late String firstName;
  late String lastName;
  late String mobile;
  late String email;
  late String gender;
  late DateTime dob;
  late String altMobile;
  late String wpMobile;
  late String city;
  late String zipCode;

  @override
  void initState() {
    firstName = widget.pModal[0].fname;
    lastName = widget.pModal[0].lname;
    mobile = widget.pModal[0].mobile;
    email = widget.pModal[0].email;
    gender = widget.pModal[0].gender.toUpperCase();
    dob = DateFormat("dd/MM/yyyy").parse(widget.pModal[0].dob);
    zipCode = widget.pModal[0].zipcode;
    city = widget.pModal[0].city;
    altMobile = '';
    wpMobile = '';
    super.initState();
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: dob,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (newDate == null) return;
    setState(() {
      dob = newDate;
    });
  }

  updatePersonalInfo(BuildContext context) async {
    Loading loading = Loading();
    loading.start(context);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String inquiryid = pref.getString('inqueryid')!;
    String? rollno = pref.getString('rollno');
    try {
      Map data = {
        'email': email,
        'inquiryid': inquiryid,
        'rollno': rollno,
        'fname': firstName,
        'lname': lastName,
        'mobile': mobile,
        'city': city,
        'zipcode': zipCode,
        'gender': gender.toLowerCase(),
        'dob': dob.toString().substring(0, 10),
        'altmobile': altMobile,
        'wpmobile': wpMobile
      };
      var url = Uri.parse("${APiConst.baseUrl}edit_personal_info.php");
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
          // scaffkey.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     callBackres[0].message.toString(),
          //   ),
          //   duration: const Duration(seconds: 5),
          // ));
        } else {
          // scaffkey.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     callBackres[0].message.toString(),
          //   ),
          //   duration: const Duration(seconds: 2),
          // ));

          Navigator.of(context, rootNavigator: true).pop('dialog');
        }
      } else {
        // scaffkey.currentState!.showSnackBar(const SnackBar(
        //   content: Text(
        //     'Something went wrong!',
        //   ),
        //   duration: const Duration(seconds: 2),
        // ));
        Navigator.of(context, rootNavigator: true).pop('dialog');
      }
    } catch (e) {
      log(e.toString());
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
        body: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                const SecondaryAppbar(
                  homeIndex: 3,
                  title: 'Personal Details',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: size.width * 0.4,
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    const TextFieldCus(
                                        text: " First Name",
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
                                            firstName = value;
                                          },
                                          initialValue: firstName,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontFamily: 'Hanuman'),
                                          decoration: const InputDecoration(
                                              hintText: "John",
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
                                      width: 0.4,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width * 0.4,
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    const TextFieldCus(
                                        text: " Last Name",
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
                                          initialValue: lastName,
                                          onChanged: (value) =>
                                              lastName = value,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontFamily: 'Hanuman'),
                                          decoration: const InputDecoration(
                                              hintText: "Dee",
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
                                      width: 0.4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: size.width * 0.85,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                const TextFieldCus(
                                    text: " Mobile",
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
                                      initialValue: mobile,
                                      onChanged: (value) => mobile = value,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      maxLength: 10,
                                      style: const TextStyle(
                                          fontFamily: 'Hanuman'),
                                      decoration: const InputDecoration(
                                          hintText: "9876543210",
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
                            width: size.width * 0.85,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                const TextFieldCus(
                                    text: " Email",
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
                                      initialValue: email,
                                      onChanged: (value) => email = value,
                                      keyboardType: TextInputType.text,
                                      readOnly: true,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontFamily: 'Hanuman'),
                                      decoration: const InputDecoration(
                                          hintText: "johndee123@gmail.com",
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: size.width * 0.4,
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    const TextFieldCus(
                                        text: " City",
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
                                            city = value;
                                          },
                                          initialValue: city,
                                          keyboardType: TextInputType.text,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontFamily: 'Hanuman'),
                                          decoration: const InputDecoration(
                                              hintText: "John",
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
                                      width: 0.4,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width * 0.4,
                                margin: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  children: [
                                    const TextFieldCus(
                                        text: " Zip Code",
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
                                          initialValue: zipCode,
                                          onChanged: (value) => zipCode = value,
                                          keyboardType: TextInputType.number,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontFamily: 'Hanuman'),
                                          decoration: const InputDecoration(
                                              hintText: "Dee",
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
                                      width: 0.4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                width: size.width * 0.4,
                                child: Column(
                                  children: [
                                    const TextFieldCus(
                                        text: " Gender",
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
                                              hint: const TextFieldCus(
                                                  text: 'Select',
                                                  color: Color.fromARGB(
                                                      255, 107, 107, 107),
                                                  fontSize: 18,
                                                  width: 0.8,
                                                  textAlign: TextAlign.start,
                                                  fontFamily: 'hanuman'),
                                              value: gender,
                                              onChanged: (newValue) async {
                                                setState(() {
                                                  gender = newValue!;
                                                });
                                              },
                                              items: genderList
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
                                          )),
                                      width: 0.85,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Column(
                                  children: [
                                    const TextFieldCus(
                                        text: " Select date *",
                                        color: Colors.black87,
                                        fontSize: 13.0,
                                        width: 0.4,
                                        textAlign: TextAlign.start,
                                        fontFamily: 'hanuman-bold'),
                                    InkWell(
                                      onTap: () => pickDate(context),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: const EdgeInsets.only(top: 5.0),
                                        width: size.width * 0.4,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: const Color(0xFFC4C4C4)
                                                .withOpacity(0.5)),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: TextFieldCus(
                                              text: dob.toString() == ''
                                                  ? "Select Date"
                                                  : dob
                                                      .toString()
                                                      .substring(0, 10),
                                              color: dob.toString() == ''
                                                  ? const Color.fromARGB(
                                                      255, 107, 107, 107)
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
                            ],
                          ),
                          Container(
                            width: size.width * 0.85,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                const TextFieldCus(
                                    text: " Alternate Mobile",
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
                                      initialValue: '',
                                      onChanged: (value) => altMobile = value,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      maxLength: 10,
                                      style: const TextStyle(
                                          fontFamily: 'Hanuman'),
                                      decoration: const InputDecoration(
                                          hintText: "9876543210",
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
                            width: size.width * 0.85,
                            margin: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                const TextFieldCus(
                                    text: " Whatsapp Number",
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
                                      initialValue: '',
                                      onChanged: (value) => wpMobile = value,
                                      keyboardType: TextInputType.number,
                                      maxLines: 1,
                                      maxLength: 10,
                                      style: const TextStyle(
                                          fontFamily: 'Hanuman'),
                                      decoration: const InputDecoration(
                                          hintText: "9876543210",
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
                          ElevatedButton(
                            onPressed: () {
                              updatePersonalInfo(context);
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
