import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:student_corner/componant/secondary_appbar.dart';
import 'package:student_corner/const/colors.dart';

class UnderConstScreen extends StatefulWidget {
  const UnderConstScreen({Key? key}) : super(key: key);

  @override
  State<UnderConstScreen> createState() => _UnderConstScreenState();
}

class _UnderConstScreenState extends State<UnderConstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackGround,
      body: Container(
        margin: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            const SecondaryAppbar(title: "", homeIndex: 0),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Lottie.asset(
                  "images/lottie/under_construction.json",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
