import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:student_corner/Screens/login_screen.dart';
import 'package:student_corner/const/api.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/const/const.dart';
import 'package:student_corner/firebase_options.dart';
import 'package:student_corner/home.dart';
import 'package:http/http.dart' as http;
import 'package:student_corner/modal/comman_response.dart';
import 'package:student_corner/modal/country_modal.dart';
import 'package:student_corner/modal/education_level.dart';
import 'package:student_corner/screens/faculty/home.dart';
import 'package:student_corner/screens/new/screens/login_screen.dart';
import 'package:student_corner/screens/new/screens/students/home.dart';
import 'package:student_corner/visa-screens/home.dart';

import 'screens/faculty/modal/evaluation_modal.dart';

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     "high_imop", "title",
//     importance: Importance.high, playSound: true);

// final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A message just showed up : ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // messaging.requestPermission().then((_) async {
    //   final token = await messaging.getToken();
    //   print('Token: $token');
    // });
    // final _messaging = FBMessaging.instance;
    // _messaging.stream.listen((event) {
    //   print('New Message: ${event}');
    // });
  } catch (e) {
    log(e.toString());
  }
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await _flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true, badge: true, sound: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? userSetting;
  bool login = false;
  bool inAdmission = false;
  bool inCoaching = false;
  String inqId = '';
  late String role;
  getSharedPref() async {
    login = false;
    userSetting = await SharedPreferences.getInstance();
    setState(() {
      login = ((userSetting!.getBool('login') ?? false));
      inAdmission = ((userSetting!.getBool('inAdmission') ?? false));
      inCoaching = ((userSetting!.getBool('inCoaching') ?? false));
      role = (userSetting!.getString('role') ?? '');
      try {
        inqId = userSetting!.getString('inqueryid')!;
      } catch (e) {
        log(e.toString());
      }
    });
  }

  evaluationDetails(module) async {
    // var url = module == 0
    //     ? Uri.parse("http://192.168.29.156:8080/abdevops/get_speaking_eve_data.php")
    //     : Uri.parse("http://192.168.29.156:8080/abdevops/get_writing_eve_data.php");
    var url = module == 0
        ? Uri.parse("https://abdevops.com/get_speaking_eve_data.php")
        : Uri.parse("https://abdevops.com/get_writing_eve_data.php");
    print(url.toString());
    var response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    if (response.statusCode == 200) {
      if (module == 0) {
        speakingEvaDetails = evaluationModalFromJson(response.body);
      } else if (module == 1) {
        writingEvaDetails = evaluationModalFromJson(response.body);
      }
    } else {
      throw Exception('Failed');
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedPref();
    _chechLoginDetails();
    // evaluationDetails(0);
    // evaluationDetails(1);
    try {
      _getCountry();
    } catch (e) {
      log(e.toString());
    }
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     _flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           color: Colors.blue,
    //           playSound: true,
    //           icon: 'image/flyway_favicon.png',
    //         ),
    //       ),
    //     );
    //   }
    // });

    // FirebaseMessaging.onBackgroundMessage((message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     return _flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel.id,
    //           channel.name,
    //           color: Colors.blue,
    //           playSound: true,
    //           icon: 'image/flyway_favicon.png',
    //         ),
    //       ),
    //     );
    //   }
    //   return _flutterLocalNotificationsPlugin.show(
    //     7458454,
    //     "Test",
    //     "Test body",
    //     const NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         "5241",
    //         "channel.name",
    //         color: Colors.blue,
    //         playSound: true,
    //         icon: 'image/flyway_favicon.png',
    //       ),
    //     ),
    //   );
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new OnMessageOpenApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //                 child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(notification.body!),
    //               ],
    //             )),
    //           );
    //         });
    //   }
    // });
    getTocken();
  }

  getTocken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null && login == true) {
      saveToDatabase(token, inqId);
    }
  }

  saveToDatabase(token, inqId) async {
    try {
      Map data = {'inqId': inqId, 'token': token};
      var url = Uri.parse("http://192.168.29.156:8080/abdevops/token.php");
      // var url = Uri.parse("https://www.abdevops.com/token.php");
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

  _chechLoginDetails() async {
    try {
      var url = Uri.parse("${APiConst.baseUrl}education_level.php");
      var response = await http.post(url);
      if (response.statusCode == 200) {
        List<EducationLevel> callBackres =
            educationLevelFromJson(response.body);
        if (callBackres[0].status == 200) {
          eduData = callBackres[0].data;
        } else {
          // print(callBackres[0].status.toString());
        }
      } else {
        // print(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  _getCountry() async {
    try {
      var url = Uri.parse("${APiConst.baseUrl}country_list.php");
      var response = await http.post(url);
      if (response.statusCode == 200) {
        // print(response.body);
        List<CountryModal> callBackres = countryModalFromJson(response.body);
        if (callBackres[0].status == 200) {
          countryData = callBackres[0].data;
        } else {
          // print(callBackres[0].status.toString());
        }
      } else {
        // print(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme().copyWith()),
      debugShowCheckedModeBanner: false,
      title: 'Clean Code',
      home: Scaffold(
        body: AnimatedSplashScreen(
          duration: 5000,
          splashIconSize: 300.0,
          splash: Image.asset(
            "images/png/flyway_logo.png",
            width: 300.00,
            height: 150.0,
          ),
          nextScreen: login
              ? role == 'faculty'
                  ? const FacultyHome()
                  : inAdmission
                      ? const VisaHome()
                      : const HomeScreen(
                          index: 0,
                        )
              : const LoginScreenNew(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: const Color(0xFFFFF8FA),
        ),
      ),
    );
  }
}
