import 'package:flutter/material.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/analysis_screen.dart';
import 'package:student_corner/screens/faculty/http/client.dart';
import 'package:student_corner/screens/faculty/modal/student_list_modal.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:student_corner/screens/faculty/widgets/main_appbar.dart';

class FacultyNavSpeaking extends StatefulWidget {
  const FacultyNavSpeaking({Key? key}) : super(key: key);

  @override
  State<FacultyNavSpeaking> createState() => _FacultyNavSpeakingState();
}

class _FacultyNavSpeakingState extends State<FacultyNavSpeaking> {
  late Future<List<StudentList>> modalDetails;
  @override
  void initState() {
    modalDetails = studentList(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const MainAppBar(title: "Speaking Slots"),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: modalDetails,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  List<StudentList> modal = snapshot.data;
                  if (modal[0].success) {
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
                            children: const [
                              Icon(
                                Icons.filter_list_rounded,
                                size: 24,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: 'Filter',
                                size: 16,
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
                                                            module: 0,
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
