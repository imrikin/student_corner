import 'package:flutter/material.dart';
import 'package:student_corner/const/colors.dart';
import 'package:student_corner/screens/faculty/widgets/custom_text.dart';

class HomeBoxContainer extends StatelessWidget {
  const HomeBoxContainer({
    Key? key,
    required this.width,
    required this.size,
    required this.function,
    required this.title,
    required this.count,
  }) : super(key: key);

  final double width;
  final Size size;
  final Function function;
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: size.width * width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0.0, 0.0),
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.25),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: count,
                  fontfamily: 'Hanuman-Light',
                  color: kPrimary,
                  size: 48,
                ),
                InkWell(
                  onTap: () {
                    function();
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kPrimary,
                    size: 24,
                  ),
                ),
              ],
            ),
            CustomText(
              text: title,
              fontfamily: 'Hanuman-bold',
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
