import 'package:flutter/material.dart';
import 'package:tasky/utils/palette.dart';

class MyDropdownField extends StatelessWidget {
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  final String? labelText;
  final String? initialValue;
  final String? forValidator;
  const MyDropdownField({
    Key? key,
    required this.onChanged,
    required this.items,
    this.labelText,
    this.initialValue,
    this.forValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: initialValue,
      dropdownColor: Palette.blue,
      style: const TextStyle(
        color: Colors.white,
      ),
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
      items: items,
      onChanged: onChanged,
      validator: (value) =>
          value!.isEmpty ? forValidator ?? "Please enter a categorie" : null,
    );
  }
}
