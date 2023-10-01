// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class BtnPrimary extends StatefulWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  final String fontFamily;
  const BtnPrimary({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.textAlign,
    required this.fontFamily,
  }) : super(key: key);

  @override
  State<BtnPrimary> createState() => _BtnPrimaryState();
}

class _BtnPrimaryState extends State<BtnPrimary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 250.0,
      height: 50.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEC6820),
            Color(0xFFFF9459),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFFF9459).withOpacity(0.5),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 25.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          widget.text,
          textAlign: widget.textAlign,
          style: TextStyle(
              color: widget.color,
              fontSize: widget.fontSize,
              letterSpacing: 2.5,
              fontFamily: widget.fontFamily),
        ),
      ),
    );
  }
}
