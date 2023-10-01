import 'package:flutter/material.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/analysis_screen.dart';
import 'package:student_corner/screens/faculty/http/client.dart';
import 'package:student_corner/screens/faculty/modal/student_list_modal.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:student_corner/screens/faculty/widgets/main_appbar.dart';

class FacultyNavWriting extends StatefulWidget {
  const FacultyNavWriting({Key? key}) : super(key: key);

  @override
  State<FacultyNavWriting> createState() => _FacultyNavWritingState();
}

class _FacultyNavWritingState extends State<FacultyNavWriting> {
  late Future<List<StudentList>> modalDetails;
  bool completed = false;
  bool pending = false;
  bool evening = false;
  bool morning = false;

  @override
  void initState() {
    modalDetails = studentList(1);
    super.initState();
  }

  filterBottomSheet(width) {
    showBottomSheet(
        context: context,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return Container(
            width: width * 0.99,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomText(text: "Completed"),
                          Switch.adaptive(
                              value: completed,
                              onChanged: (value) {
                                setState(() {
                                  completed = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomText(text: "Pending"),
                          Switch.adaptive(
                              value: pending,
                              onChanged: (value) {
                                setState(() {
                                  pending = value;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomText(text: "Morning"),
                          Switch.adaptive(
                              value: morning,
                              onChanged: (value) {
                                setState(() {
                                  morning = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomText(text: "Evening"),
                          Switch.adaptive(
                              value: evening,
                              onChanged: (value) {
                                setState(() {
                                  evening = value;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const MainAppBar(title: "Writing Slots"),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: modalDetails,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<StudentList> modal = snapshot.data;
                  if (modal[0].status == 200) {
                    return Column(
                      children: [
                        Container(
                          width: width * 0.95,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            style: const TextStyle(fontFamily: 'Hanuman'),
                            decoration: InputDecoration(
                                hintText: "Search...",
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: Colors.black.withOpacity(0.95),
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
                          width: width * 0.95,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.filter_list_rounded,
                                size: 24,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  filterBottomSheet(width);
                                },
                                child: const CustomText(
                                  text: 'Filter',
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                        for (int i = 0; i < modal[0].data.length; i++)
                          Container(
                            width: width * 0.9,
                            height: 80,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.25),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text:
                                              'Roll No. : ${modal[0].data[i].rollNo}',
                                          size: 12,
                                          fontfamily: 'Hanuman',
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        CustomText(
                                          text:
                                              'Name : ${modal[0].data[i].name}',
                                          size: 12,
                                          fontfamily: 'Hanuman',
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: modal[0].data[i].status == '0'
                                              ? 'Pending'
                                              : 'Completed',
                                          size: 14,
                                          color: modal[0].data[i].status == '0'
                                              ? const Color(0xFFFFD522)
                                              : const Color(0xFF20B038),
                                          fontfamily: 'Hanuman-bold',
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        CustomText(
                                          text: modal[0].data[i].time,
                                          size: 12,
                                          fontfamily: 'Hanuman',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: modal[0].data[i].status == '1'
                                      ? false
                                      : true,
                                  child: Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        AnalysisScreen(
                                                            module: 1,
                                                            studentName:
                                                                modal[0]
                                                                    .data[i]
                                                                    .name,
                                                            studentDetails:
                                                                modal[0]
                                                                    .data[i],
                                                            slotId: modal[0]
                                                                .data[i]
                                                                .id)));
                                      },
                                      child: Container(
                                        height: 100,
                                        decoration: const BoxDecoration(
                                          color: kPrimary,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: CustomText(text: "No slot found!!"));
                  }
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Center(
                      child: CustomText(text: "No slot found!!"));
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
