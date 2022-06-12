import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../../../utils/palette.dart';

class MyDateField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final String? labelText;
  final String? forValidator;
  final DateTime? initialDate;
  const MyDateField({
    Key? key,
    required this.onSaved,
    this.initialDate,
    this.labelText,
    this.forValidator,
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
      initialDate: initialDate ?? DateTime.now(),
      type: DateTimePickerType.dateTime,
      dateMask: 'dd/MM/yyyy',
      initialValue: initialDate.toString(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      //icon: const Icon(Icons.event),
      dateLabelText: 'Date',
      timeLabelText: "Hour",
      // onChanged: (val) => print(val),
      validator: (value) =>
          value!.isEmpty ? forValidator ?? "Please a date" : null,
      onSaved: onSaved,
    );
  }
}
