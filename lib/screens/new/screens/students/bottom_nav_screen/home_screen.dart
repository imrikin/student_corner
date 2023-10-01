import 'package:flutter/material.dart';
// import 'package:student_corner/bottom-nav-screen/speaking_screen.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // print(width);
    return SingleChildScrollView(
      child: Column(
        children: [
          requestContainer(width, context),
          Container(
            width: width,
            // height: 100,
            decoration: BoxDecoration(
              color: CustomColors().white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(20),
            margin:
                const EdgeInsets.only(left: 25.0, bottom: 20.0, right: 25.0),
            child: Column(
              children: [
                CustomText(
                  data: "This week attendance",
                  fontSize: width * 0.04,
                  fontWeight: CustomString().semiBold,
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: CustomColors().greyLight,
                  height: 1,
                  thickness: 1,
                ),
                Column(
                  children: [
                    for (int i = 0; i <= 4; i++)
                      Column(
                        children: [
                          Padding(
                            padding: i != 4
                                ? const EdgeInsets.symmetric(vertical: 13.0)
                                : const EdgeInsets.only(top: 13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  data: "20 May, 2001",
                                  fontSize: width * TextSize().details,
                                  fontWeight: CustomString().semiBold,
                                ),
                                Visibility(
                                  visible: i != 2,
                                  // maintainSize: true,
                                  // maintainState: true,
                                  // maintainAnimation: true,
                                  child: CustomText(
                                    data: "10:23 AM",
                                    // fontSize: 12,
                                    fontSize: width * TextSize().detailsSmall,
                                    // fontWeight: CustomString().semiBold,
                                  ),
                                ),
                                Visibility(
                                  visible: i != 2,
                                  // maintainSize: true,
                                  // maintainState: true,
                                  // maintainAnimation: true,
                                  child: CustomText(
                                    data: "01:30 PM",
                                    // fontSize: 12,

                                    fontSize: width * TextSize().detailsSmall,
                                    color: CustomColors().red,
                                    // fontWeight: CustomString().semiBold,
                                  ),
                                ),
                                Container(
                                  width: width * 0.07,
                                  height: width * 0.07,
                                  decoration: BoxDecoration(
                                    color: i != 2
                                        ? CustomColors().green
                                        : CustomColors().red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: i != 4,
                            child: Divider(
                              height: 1,
                              color: CustomColors().greyExtraLight,
                            ),
                          ),
                        ],
                      )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: width,
            // height: 100,
            decoration: BoxDecoration(
              color: CustomColors().white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(20),
            margin:
                const EdgeInsets.only(left: 25.0, bottom: 20.0, right: 25.0),
            child: Column(
              children: [
                CustomText(
                  data: "Last Mock Test Result",
                  fontSize: width * TextSize().title,
                  fontWeight: CustomString().semiBold,
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: CustomColors().greyLight,
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          data: "Overall Score : ",
                          fontSize: width * TextSize().detailsLarge,
                        ),
                        CustomText(
                          data: "7.0",
                          fontWeight: CustomString().semiBold,
                          color: CustomColors().primaryColor,
                        )
                      ],
                    ),
                    CustomText(
                      data: "22-10-2023",
                      fontSize: 12,
                      fontWeight: CustomString().regular,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(data: "L : 7.0"),
                    CustomText(data: "R : 7.0"),
                    CustomText(data: "W : 7.0"),
                    CustomText(data: "S : 7.0"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container requestContainer(double width, BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      // padding: const EdgeInsets.symmetric(vertical: 10.0),
      height: 65,
      decoration: BoxDecoration(
        color: CustomColors().white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.calendar_today,
            color: CustomColors().black,
          ),
          CustomText(
            fontSize: width * 0.03,
            fontWeight: CustomString().semiBold,
            data: "Request for your attendance?",
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: CustomColors().white,
                  title: Center(
                    child: CustomText(
                      data: "Request",
                      fontSize: 16,
                      fontWeight: CustomString().semiBold,
                      color: CustomColors().primaryColor,
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: CustomText(
                              data: "Cancel",
                              color: CustomColors().grey,
                              fontSize: 12,
                              fontWeight: CustomString().semiBold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: CustomText(
                              data: "Confirm",
                              color: CustomColors().primaryColor,
                              fontSize: 12,
                              fontWeight: CustomString().bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  actionsPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    padding: EdgeInsets.all(15),
                    width: width * 0.75,
                    height: 156,
                    child: Column(
                      children: [
                        Divider(
                          color: CustomColors().greyLight,
                          height: 1,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width * 0.75,
                          child: Flexible(
                            child: CustomText(
                              data:
                                  "Your attendance will be count for 20-05-2001 at 10:30 AM",
                              fontSize: 12,
                              textAlign: TextAlign.center,
                              textOverflow: TextOverflow.visible,
                              fontWeight: CustomString().regular,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          data: "Your request will be approved in some time.",
                          fontSize: 10,
                          fontWeight: CustomString().regular,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: width * 0.75,
                          child: Flexible(
                            child: CustomText(
                              data:
                                  "Note : If your presence is not approved when you leave, report to reception otherwise your attendance will be count as absent.",
                              fontSize: 8,
                              textAlign: TextAlign.center,
                              color: CustomColors().red,
                              textOverflow: TextOverflow.visible,
                              fontWeight: CustomString().medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: CustomText(
              data: "Request",
              fontSize: 12,
              fontWeight: CustomString().bold,
              color: CustomColors().primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Container waitingContainer(double width) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      // padding: const EdgeInsets.symmetric(vertical: 10.0),
      height: 65,
      decoration: BoxDecoration(
        color: CustomColors().white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.calendar_today,
            color: CustomColors().warning,
          ),
          CustomText(
            fontSize: width * 0.03,
            fontWeight: CustomString().semiBold,
            data: "Your request is sent, Wait for response.",
            color: CustomColors().warning,
          ),
        ],
      ),
    );
  }

  Container leaveContainer(double width, BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      // height: 65,
      decoration: BoxDecoration(
        color: CustomColors().white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, 4),
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.calendar_today,
                color: CustomColors().green,
              ),
              CustomText(
                data: "You are present for 20-05-2001 at 10:30 AM.",
                fontSize: width * 0.03,
                fontWeight: CustomString().semiBold,
                color: CustomColors().green,
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: CustomColors().white,
                  title: Center(
                    child: CustomText(
                      data: "Are you Sure?",
                      fontSize: 16,
                      fontWeight: CustomString().semiBold,
                      color: CustomColors().red,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: CustomText(
                        data: "Cancel",
                        color: CustomColors().grey,
                        fontSize: 12,
                        fontWeight: CustomString().semiBold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: CustomText(
                        data: "Leave",
                        color: CustomColors().red,
                        fontSize: 12,
                        fontWeight: CustomString().bold,
                      ),
                    ),
                  ],
                  content: SizedBox(
                    width: width * 0.75,
                    height: 36,
                    child: Column(
                      children: [
                        Divider(
                          color: CustomColors().greyLight,
                          height: 1,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: CustomText(
                            data: "You leave for 20 Aug, 2001 at 10:59 AM",
                            fontSize: width * TextSize().details,
                            // textOverflow: TextOverflow.visible,
                            fontWeight: CustomString().regular,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: CustomText(
              data: "Leave",
              color: CustomColors().red,
              fontSize: 12,
              fontWeight: CustomString().bold,
            ),
          ),
        ],
      ),
    );
  }
}
