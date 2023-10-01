import 'package:flutter/material.dart';
import 'package:student_corner/screens/new/const.dart';
import 'package:student_corner/screens/new/custom_text_widget.dart';

class CustomTextField extends StatelessWidget {
  final bool isRequired;
  final String label;
  final bool isPassword;
  final Color labelColor;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final bool wantPadding;
  final Function onChange;
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final TextInputType textInputType;
  final Widget sufixIcon;
  final Widget prefixIcon;
  const CustomTextField({
    super.key,
    this.isRequired = false,
    required this.label,
    this.labelColor = const Color(0xFF4A4A4A),
    this.labelFontSize = 14.0,
    this.labelFontWeight = FontWeight.w500,
    required this.controller,
    this.isPassword = false,
    required this.onChange,
    required this.hintText,
    required this.textInputType,
    this.sufixIcon = const SizedBox(),
    this.prefixIcon = const SizedBox(),
    required this.validator,
    this.wantPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.76,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            data: isRequired ? "$label *" : label,
            fontSize: labelFontSize,
            fontWeight: labelFontWeight,
            color: labelColor,
          ),
          Padding(
            padding: wantPadding
                ? const EdgeInsets.symmetric(vertical: 10.0)
                : const EdgeInsets.only(top: 10.0),
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: width * 0.76,
                  decoration: BoxDecoration(
                    color: CustomColors().greyExtraLight,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                TextFormField(
                  style: commanTextStyle(),
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    onChange(value);
                  },
                  cursorColor: CustomColors().black,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller,
                  validator: validator,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: prefixIcon,
                    suffixIcon: sufixIcon,
                    hintText: hintText,
                    hintStyle: commanHintTextStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
