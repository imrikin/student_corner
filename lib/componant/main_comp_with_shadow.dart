import 'package:flutter/material.dart';

class MainBoxCompWithoutShadow extends StatelessWidget {
  const MainBoxCompWithoutShadow({
    Key? key,
    required this.size,
    required this.height,
    required this.widgets,
  }) : super(key: key);

  final Size size;
  final double height;
  final Widget widgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: widgets,
    );
  }
}
