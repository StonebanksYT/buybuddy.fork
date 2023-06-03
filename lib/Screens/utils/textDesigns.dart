import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
 final  String text;
  final double? fontSize;
  final FontWeight? fontWeight;
 final  Color? textColor;
  CustomText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont("Nunito",textStyle:TextStyle(
          fontSize: fontSize ?? 24,
          color: textColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.bold)),
    );
  }
}

