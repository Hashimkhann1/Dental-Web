import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String? fontFamily;
  final double? letterSpacing;
  final double? wordSpacing;
  final double? height;

  const MyText(
      {super.key,
        required this.title,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.fontFamily,
        this.letterSpacing,
        this.wordSpacing,
        this.height,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
      TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color,fontFamily: fontFamily,letterSpacing: letterSpacing,wordSpacing: wordSpacing,height: height),
      textAlign: textAlign,
    );
  }
}