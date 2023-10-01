// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_corner/const/api.dart';
import 'package:student_corner/home.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/screens/new/custom_text_field_widget.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';
import 'package:student_corner/screens/new/screens/students/home.dart';
import 'package:student_corner/screens/new/validator.dart';
import 'package:http/http.dart' as http;

import '../../../visa-screens/home.dart';
import '../model/login_new_model.dart';

class LoginScreenNew extends StatefulWidget {
  const LoginScreenNew({super.key});

  @override
  State<LoginScreenNew> createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends State<LoginScreenNew> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late Widget svgImg;
  bool isPassword = true;
  bool isLoading = false;
  late SharedPreferences _preferences;

  setPref() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    svgImg = SvgPicture.asset("images/login_svg.svg");
    setPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    checkLogin(email, password) async {
      setState(() {
        isLoading = true;
      });
      Map data = {'email': email, 'password': password};
      var url = Uri.parse("${APiConst.baseUrl}login_new.php");
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
        print(response.body);
        List<LoginNew> _model = loginNewFromJson(response.body);
        if (_model[0].inAdmission) {
          _preferences.setBool("login", true);
          _preferences.setBool("inAdmission", true);
          _preferences.setString('userid', _model[0].inquiryId);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const VisaHome(),
              ));
          // print("In Admission");
        } else if (_model[0].inCoaching) {
          // print("In Coaching");
          _preferences.setString('userid', _model[0].inquiryId);
          _preferences.setBool("login", true);
          _preferences.setBool("inCoaching", true);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(index: 0),
              ));
        } else {
          displaySnackbar(
              CustomText(
                data: _model[0].message.toString(),
                fontWeight: CustomString().bold,
              ),
              context);
          // print(response.body);
        }
      } else {
        displaySnackbar(
            CustomText(
              data: response.body.toString(),
              fontWeight: CustomString().bold,
            ),
            context);
        // print(response.body);
      }
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
      backgroundColor: CustomColors().primaryBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: width,
            height: height,
            child: Column(
              children: [
                Container(
                  height: (height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 190,
                            height: 90,
                            margin: const EdgeInsets.only(top: 20, left: 20),
                            child: Image.asset(
                              "images/logo.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: height * 0.30,
                        height: height * 0.30,
                        // child: Image.asset("assets/login_img.png"),
                        child: svgImg,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: height * 0.5,
                  width: width,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: CustomColors().white,
                    boxShadow: [
                      BoxShadow(
                        color: CustomColors().black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: 5,
                      ),
                    ],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(36),
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        data: "Login With Your Credential",
                        fontWeight: CustomString().bold,
                        fontSize: 18,
                        color: CustomColors().primaryColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: CustomTextField(
                          label: "E-Mail",
                          labelFontWeight: CustomString().bold,
                          labelColor: CustomColors().primaryColor,
                          isRequired: true,
                          controller: emailController,

                          onChange: (value) {},
                          hintText: 'abc@gmail.com',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: CustomColors().primaryColor,
                          ),
                          // sufixIcon: Icon(Icons.email_outlined),
                          textInputType: TextInputType.emailAddress,
                          validator: validateEmail,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: CustomTextField(
                          label: "Password",
                          labelFontWeight: CustomString().bold,
                          labelColor: CustomColors().primaryColor,
                          isRequired: true,
                          controller: passwordController,
                          onChange: (value) {},
                          isPassword: isPassword,
                          hintText: '*********',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: CustomColors().primaryColor,
                          ),
                          wantPadding: false,
                          sufixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                              icon: Icon(
                                Icons.remove_red_eye_rounded,
                                color: isPassword
                                    ? CustomColors().primaryColor
                                    : CustomColors().grey,
                              )),
                          textInputType: TextInputType.emailAddress,
                          validator: validatePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: CustomText(
                      //         data: "Forgot Your Password?",
                      //         fontWeight: CustomString().bold,
                      //         color: CustomColors().grey,
                      //         fontSize: 12,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: width * 0.76,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isLoading) {
                            } else {
                              if (validateEmail(emailController.text) == "") {
                                // valid email
                                if (validatePassword(passwordController.text) ==
                                    "") {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const Home(),
                                  //   ),
                                  // );
                                  //valid password
                                  checkLogin(emailController.text,
                                      passwordController.text);
                                } else {
                                  // empty password
                                  displaySnackbar(
                                      CustomText(
                                        data: "Password is empty!!",
                                        fontWeight: CustomString().bold,
                                      ),
                                      context);
                                }
                              } else {
                                displaySnackbar(
                                    CustomText(
                                      data: "Wrong Email address!!",
                                      fontWeight: CustomString().bold,
                                    ),
                                    context);
                                //error wrong email
                              }
                            }
                          },
                          style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all(
                                  CustomColors().primaryColor),
                              overlayColor: MaterialStateProperty.all(
                                  CustomColors().white.withOpacity(0.2)),
                              backgroundColor: MaterialStateProperty.all(
                                  isLoading
                                      ? CustomColors().greyLight
                                      : CustomColors().primaryColor)),
                          child: isLoading
                              ? SizedBox(
                                  height: 30,
                                  child: CircularProgressIndicator.adaptive(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        CustomColors().primaryColor),
                                  ),
                                )
                              : CustomText(
                                  data: "Log in",
                                  fontWeight: CustomString().bold,
                                  color: CustomColors().white,
                                ),
                        ),
                      ),
                    ],
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
