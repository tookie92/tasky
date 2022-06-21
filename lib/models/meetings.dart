import 'package:flutter/material.dart';

class Meeting {
  Meeting(
      {this.eventName,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.categorie});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  int? categorie;
  bool? isAllDay;
}
