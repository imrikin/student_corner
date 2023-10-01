// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_corner/componant/btn_primary.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/const.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/screens/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true;
  bool _obscureText1 = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: Color(0xFFFFF8FA),
          width: size.width,
          height: size.height,
          child: Stack(children: [
            Positioned(
              right: 0.0,
              top: 0.0,
              child: Image.asset(
                "images/png/signup_top_right.png",
                height: 307.65,
              ),
            ),
            Positioned(
              top: 30.0,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Image.asset(
                          "images/png/flyway_logo.png",
                          height: 100,
                          width: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5.0),
                        child: TextFieldCus(
                          text: "From Dreams To Destination",
                          color: Colors.black,
                          fontSize: 14.0,
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
                          text: "CREATE AN ACCOUNT",
                          color: Colors.black,
                          width: 0.8,
                          fontSize: 24.0,
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
                        maxLines: 1,
                        style: TextStyle(fontFamily: 'Hanuman'),
                        decoration: const InputDecoration(
                            hintText: "Roll No.",
                            icon: Icon(
                              Icons.hail_rounded,
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
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter
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
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.singleLineFormatter
                              ],
                              obscureText: _obscureText1,
                              decoration: const InputDecoration(
                                  hintText: "Confirm Password",
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
                              color: _obscureText1
                                  ? Color(0xFF838383)
                                  : Color(0xFFEC6820),
                              size: 25.0,
                            ),
                            onPressed: _toggle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              index: 0,
                            ),
                          ),
                        );
                      },
                      child: BtnPrimary(
                        color: Colors.white,
                        fontFamily: 'Hanuman-black',
                        fontSize: 22.0,
                        text: 'Create',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      children: [
                        TextFieldCus(
                            text: "Already Have An Account?",
                            color: Colors.black,
                            fontSize: 16.0,
                            width: 0.58,
                            textAlign: TextAlign.end,
                            fontFamily: 'Hanuman-bold'),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: TextFieldCus(
                              text: " Click Here",
                              color: Color(0xFFEC6820),
                              fontSize: 16.0,
                              width: 0.25,
                              textAlign: TextAlign.start,
                              fontFamily: 'Hanuman-black'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
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
                  Row(
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
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
