import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:student_corner/screens/faculty/widgets/custom_text.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';
import 'package:student_corner/visa-screens/modal/all_application_modal.dart';
import 'package:student_corner/visa-screens/modal/timeline_modal.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TimeLineScreen extends StatefulWidget {
  final String inqueryId;
  final String applicationId;
  final ApplicationData data;
  const TimeLineScreen(
      {super.key,
      required this.inqueryId,
      required this.applicationId,
      required this.data});

  @override
  State<TimeLineScreen> createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  List<TimelineModal> timeLinedata = [];
  List applicationStageData = [
    "Application In Process",
    "University Under Process",
    "Query / Under Review",
    "Decline By College",
    "Offer Letter Received",
    "Offer Decline By Student",
    "Fees Paid To Other"
  ];

  showAttachments(url) async {
    launchUrlString(url);
  }

  setTimeLine() async {
    for (var i = 0; i < applicationStageData.length; i++) {
      if (i == 0) {
        timeLinedata.add(TimelineModal(
            status: "In Process",
            date: widget.data.submissiondate,
            description:
                "Thank you so much for choosing our services, We are working on your application so wait until we prepare your documents. We will update you. ",
            hasAttachments: false,
            position: i));
      }
      if (i == 1 && widget.data.applicationStatus == applicationStageData[i]) {
        timeLinedata.add(TimelineModal(
            status: "In process - U",
            date: widget.data.submissiondate,
            description:
                "Update, Your application has been submitted on this university, so keep wait until we got any result.",
            hasAttachments: false,
            position: 0));
      }
      if (i == 2 && widget.data.applicationStatus == applicationStageData[i]) {
        timeLinedata.add(TimelineModal(
            status: "In process - U",
            date: widget.data.submissiondate,
            description:
                "Update, Your application has been submitted on this university, so keep wait until we got any result.",
            hasAttachments: false,
            position: 1));
        timeLinedata.add(TimelineModal(
            status: "Query",
            date: widget.data.lastUpdate!.substring(0, 10),
            description:
                "Update, The university need sone details, please call us as soon as possible,",
            hasAttachments: false,
            position: 2));
      }
      if (i == 3 && widget.data.applicationStatus == applicationStageData[i]) {
        timeLinedata.add(TimelineModal(
            status: "In process - U",
            date: widget.data.submissiondate,
            description:
                "Update, Your application has been submitted on this university, so keep wait until we got any result.",
            hasAttachments: false,
            position: 1));
        timeLinedata.add(TimelineModal(
            status: "Decline - U",
            date: widget.data.lastUpdate!.substring(0, 10),
            description:
                "We are sorry to inform that your application for this university has been declined by university.",
            hasAttachments: false,
            position: 3));
      }
      if (i == 4 && widget.data.applicationStatus == applicationStageData[i]) {
        timeLinedata.add(TimelineModal(
            status: "In process - U",
            date: widget.data.submissiondate,
            description:
                "Update, Your application has been submitted on this university, so keep wait until we got any result.",
            hasAttachments: false,
            position: 1));
        timeLinedata.add(TimelineModal(
            status: "Offer Received",
            condition: widget.data.offerCondition.toString(),
            date: widget.data.lastUpdate!.substring(0, 10),
            url: widget.data.admissionCopy ?? "",
            description:
                "Congratulations!!, You received offer letter from this university, so hurry up and confirm your seat. ",
            hasAttachments: true,
            position: 4));
      }
      if (i == 5 && widget.data.applicationStatus == applicationStageData[i]) {
        timeLinedata.add(TimelineModal(
            status: "In process - U",
            date: widget.data.submissiondate,
            description:
                "Update, Your application has been submitted on this university, so keep wait until we got any result.",
            hasAttachments: false,
            position: 1));
        timeLinedata.add(TimelineModal(
            status: "Offer Received",
            date: widget.data.lastUpdate!.substring(0, 10),
            url: widget.data.admissionCopy ?? "",
            condition: widget.data.offerCondition.toString(),
            description:
                "Congratulations!!, You received offer letter from this university, so hurry up and confirm your seat. ",
            hasAttachments: true,
            position: 4));
        timeLinedata.add(TimelineModal(
            status: "Decline - S",
            date: widget.data.lastUpdate!.substring(0, 10),
            description:
                "We hope you got better option except this, We wish for your bright future.",
            hasAttachments: false,
            position: 5));
      }
      if (i == 6 && widget.data.applicationStatus == applicationStageData[i]) {
        timeLinedata.add(TimelineModal(
            status: "In process - U",
            date: widget.data.submissiondate,
            description:
                "Update, Your application has been submitted on this university, so keep wait until we got any result.",
            hasAttachments: false,
            position: 1));
        timeLinedata.add(TimelineModal(
            status: "Offer Received",
            url: widget.data.admissionCopy ?? "",
            condition: widget.data.offerCondition.toString(),
            date: widget.data.lastUpdate!.substring(0, 10),
            description:
                "Congratulations!!, You received offer letter from this university, so hurry up and confirm your seat. ",
            hasAttachments: true,
            position: 4));
        timeLinedata.add(TimelineModal(
            status: "Paid - Other",
            date: widget.data.lastUpdate!.substring(0, 10),
            description:
                "We hope you got better option except this, We wish for your bright future.",
            hasAttachments: false,
            position: 6));
      }

      timeLinedata = timeLinedata.reversed.toList();
    }
  }

  @override
  void initState() {
    setTimeLine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors().primaryBackground,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: const Color(0xFFEBEBEB),
        title: CustomText(
            data: widget.data.university!['university_name'] ?? "",
            fontWeight: CustomString().semiBold),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              for (int i = 0; i < timeLinedata.length; i++)
                Container(
                  width: width,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (context) {
                          print(timeLinedata[i].url ?? "");
                          return SizedBox();
                        },
                      ),
                      Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    color: timeLinedata[i].position == 4
                                        ? CustomColors()
                                            .success
                                            .withOpacity(0.2)
                                        : (timeLinedata[i].position == 0 ||
                                                timeLinedata[i].position == 1 ||
                                                timeLinedata[i].position == 2)
                                            ? CustomColors()
                                                .orange
                                                .withOpacity(0.2)
                                            : CustomColors()
                                                .red
                                                .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: timeLinedata[i].position == 4
                                        ? CustomColors().success
                                        : (timeLinedata[i].position == 0 ||
                                                timeLinedata[i].position == 1 ||
                                                timeLinedata[i].position == 2)
                                            ? CustomColors().orange
                                            : CustomColors().red,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ],
                          ),
                          for (int i = 0; i < 5; i++)
                            Container(
                              width: 5.5,
                              height: 15,
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                  color: CustomColors().dividerColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                        ],
                      ),
                      Container(
                        width: width * 0.73,
                        margin: const EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: CustomColors().white,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: timeLinedata[i].position == 4
                                        ? CustomColors().green
                                        : (timeLinedata[i].position == 0 ||
                                                timeLinedata[i].position == 1 ||
                                                timeLinedata[i].position == 2)
                                            ? CustomColors().orange
                                            : CustomColors().red,
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: CustomText(
                                    data: timeLinedata[i].status ?? "",
                                    fontWeight: CustomString().black,
                                    fontSize: 12,
                                    color: CustomColors().white,
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: CustomColors().primaryColor,
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: CustomText(
                                    data: timeLinedata[i].date ?? "",
                                    fontWeight: CustomString().black,
                                    fontSize: 12,
                                    color: CustomColors().white,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "",
                                  style: TextStyle(
                                      color: CustomColors().green,
                                      fontSize: 14,
                                      height: 1.5,
                                      fontWeight: CustomString().black),
                                  children: [
                                    TextSpan(
                                      text: timeLinedata[i].description ?? "",
                                      style: TextStyle(
                                          color: CustomColors().black,
                                          fontSize: 14,
                                          fontWeight: CustomString().medium),
                                    ),
                                    if (timeLinedata[i].condition != "")
                                      TextSpan(
                                        text:
                                            " Conditional offer letter : ${timeLinedata[i].condition}",
                                        style: TextStyle(
                                            color: CustomColors().red,
                                            fontSize: 10,
                                            fontWeight: CustomString().black),
                                      ),
                                    if (timeLinedata[i].hasAttachments ?? false)
                                      TextSpan(
                                        text: " Show Attachments",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            showAttachments(
                                                timeLinedata[i].url);
                                          },
                                        style: TextStyle(
                                            color: CustomColors().primaryColor,
                                            fontSize: 14,
                                            fontWeight: CustomString().black),
                                      ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
