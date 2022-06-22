import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:tasky/providers/all_providers.dart';
import 'package:tasky/utils/palette.dart';

import '../../../models/meetings.dart';
import '../../widgets/stateless_widgets/allstateless.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFetched = false;
    final size = MediaQuery.of(context).size;

    return Consumer<CalendarProvider>(
      builder: (context, mycalendar, child) {
        if (isFetched == false) {
          mycalendar.getTask();

          Future.delayed(const Duration(seconds: 3), () => isFetched = true);
        }
        return SizedBox(
          height: size.height,
          child: SfCalendar(
            view: mycalendar.getCurrentView,
            backgroundColor: Palette.blue,
            //allowedViews: mycalendar.getViews,
            todayHighlightColor: Palette.pumpkin,
            initialDisplayDate: DateTime.now(),
            initialSelectedDate: DateTime.now(),
            allowDragAndDrop: true,
            allowViewNavigation: true,
            scheduleViewSettings: ScheduleViewSettings(
              hideEmptyScheduleWeek: true,
              appointmentItemHeight: 70,
              appointmentTextStyle: GoogleFonts.montserrat(
                color: Colors.white,
              ),
              dayHeaderSettings: DayHeaderSettings(
                dayFormat: 'EEEE',
                width: 70,
                dayTextStyle: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
                dateTextStyle: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              weekHeaderSettings: WeekHeaderSettings(
                startDateFormat: 'dd MMM ',
                endDateFormat: 'dd MMM, yy',
                height: 50,
                textAlign: TextAlign.center,
                backgroundColor: Palette.oxford,
                weekTextStyle: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 15,
                ),
              ),
            ),
            dataSource: MeetingDataSource(mycalendar.getDataSource()),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),

            scheduleViewMonthHeaderBuilder: (context, details) {
              final String monthName = mycalendar.monthName(details.date.month);
              return Container(
                decoration: const BoxDecoration(color: Palette.mikado),
                child: MyText(label: "$monthName  ${details.date.year}"),
              );
            },
            appointmentBuilder: (context, details) {
              final dynamic event = details.appointments.first;
              late final Meeting meeting;
              if (event is Meeting) {
                meeting = event;
              }

              return Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                //height: 200,
                width: 8,
                decoration: BoxDecoration(
                    color: Palette.mikado,
                    borderRadius: BorderRadius.circular(05.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      label: "${meeting.eventName}",
                      colors: Colors.white,
                      fontSize: 15.0,
                    ),
                    const SizedBox(
                      height: 03.0,
                    ),
                    MyText(
                      colors: Colors.white,
                      label:
                          " ${DateFormat("hh:mm a").format(meeting.from!)} - ${DateFormat("hh:mm a").format(meeting.to!)} ",
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
