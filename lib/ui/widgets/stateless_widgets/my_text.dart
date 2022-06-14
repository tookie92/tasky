import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String label;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;
  final Color? colors;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;

  const MyText({
    Key? key,
    required this.label,
    this.fontSize,
    this.height,
    this.textAlign,
    this.letterSpacing,
    this.maxLines,
    this.colors,
    this.fontWeight,
    this.textOverflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      style: GoogleFonts.montserrat(
        letterSpacing: letterSpacing,
        color: colors,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}
