import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class CustomColors {
  Color blackLight = const Color(0xFF4D4D4D);
  Color white = const Color(0xFFFFFFFF);
  Color primaryColor = const Color(0xFF2F58CD);
  Color grey = const Color(0xFF999999);
  Color red = const Color(0xFFE74646);
  Color greyExtraLight = const Color(0xFFEBEBEB);
  Color greyLight = const Color(0xFFC6C6C6);
  Color primaryBackground = const Color(0xFFE2E5EE);
  Color green = const Color(0xFF7AA874);
  Color logoPrimary = const Color(0xFFC11D62);
  Color black = const Color(0xFF4A4A4A);
  Color warning = const Color(0xFFD1B74C);
  Color success = const Color(0xFF1DFF00);
}

class CustomString {
  FontWeight thin = FontWeight.w100;
  FontWeight extraLight = FontWeight.w200;
  FontWeight light = FontWeight.w300;
  FontWeight regular = FontWeight.w400;
  FontWeight medium = FontWeight.w500;
  FontWeight semiBold = FontWeight.w600;
  FontWeight bold = FontWeight.w700;
  FontWeight extraBold = FontWeight.w800;
  FontWeight black = FontWeight.w900;
}

TextStyle commanTextStyle() {
  return TextStyle(
      fontWeight: CustomString().bold,
      color: CustomColors().black,
      fontSize: 14,
      overflow: TextOverflow.ellipsis);
}

TextStyle commanHintTextStyle() {
  return TextStyle(
      fontWeight: CustomString().bold,
      color: CustomColors().grey,
      fontSize: 14,
      overflow: TextOverflow.ellipsis);
}

displaySnackbar(message, context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: message,
    backgroundColor: CustomColors().primaryBackground,
  ));
}
