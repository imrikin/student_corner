import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final String fontfamily;
  final int letterSpacing;
  const CustomText(
      {Key? key,
      required this.text,
      this.size = 18,
      this.color = Colors.black,
      this.fontfamily = "Hanuman",
      this.letterSpacing = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontFamily: fontfamily,
          letterSpacing: 1),
    );
  }
}
