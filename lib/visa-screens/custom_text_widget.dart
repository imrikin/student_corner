import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  final FontWeight fontWeight;
  final Color color;
  final double fontSize;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  const CustomText(
      {super.key,
      required this.data,
      this.fontWeight = FontWeight.w500,
      this.color = const Color(0xFF4A4A4A),
      this.fontSize = 14,
      this.textOverflow = TextOverflow.ellipsis,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: fontWeight,
          color: color,
          letterSpacing: 0.5,
          fontSize: fontSize,
          overflow: textOverflow),
    );
  }
}
