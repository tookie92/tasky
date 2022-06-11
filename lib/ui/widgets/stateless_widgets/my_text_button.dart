import 'package:flutter/material.dart';
import 'package:tasky/ui/widgets/stateless_widgets/my_text.dart';

class MyTextButton extends StatelessWidget {
  final Color? primary;
  final Color? backgroundColor;
  final double? vertical;
  final double? horizontal;
  final void Function()? onPressed;
  final String? label;

  const MyTextButton(
      {Key? key,
      this.primary,
      this.backgroundColor,
      this.vertical,
      this.horizontal,
      required this.onPressed,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: primary,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(9.0))),
        padding: EdgeInsets.symmetric(
          vertical: vertical ?? 10.0,
          horizontal: horizontal ?? 20.0,
        ),
      ),
      onPressed: onPressed,
      child: MyText(
        label: label!,
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
