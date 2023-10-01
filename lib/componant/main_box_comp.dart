import 'package:flutter/material.dart';

class MainBoxComp extends StatelessWidget {
  const MainBoxComp({
    Key? key,
    required this.size,
    this.height = 110,
    required this.widgets,
  }) : super(key: key);

  final Size size;
  final double height;
  final Widget widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.91,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            offset: const Offset(
              0.0,
              10.0,
            ),
            blurRadius: 15.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: widgets,
    );
  }
}
