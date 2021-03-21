import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dartx/dartx.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/widgets/shared/input_dropdown.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key? key,
    this.labelText,
    required this.selectedDate,
    required this.selectedTime,
    required this.onSelectedDate,
    required this.onSelectedTime,
    this.isDOB = false,
  }) : super(key: key);

  final String? labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> onSelectedDate;
  final ValueChanged<TimeOfDay> onSelectedTime;
  final bool isDOB;

  Future<void> _selectDate(BuildContext context) async {
    // final pickedDate = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate,
    //   firstDate: DateTime(1900, 1),
    //   lastDate: DateTime(2100),
    // );

    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: 216,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                    // dateTimePickerTextStyle: TextStyle(
                    //   fontFamily: UIData.museoFont,
                    //   fontSize: 18,
                    // ),
                    ),
              ),
              child: CupertinoDatePicker(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryVariant,
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate,
                  // minuteInterval: 30,
                  minimumDate: isDOB ? null : DateTime.now() - 52.weeks,
                  // maximumDate: DateTime.now() + 52.weeks,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (newDate) {
                    if (newDate != selectedDate) {
                      onSelectedDate(newDate);
                    }
                    print(newDate.toLocal());
                  }),
            ),
          );
        });
  }

  Future<void> _selectTime(BuildContext context) async {
    // final pickedTime =
    //     await showTimePicker(context: context, initialTime: selectedTime);

    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: 216,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                    // dateTimePickerTextStyle: TextStyle(
                    //   fontFamily: UIData.museoFont,
                    //   fontSize: 18,
                    // ),
                    ),
              ),
              child: CupertinoDatePicker(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryVariant,
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    selectedTime.hour,
                    selectedTime.minute,
                  ),
                  minuteInterval: 30,
                  onDateTimeChanged: (newTime) {
                    if (newTime != null && newTime != selectedDate) {
                      onSelectedTime(TimeOfDay.fromDateTime(newTime));
                    }
                    print(newTime.toLocal());
                  }),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final valueStyle = Theme.of(context).textTheme.title;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: InputDropdown(
            labelText: labelText!,
            valueText: Utilities.dateFormat(selectedDate),
            valueStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              _selectDate(context);
            },
          ),
        ),
        // SizedBox(width: 12.0),
        // Expanded(
        //   flex: 4,
        //   child: InputDropdown(
        //     valueText: Utilities.timeFormat(
        //       DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
        //           selectedTime.hour, selectedTime.minute),
        //     ),
        //     valueStyle: TextStyle(
        //       fontSize: 16.0,
        //       color: Colors.black54,
        //     ),
        //     onPressed: () => _selectTime(context),
        //   ),
        // ),
      ],
    );
  }
}
