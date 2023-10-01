// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InputBoxComp extends StatelessWidget {
  final Widget widget;
  final double width;
  const InputBoxComp({Key? key, required this.widget, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 5.0),
      width: size.width * width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFFC4C4C4).withOpacity(0.5)),
      child: widget,
    );
  }
}
