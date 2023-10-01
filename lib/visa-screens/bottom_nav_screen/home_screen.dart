import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:student_corner/bottom-nav-screen/speaking_screen.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';
import 'package:student_corner/visa-screens/modal/all_application_modal.dart';
import 'package:student_corner/visa-screens/time_line_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  String userId = '';
  late Future allApplicationFuture;
  int count = 0;

  List applicationStageData = [
    "Application In Process",
    "University Under Process",
    "Query / Under Review",
    "Decline By College",
    "Offer Letter Received",
    "Offer Decline By Student",
    "Fees Paid To Other"
  ];

  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString("userid") ?? '';
    });
  }

  Future<AllApplicationDetails> allapplicationDetails(inqueryId) async {
    String id = '';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("userid") ?? '';
    });
    Uri url = Uri.parse(
        "https://flywayimmigration.in/crmportal/mobile-app/new/all_application_details.php");
    Map data = {"inquiryId": id};
    // print(data);

    var response = await http.post(
      url,
      body: data,
    );
    // print(response.statusCode.toString() + "statuscoderikin");
    if (response.statusCode == 200) {
      // print("gotit");
      AllApplicationDetails modal =
          allApplicationDetailsFromJson(response.body);
      return modal;
    } else {
      // print("object");
      throw Exception('Failed');
    }
  }

  @override
  void initState() {
    getPref();
    allApplicationFuture = allapplicationDetails(userId);
    // print("function");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(userId);
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // print(height);
    return FutureBuilder(
      future: allApplicationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          AllApplicationDetails modal = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7.5),
                      decoration: BoxDecoration(
                        color: CustomColors().primaryLightColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            data: "Total Applied Application",
                            fontSize: width * TextSize().titleL,
                            fontWeight: CustomString().semiBold,
                            textOverflow: TextOverflow.visible,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                data: modal.totalApplication.toString(),
                                fontSize: width * TextSize().titleL,
                                color: CustomColors().primaryColor,
                                fontWeight: CustomString().black,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    CustomText(
                                      data: "View More",
                                      fontSize: 8,
                                      color: CustomColors().primaryColor,
                                      fontWeight: CustomString().semiBold,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: CustomColors().primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7.5),
                      decoration: BoxDecoration(
                        color: CustomColors().primaryLightColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            data: "Total\nOffer Received",
                            fontSize: width * TextSize().titleL,
                            fontWeight: CustomString().semiBold,
                            textOverflow: TextOverflow.visible,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                data: modal.offerRecevied.toString(),
                                fontSize: width * TextSize().titleL,
                                color: CustomColors().primaryColor,
                                fontWeight: CustomString().black,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    CustomText(
                                      data: "View More",
                                      fontSize: 8,
                                      color: CustomColors().primaryColor,
                                      fontWeight: CustomString().semiBold,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: CustomColors().primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: width * 0.8 + 25,
                  // height: width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  decoration: BoxDecoration(
                    color: CustomColors().primaryLightColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: CustomText(
                              data: "Canada",
                              fontSize: width * TextSize().titleXL,
                              fontWeight: CustomString().black,
                              color: CustomColors().primaryColor,
                            ),
                          ),
                          if (modal.countryWiseStage!.isNotEmpty)
                            for (int i = 0;
                                i < modal.countryWiseStage!.length;
                                i++)
                              if (modal.countryWiseStage![i].country ==
                                  "Canada")
                                Container(
                                  width: 100,
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: CustomColors().green,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: CustomText(
                                      data: modal.countryWiseStage![i].stage!,
                                      fontSize: width * TextSize().details,
                                      fontWeight: CustomString().black,
                                      color: CustomColors().white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: CustomColors().grey,
                        height: 1,
                        thickness: 1,
                      ),
                      for (int i = 0; i < modal.data!.length; i++)
                        if (modal.data![i].country == "Canada")
                          Column(
                            children: [
                              Builder(
                                builder: (context) {
                                  count = i;
                                  // print(i.toString() + count.toString());
                                  return const SizedBox();
                                },
                              ),
                              ClgApplicationWidget(
                                width: width,
                                data: modal.data![i],
                              ),
                              Visibility(
                                visible: i == count ? false : true,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                      color: CustomColors().grey,
                                      height: 1,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.8 + 25,
                  // height: width,
                  margin: EdgeInsets.symmetric(vertical: 20.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  decoration: BoxDecoration(
                    color: CustomColors().primaryLightColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: CustomText(
                              data: "USA",
                              fontSize: width * TextSize().titleXL,
                              fontWeight: CustomString().black,
                              color: CustomColors().primaryColor,
                            ),
                          ),
                          if (modal.countryWiseStage!.isNotEmpty)
                            for (int i = 0;
                                i < modal.countryWiseStage!.length;
                                i++)
                              if (modal.countryWiseStage![i].country == "USA")
                                Container(
                                  width: 100,
                                  height: 35,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: CustomColors().green,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: CustomText(
                                      data: modal.countryWiseStage![i].stage!,
                                      fontSize: width * TextSize().details,
                                      fontWeight: CustomString().black,
                                      color: CustomColors().white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: CustomColors().grey,
                        height: 1,
                        thickness: 1,
                      ),
                      for (int i = 0; i < modal.data!.length; i++)
                        if (modal.data![i].country == "USA")
                          Column(
                            children: [
                              Builder(
                                builder: (context) {
                                  count = i;
                                  // print(i.toString() + count.toString());
                                  return const SizedBox();
                                },
                              ),
                              ClgApplicationWidget(
                                width: width,
                                data: modal.data![i],
                              ),
                              Visibility(
                                visible: i == count ? false : true,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Divider(
                                      color: CustomColors().grey,
                                      height: 1,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

class ClgApplicationWidget extends StatelessWidget {
  final double width;
  final ApplicationData data;
  const ClgApplicationWidget({
    super.key,
    required this.width,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    // List applicationStageData = [
    //   "Application In Process",
    //   "University Under Process",
    //   "Query / Under Review",
    //   "Decline By College",
    //   "Offer Letter Received",
    //   "Offer Decline By Student",
    //   "Fees Paid To Other"
    // ];
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (contextDialog) => AlertDialog(
            backgroundColor: CustomColors().primaryBackground,
            title: Center(
              child: CustomText(
                data: data.university!["university_name"]!,
                fontSize: 16,
                fontWeight: CustomString().semiBold,
                color: CustomColors().primaryColor,
              ),
            ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: const EdgeInsets.only(bottom: 15),
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: CustomColors().white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              width: width * 0.8,
              // height: width * 0.75,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: width * 0.25,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CustomColors().logoPrimary,
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        child: CustomText(
                          data: "${data.intakeMonth!} - ${data.intakeYear}",
                          fontWeight: CustomString().black,
                          color: CustomColors().white,
                          fontSize: width * TextSize().detailsLarge,
                        ),
                      ),
                      if (data.country == "USA")
                        Container(
                          width: width * 0.175,
                          alignment: Alignment.center,
                          height: 30,
                          decoration: BoxDecoration(
                            color: CustomColors().green,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                            ),
                          ),
                          child: CustomText(
                            data: "I - 20",
                            fontWeight: CustomString().black,
                            color: CustomColors().white,
                            fontSize: width * TextSize().detailsLarge,
                          ),
                        ),
                      Container(
                        width: width * 0.25,
                        alignment: Alignment.center,
                        height: 30,
                        decoration: BoxDecoration(
                          color: CustomColors().primaryColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: CustomText(
                          data: data.campus!,
                          fontWeight: CustomString().black,
                          color: CustomColors().white,
                          fontSize: width * TextSize().detailsLarge,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: width * TextSize().text14,
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          data: "Program Name : ",
                          fontSize: width * TextSize().details,
                          fontWeight: CustomString().bold,
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: CustomText(
                            data: data.program,
                            fontSize: width * TextSize().details,
                            fontWeight: CustomString().regular,
                            textOverflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: width * TextSize().detailsXS,
                  ),
                  SizedBox(
                    width: width * 0.7,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          data: "Currant Status : ",
                          fontSize: width * TextSize().details,
                          fontWeight: CustomString().bold,
                        ),
                        SizedBox(
                          width: width * 0.4,
                          child: CustomText(
                            data: data.applicationStatus!,
                            fontSize: width * TextSize().details,
                            color: CustomColors().green,
                            fontWeight: CustomString().regular,
                            textOverflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (data.offerexpire! != "0000-00-00")
                    Column(
                      children: [
                        SizedBox(
                          height: width * TextSize().detailsXS,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: "Received Date : ",
                                fontSize: width * TextSize().details,
                                fontWeight: CustomString().bold,
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: CustomText(
                                  data: data.selectiondate.toString(),
                                  fontSize: width * TextSize().details,
                                  fontWeight: CustomString().regular,
                                  textOverflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: width * TextSize().detailsXS,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: "Expiry Date : ",
                                fontSize: width * TextSize().details,
                                fontWeight: CustomString().bold,
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: CustomText(
                                  data: data.offerexpire.toString(),
                                  fontSize: width * TextSize().details,
                                  fontWeight: CustomString().regular,
                                  textOverflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: width * TextSize().detailsXS,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: "Offer Type : ",
                                fontSize: width * TextSize().details,
                                fontWeight: CustomString().bold,
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: CustomText(
                                  data: data.offerType ?? "N/A",
                                  fontSize: width * TextSize().details,
                                  fontWeight: CustomString().regular,
                                  textOverflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: width * TextSize().detailsXS,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                data: "Offer Condition  : ",
                                fontSize: width * TextSize().details,
                                fontWeight: CustomString().bold,
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: CustomText(
                                  data: data.offerCondition ?? "N/A",
                                  fontSize: width * TextSize().details,
                                  fontWeight: CustomString().regular,
                                  textOverflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: width * TextSize().titleXL,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: (width * 0.75) * 0.42,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CustomColors().primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: CustomText(
                          data: "Documents",
                          fontWeight: CustomString().black,
                          color: CustomColors().white,
                          fontSize: width * 0.04,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.of(contextDialog).pop("dialog");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TimeLineScreen(
                                applicationId: data.admissionId.toString(),
                                inqueryId: data.hInquiryId.toString(),
                                data: data,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: (width * 0.75) * 0.42,
                          height: 50,
                          alignment: Alignment.center,
                          child: CustomText(
                            data: "Timeline",
                            fontWeight: CustomString().black,
                            color: CustomColors().primaryColor,
                            fontSize: width * 0.04,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 9),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      child: CustomText(
                        data: data.university!["university_name"]!,
                        fontSize: width * TextSize().title,
                        textOverflow: TextOverflow.visible,
                        fontWeight: CustomString().semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    CustomText(
                      data: "Applied On: ${data.applicationdate}",
                      fontSize: width * TextSize().detailsXS,
                    )
                  ],
                ),
                if (data.country == "USA")
                  // Builder(
                  //   builder: (context) {
                  //     print(data.i20Received.toString() + "i-20" ?? "null");
                  //     return SizedBox();
                  //   },
                  // ),
                  Visibility(
                    visible: data.i20Received == "0" ? false : true,
                    child: Container(
                      width: 35,
                      height: 20,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CustomColors().green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: CustomText(
                        data: "i-20",
                        fontWeight: CustomString().black,
                        color: CustomColors().white,
                        fontSize: width * TextSize().detailsSmall,
                      ),
                    ),
                  ),
                Container(
                  width: width * 0.24,
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: data.applicationStatus == "Offer Letter Received"
                        ? CustomColors().green
                        : (data.applicationStatus == "Application In Process" ||
                                data.applicationStatus ==
                                    "University Under Process" ||
                                data.applicationStatus ==
                                    "Query / Under Review")
                            ? CustomColors().warning
                            : CustomColors().red,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Flexible(
                      child: CustomText(
                        data: data.applicationStatus!,
                        fontSize: width * TextSize().detailsSmall,
                        fontWeight: CustomString().black,
                        color: CustomColors().white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // if()
          ],
        ),
      ),
    );
  }
}
