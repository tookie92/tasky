import 'package:flutter/material.dart';

import '../../../utils/palette.dart';

class MyTextForm extends StatelessWidget {
  final String? labelText;
  final String? forValidator;
  final String? initialValue;
  final int? maxLines;
  final bool? obscureText;
  final void Function(String?)? onSaved;
  const MyTextForm({
    this.obscureText,
    this.onSaved,
    this.initialValue,
    this.labelText,
    this.maxLines,
    this.forValidator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: Palette.blue,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        filled: true,
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Palette.blue,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Palette.pumpkin,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) =>
          value!.isEmpty ? forValidator ?? "Please Enter Something" : null,
      onSaved: onSaved,
    );
  }
}
