import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../../utils/palette.dart';

class MyDateField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? labelDate;
  final String? labelHour;
  final String? forValidator;
  final String? initialValue;
  final DateTime? initialDate;
  const MyDateField({
    Key? key,
    required this.onSaved,
    this.initialDate,
    this.labelDate,
    this.labelHour,
    this.forValidator,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: Palette.blue,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        filled: true,
        // labelText: labelText,
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
      initialDate: initialDate ?? DateTime.now(),
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'dd/MM/yyyy',
      initialValue: initialValue ?? initialDate.toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      //icon: const Icon(Icons.event),
      dateLabelText: labelDate,
      timeLabelText: labelHour,
      // onChanged: (val) => print(val),
      validator: (value) =>
          value!.isEmpty ? forValidator ?? "Please a date" : null,
      onSaved: onSaved,
    );
  }
}
