import 'package:flutter/material.dart';

class TextFieldCus extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  final double width;
  final String fontFamily;
  const TextFieldCus({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.textAlign,
    this.width = 0.1,
    required this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: Text(
        text,
        textAlign: textAlign,
        // ignore: prefer_const_constructors
        style:
            TextStyle(color: color, fontSize: fontSize, fontFamily: fontFamily),
      ),
    );
  }
}
