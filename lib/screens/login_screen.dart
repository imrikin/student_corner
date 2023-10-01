// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_corner/componant/btn_primary.dart';
import 'package:student_corner/componant/loding.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/api.dart';
import 'package:student_corner/const/const.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/modal/comman_response.dart';
import 'package:student_corner/modal/login_modal.dart';
import 'package:student_corner/screens/faculty/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Loading loading = Loading();

  SharedPreferences? userSetting;
  String? email;
  String? password;
  getSharedPref() async {
    userSetting = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
  }

  _chechLoginDetails(email, password, BuildContext context) async {
    loading.start(context);
    try {
      Map data = {'email': email, 'password': password};
      var url = Uri.parse("${APiConst.baseUrl}login.php");
      var response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers":
                "Access-Control-Allow-Origin, Accept",
          },
          body: data);
      if (response.statusCode == 200) {
        List<LoginModal> callBackres = loginModalFromJson(response.body);

        if (callBackres[0].status == 200) {
          setState(() {
            userSetting!.setBool('login', true);
            userSetting!.setString('inqueryid', callBackres[0].inquiryId);
            userSetting!.setString('role', callBackres[0].role);
          });
          getTocken(callBackres[0].inquiryId);
          loading.stopDialog(context);
          if (callBackres[0].role == "faculty") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FacultyHome()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen(index: 0)));
          }
        } else {
          loading.stopDialog(context);
          // _scaffoldKey.currentState!.showSnackBar(SnackBar(
          //   content: Text(
          //     callBackres[0].message,
          //   ),
          //   duration: Duration(seconds: 2),
          // ));
        }
      } else {
        loading.stopDialog(context);
        // _scaffoldKey.currentState!.showSnackBar(SnackBar(
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

  saveToDatabase(token, inqId) async {
    try {
      Map data = {'inqId': inqId, 'token': token};
      var url = Uri.parse("${APiConst.baseUrl}token.php");
      var response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: data);
      if (response.statusCode == 200) {
        List<CommoanResponse> callback = commoanResponseFromJson(response.body);
        if (callback[0].status == 200) {}
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  getTocken(inqId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      saveToDatabase(token, inqId);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Color(0xFFFFF8FA),
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Positioned(
              right: 0.0,
              top: 0.0,
              child: Image.asset(
                "images/png/login_top_right.png",
                height: 307.65,
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Image.asset(
                "images/png/login_bottom_left.png",
                width: 250.0,
              ),
            ),
            Positioned(
              bottom: 20.0,
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    margin: EdgeInsets.only(top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(facebook));
                            },
                            child: Image.asset("images/png/facebook.png")),
                        SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          child: Image.asset("images/png/instagram.png"),
                          onTap: () {
                            launchUrl(Uri.parse(insta));
                          },
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(twitter));
                          },
                          child: Image.asset("images/png/twitter.png"),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(youtube));
                            },
                            child: Image.asset("images/png/youtube.png")),
                        SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                            onTap: () {
                              launchUrl(Uri.parse(whatsapp));
                            },
                            child: Image.asset("images/png/whatsapp.png")),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 30.0,
              height: size.height - 100,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Image.asset(
                            "images/png/flyway_logo.png",
                            height: 130,
                            width: 270,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 5.0),
                          child: TextFieldCus(
                            text: "From Dreams To Destination",
                            color: Colors.black,
                            fontSize: 16.0,
                            width: 0.65,
                            textAlign: TextAlign.center,
                            fontFamily: 'Hanuman',
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                          width: size.width,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: TextFieldCus(
                            text: "SIGN IN",
                            color: Colors.black,
                            width: 0.5,
                            fontSize: 28.0,
                            textAlign: TextAlign.start,
                            fontFamily: 'Hanuman-bold',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      alignment: Alignment.center,
                      width: size.width * 0.83,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(
                              10.0,
                              10.0,
                            ),
                            blurRadius: 25.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 10.0),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          maxLines: 1,
                          style: TextStyle(fontFamily: 'Hanuman'),
                          decoration: const InputDecoration(
                              hintText: "Email ID",
                              icon: Icon(
                                Icons.email_rounded,
                                color: Color(0xFFB3B3B3),
                              ),
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
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      alignment: Alignment.center,
                      width: size.width * 0.83,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(
                              10.0,
                              10.0,
                            ),
                            blurRadius: 25.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 10.0),
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .singleLineFormatter
                                ],
                                obscureText: _obscureText,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    icon: Icon(
                                      Icons.lock_rounded,
                                      color: Color(0xFFB3B3B3),
                                    ),
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
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 10.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye_rounded,
                                color: _obscureText
                                    ? Color(0xFF838383)
                                    : Color(0xFFEC6820),
                                size: 25.0,
                              ),
                              onPressed: _toggle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: InkWell(
                        onTap: () {
                          _chechLoginDetails(email, password, context);
                          // _data(email, password);
                        },
                        child: BtnPrimary(
                          color: Colors.white,
                          fontFamily: 'Hanuman-black',
                          fontSize: 22.0,
                          text: 'LOGIN',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 30.0),
                    //   child: Row(
                    //     children: [
                    //       TextFieldCus(
                    //           text: "Don't Have An Account?",
                    //           color: Colors.black,
                    //           fontSize: 15.0,
                    //           width: 0.5,
                    //           textAlign: TextAlign.end,
                    //           fontFamily: 'Hanuman-bold'),
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => const SignupScreen(),
                    //             ),
                    //           );
                    //         },
                    //         child: TextFieldCus(
                    //             text: " Create Now",
                    //             color: Color(0xFFEC6820),
                    //             fontSize: 16.0,
                    //             width: 0.3,
                    //             textAlign: TextAlign.start,
                    //             fontFamily: 'Hanuman-black'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        children: [
                          TextFieldCus(
                              text: "Need Help?",
                              color: Colors.black,
                              fontSize: 16.0,
                              width: 0.3,
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
                                width: 0.18,
                                textAlign: TextAlign.center,
                                fontFamily: 'Hanuman-black'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
