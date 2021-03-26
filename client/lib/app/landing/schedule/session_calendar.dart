import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:dartx/dartx.dart';

class SessionCalendar extends StatefulWidget {
  final Function(DateTime) onDaySelected;
  final List events;

  const SessionCalendar(
      {Key? key, required this.onDaySelected, required this.events})
      : super(key: key);
  @override
  _SessionCalendarState createState() => _SessionCalendarState();
}

class _SessionCalendarState extends State<SessionCalendar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late DateTime _currentlySelectedDate = DateTime.now();

  @override
  void initState() {
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

  var _daysOfWeekStyle = DaysOfWeekStyle(
    dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0],
    weekendStyle:
        TextStyle().copyWith(color: CustomColors.appColorTeal, fontSize: 14.0),
    weekdayStyle:
        TextStyle().copyWith(color: CustomColors.appColorTeal, fontSize: 14.0),
  );

  var _headerStyle = HeaderStyle(
      titleCentered: true,
      formatButtonVisible: false,
      leftChevronIcon: const Icon(
        Icons.chevron_left,
        color: CustomColors.appColorTeal,
      ),
      leftChevronMargin: const EdgeInsets.symmetric(horizontal: 2.0),
      rightChevronIcon: const Icon(
        Icons.chevron_right,
        color: CustomColors.appColorTeal,
      ),
      rightChevronMargin: const EdgeInsets.symmetric(horizontal: 2.0),
      headerPadding: EdgeInsets.symmetric(vertical: 4),
      titleTextStyle:
          TextStyle(color: CustomColors.appColorTeal, fontSize: 18));

  Widget _todayBuilder(DateTime date) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CustomColors.appColorOrange.withOpacity(0.6),
      ),
      alignment: Alignment.center,
      // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
      width: 100,
      height: 100,
      child: Text(
        '${date.day}',
        style: TextStyle().copyWith(fontSize: 13.5),
      ),
    );
  }

  Widget _selectedBuilder(DateTime date, DateTime focusedDate) {
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.appColorTeal.withOpacity(0.8),
        ),
        margin: const EdgeInsets.all(4.0),
        alignment: Alignment.center,
        // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
        width: 100,
        height: 100,
        child: Text(
          '${date.day}',
          style: TextStyle().copyWith(
            fontSize: 13.5,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print('firstDay: ${DateTime.now() - 12.weeks}');
    // print('lastDay: ${DateTime.now() + 12.weeks}');
    // print('lastDay: ${DateTime(2021, 1, 1)}');

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 0,
          ),
          child: TableCalendar(
            eventLoader: null,
            firstDay: DateTime(DateTime.now().year, 1, 1),
            focusedDay: _currentlySelectedDate,
            lastDay: DateTime(DateTime.now().year, 12, 31),
            rowHeight: 50.0,
            daysOfWeekHeight: 30,
            calendarFormat: CalendarFormat.month,
            // pageJumpingEnabled: true,
            // locale: 'pl_PL',
            formatAnimationDuration: Duration(milliseconds: 300),
            selectedDayPredicate: (date) {
              return _currentlySelectedDate == date;
            },
            onDaySelected: (date, focusedDate) {
              // model.onDaySelected(date, events);
              widget.onDaySelected(date);
              setState(() {
                _currentlySelectedDate = date;
              });
              print('date: $date    focused: $focusedDate');
              _animationController.forward(from: 0.0);
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            availableGestures: AvailableGestures.horizontalSwipe,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week',
            },
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
              // weekdayStyle: TextStyle()
              //     .copyWith(color: Colors.grey[600], fontSize: 13.0),

              // holidayStyle: TextStyle()
              //     .copyWith(color: CustomColors.appColorTeal, fontSize: 13.0),
            ),
            daysOfWeekStyle: _daysOfWeekStyle,
            headerStyle: _headerStyle,
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, focusedDate) {
                return _selectedBuilder(date, focusedDate);
              },
              todayBuilder: (context, date, _) {
                return _todayBuilder(date);
              },
              markerBuilder: (context, date, events) {
                var marker;

                if (events.isNotEmpty) {
                  marker = Positioned(
                    right: 1,
                    bottom: 1,
                    child: _buildEventsMarker(date, events),
                  );
                } else {
                  marker = SizedBox.shrink();
                  // marker = AnimatedContainer(
                  //   duration: const Duration(milliseconds: 200),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: CustomColors.appColorOrange.withOpacity(0.8),
                  //     // color: _calendarController.isSelected(date)
                  //     //     ? Colors.brown[500]
                  //     //     : _calendarController.isToday(date)
                  //     //         ? Colors.brown[300]
                  //     //         : CustomColors.appColorOrange.withOpacity(0.6),
                  //   ),
                  //   width: 6.0,
                  //   height: 6.0,
                  // );
                }

                // if (holidays.isNotEmpty) {
                //   children.add(
                //     Positioned(
                //       right: -2,
                //       top: -2,
                //       child: _buildHolidaysMarker(),
                //     ),
                //   );
                // }

                return marker;
              },
            ),
          ),
        ),
      ],
    );
  }
}
