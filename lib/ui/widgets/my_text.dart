import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String label;
  final double? fontSize;
  final double? height;
  final double? letterSpacing;
  final Color? colors;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;

  const MyText({
    Key? key,
    required this.label,
    this.fontSize,
    this.height,
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
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        letterSpacing: letterSpacing,
        color: colors,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}
