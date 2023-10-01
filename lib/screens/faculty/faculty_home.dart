// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_corner/screens/faculty/http/client.dart';
import 'package:student_corner/screens/faculty/modal/home_modal.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:student_corner/screens/faculty/widgets/home_container.dart';
import 'package:student_corner/screens/faculty/widgets/main_appbar.dart';

class FacultyNavHome extends StatelessWidget {
  FacultyNavHome({Key? key}) : super(key: key);

  Future<List<HomeDetailsModal>> homeDetails = homeDetailsList();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const MainAppBar(
          title: 'Home',
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: homeDetails,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<HomeDetailsModal> modal = snapshot.data;
                  if (modal[0].success) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HomeBoxContainer(
                              size: size,
                              width: 0.4,
                              count: modal[0].data[0].todaySpeaking.toString(),
                              function: () {},
                              title: 'Today Speaking',
                            ),
                            HomeBoxContainer(
                              size: size,
                              width: 0.4,
                              count: modal[0].data[0].todayWriting.toString(),
                              function: () {},
                              title: 'Today Writing',
                            ),
                          ],
                        ),
                        HomeBoxContainer(
                          size: size,
                          width: 0.85,
                          count: modal[0].data[0].totalSpeaking.toString(),
                          function: () {},
                          title: 'Total Speaking',
                        ),
                        HomeBoxContainer(
                          size: size,
                          width: 0.85,
                          count: modal[0].data[0].totalWriting.toString(),
                          function: () {},
                          title: 'Total Writing',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            HomeBoxContainer(
                              size: size,
                              width: 0.4,
                              count:
                                  modal[0].data[0].pendingSpeaking.toString(),
                              function: () {},
                              title: 'Pending Speaking',
                            ),
                            HomeBoxContainer(
                              size: size,
                              width: 0.4,
                              count: modal[0].data[0].pendingWriting.toString(),
                              function: () {},
                              title: 'Pending Writing',
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CustomText(text: modal[0].message),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
