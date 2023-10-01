// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_corner/componant/main_comp_with_shadow.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/modal/noti_modal.dart';

import '../const/ApiRequest.dart';

class NotificationScreen extends StatefulWidget {
  final int homeIndex;
  const NotificationScreen({Key? key, required this.homeIndex})
      : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<Notimodal>> notificationDetails;

  @override
  void initState() {
    notificationDetails = getNotificationDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kPrimaryBackGround,
          child: Column(
            children: [
              SecondaryAppbar(
                  title: 'Notifications', homeIndex: widget.homeIndex),
              Expanded(
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: notificationDetails,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        List<Notimodal> modal = snapshot.data;
                        if (modal[0].status == 200) {
                          return Column(
                            children: [
                              for (int i = 0; i < modal[0].data.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: MainBoxCompWithoutShadow(
                                    size: size,
                                    height: 85.0,
                                    widgets: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0,
                                              top: 10.0,
                                              right: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              TextFieldCus(
                                                text: modal[0].data[i].title,
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                textAlign: TextAlign.start,
                                                fontFamily: 'hanuman-bold',
                                                width: 0.55,
                                              ),
                                              TextFieldCus(
                                                text:
                                                    'Date : ${modal[0].data[i].date}',
                                                color: Colors.black,
                                                fontSize: 10.0,
                                                textAlign: TextAlign.end,
                                                fontFamily: 'hanuman-Light',
                                                width: 0.25,
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFieldCus(
                                          text: modal[0].data[i].body,
                                          color: Colors.black,
                                          fontSize: 13.0,
                                          textAlign: TextAlign.justify,
                                          fontFamily: 'hanuman',
                                          width: 0.8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator.adaptive();
                        }
                      } else {
                        return CircularProgressIndicator.adaptive();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
