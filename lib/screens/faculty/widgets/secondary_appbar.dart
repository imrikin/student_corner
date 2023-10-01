import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:student_corner/componant/text_field.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/home.dart';

class SecondaryAppbar extends StatelessWidget {
  final String title;
  final int homeIndex;
  final Color color;
  const SecondaryAppbar(
      {Key? key,
      required this.title,
      required this.homeIndex,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 55,
      child: Row(
        children: [
          SizedBox(
            width: 55,
            height: 55,
            child: InkWell(
              onTap: () {
                // Navigator.pop(context);
                if (homeIndex == 100) {
                  // Navigator.of(context).pop();
                  Get.back();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(
                        index: homeIndex,
                      ),
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: kPrimary,
              ),
            ),
          ),
          TextFieldCus(
              text: title,
              color: color,
              fontSize: 20.0,
              width: 0.84,
              textAlign: TextAlign.start,
              fontFamily: 'hanuman-black')
        ],
      ),
    );
  }
}
