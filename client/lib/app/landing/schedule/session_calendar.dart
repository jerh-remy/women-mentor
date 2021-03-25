import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:dartx/dartx.dart';

class SessionCalendar extends StatefulWidget {
  @override
  _SessionCalendarState createState() => _SessionCalendarState();
}

class _SessionCalendarState extends State<SessionCalendar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  // late CalendarController _calendarController;

  @override
  void initState() {
    // _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // _calendarController.dispose();
    super.dispose();
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.appColorOrange.withOpacity(0.6),
        // color: _calendarController.isSelected(date)
        //     ? Colors.brown[500]
        //     : _calendarController.isToday(date)
        //         ? Colors.brown[300]
        //         : CustomColors.appColorOrange.withOpacity(0.6),
      ),
      width: 18.0,
      height: 18.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('firstDay: ${DateTime.now() - 12.weeks}');
    print('lastDay: ${DateTime.now() + 12.weeks}');
    print('lastDay: ${DateTime(2021, 1, 1)}');

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10,
          ),
          // color: Colors.white,
          // height: MediaQuery.of(context).size.height * 0.3,
          child: TableCalendar(
            firstDay: DateTime(2021, 1, 1),
            focusedDay: DateTime.now(),
            lastDay: DateTime(2021, 12, 31),
            rowHeight: 50.0,
            calendarFormat: CalendarFormat.month,
            // locale: 'pl_PL',
            // calendarController: _calendarController,
            // events: model.events,
            // holidays: _holidays,
            formatAnimationDuration: Duration(milliseconds: 300),
            // formatAnimation: FormatAnimation.scale,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            availableGestures: AvailableGestures.horizontalSwipe,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week',
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              // weekdayStyle: TextStyle()
              //     .copyWith(color: Colors.grey[600], fontSize: 13.0),
              // weekendStyle: TextStyle()
              //     .copyWith(color: CustomColors.appColorTeal, fontSize: 13.0),
              // holidayStyle: TextStyle()
              //     .copyWith(color: CustomColors.appColorTeal, fontSize: 13.0),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle()
                  .copyWith(color: CustomColors.appColorTeal, fontSize: 14.0),
              weekdayStyle: TextStyle().copyWith(fontSize: 14.0),
            ),
            headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
                titleTextStyle:
                    TextStyle(color: CustomColors.appColorTeal, fontSize: 18)
                // formatButtonShowsNext: true,
                // formatButtonTextStyle:
                //     TextStyle().copyWith(color: Colors.white, fontSize: 14.0),
                // formatButtonDecoration: BoxDecoration(
                //   color: CustomColors.appColorOrange.withOpacity(0.8),
                //   borderRadius: BorderRadius.circular(16.0),
                // ),
                ),
            // calendarBuilders: CalendarBuilders(
            //   selectedBuilder: (context, date, _) {
            //     return FadeTransition(
            //       opacity:
            //           Tween(begin: 0.0, end: 1.0).animate(_animationController),
            //       child: Container(
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: CustomColors.appColorTeal.withOpacity(0.8),
            //         ),
            //         margin: const EdgeInsets.all(4.0),
            //         alignment: Alignment.center,
            //         // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            //         width: 100,
            //         height: 100,
            //         child: Text(
            //           '${date.day}',
            //           style: TextStyle().copyWith(
            //             fontSize: 13.5,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            //   todayBuilder: (context, date, _) {
            //     return Container(
            //       margin: const EdgeInsets.all(4.0),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: CustomColors.appColorOrange.withOpacity(0.6),
            //       ),
            //       alignment: Alignment.center,
            //       // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            //       width: 100,
            //       height: 100,
            //       child: Text(
            //         '${date.day}',
            //         style: TextStyle().copyWith(fontSize: 13.5),
            //       ),
            //     );
            //   },
            //   markerBuilder: (context, date, events) {
            //     var marker;

            //     if (events.isNotEmpty) {
            //       marker = Positioned(
            //         right: 1,
            //         bottom: 1,
            //         child: _buildEventsMarker(date, events),
            //       );
            //     }

            //     // if (holidays.isNotEmpty) {
            //     //   children.add(
            //     //     Positioned(
            //     //       right: -2,
            //     //       top: -2,
            //     //       child: _buildHolidaysMarker(),
            //     //     ),
            //     //   );
            //     // }

            //     return marker;
            //   },
            // ),

            // onDaySelected: (date, events) {
            //   model.onDaySelected(date, events);
            //   _animationController.forward(from: 0.0);
            // },
            // onVisibleDaysChanged: model.onVisibleDaysChanged,
            // onCalendarCreated: model.onCalendarCreated,
          ),
        ),
      ],
    );
  }
}
