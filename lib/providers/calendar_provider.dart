import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasky/schemas/projects/schemas_projet.dart';
import 'package:tasky/schemas/url_endpoint.dart';
import 'package:tasky/utils/palette.dart';

import '../models/models.dart';

class CalendarProvider extends ChangeNotifier {
  String _message = "";
  // ignore: prefer_final_fields
  List<Meeting> _collection = [];
  dynamic _list = [];
  // ignore: unused_field
  final dynamic _slist = [];

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule,
    CalendarView.timelineMonth,
  ];

  String monthName(int month) {
    if (month == 01) {
      return 'January';
    } else if (month == 02) {
      return 'February';
    } else if (month == 03) {
      return 'March';
    } else if (month == 04) {
      return 'April';
    } else if (month == 05) {
      return 'May';
    } else if (month == 06) {
      return 'June';
    } else if (month == 07) {
      return 'July';
    } else if (month == 08) {
      return 'August';
    } else if (month == 09) {
      return 'September';
    } else if (month == 10) {
      return 'October';
    } else if (month == 11) {
      return 'November';
    } else {
      return 'December';
    }
  }

  final CalendarView _currentView = CalendarView.schedule;

  //getter

  CalendarView get getCurrentView => _currentView;
  List<CalendarView> get getViews => _allowedViews;

  String get getMessage => _message;
  List<Meeting> get getCollection => _collection;
  // gettter end

  final EndPoint _point = EndPoint();

  void getTask() async {
    ValueNotifier<GraphQLClient> client = _point.getClient();

    QueryResult result = await client.value
        .query(QueryOptions(document: gql(GetProjectSchema.getProjectJson)));

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isEmpty) {
        _message = "No Internet";
      } else {
        _message = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      _list = result.data!["projects"];

      notifyListeners();
    }
  }

//Quatsch

//End of Quatsch
  //get the datas
  dynamic fetchDatas() {
    if (_list.isNotEmpty) {
      final data = _list;

      return data ?? {};
    } else {
      return {};
    }
  }

  List<Meeting> getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final data = _list;
    Color color;
    for (var index = 0; index < data.length; index++) {
      switch (data[index]["categorie_id"]) {
        case 1:
          color = Palette.mikado;
          break;
        case 2:
          color = Colors.deepPurple;
          break;
        case 3:
          color = Palette.black;
          break;
        default:
          color = Colors.purple;
      }

      meetings.add(Meeting(
          eventName: data[index]["name"],
          from: DateFormat("yyyy-MM-dd HH:mm").parse(data[index]["date_begin"]),
          to: DateFormat("yyyy-MM-dd HH:mm").parse(data[index]["date_end"]),
          background: color,
          categorie: data[index]["categorie_id"],
          isAllDay: true));
    }
    return meetings;
  }
}

// fort the Calendar

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
