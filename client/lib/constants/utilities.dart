import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:intl/intl.dart';

class Utilities {
  static String hours(double hours) {
    final hoursNotNegative = hours < 0.0 ? 0.0 : hours;
    final hoursString = hours <= 1.0 ? 'hour' : 'hours';
    final formatter = NumberFormat.decimalPattern();
    final formatted = formatter.format(hoursNotNegative);
    return '$formatted $hoursString';
  }

  static String date(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String lastLoginDate(DateTime date) {
    return '${Utilities.dateFormat(date)} at ${Utilities.timeFormat(DateTime(date.year, date.month, date.day, date.hour, date.minute))}';
  }

  static String dayOfWeek(DateTime date) {
    return DateFormat.E().format(date);
  }

  static String currency(double pay) {
    if (pay != 0.0) {
      final formatter = NumberFormat.simpleCurrency(decimalDigits: 0);
      return formatter.format(pay);
    }
    return '';
  }

  static String formatAmounts(dynamic amt) {
    String formattedAmt;
    final formatter = new NumberFormat("#,##0.00", "en_US");
    // final formatter = new NumberFormat.simpleCurrency();

    if (amt == null || amt.isEmpty || amt == '0') {
      amt = "0,000.00";
      formattedAmt = amt;
    } else {
      double amtDouble = double.parse(amt);
      formattedAmt = formatter.format(amtDouble);
    }

    return formattedAmt;
  }

  static String dateFormat(DateTime date) {
    return DateFormat.yMMMMd('en_US').format(date);
    // return DateFormat('E, d MMM, yyyy').format(date);
    // return DateFormat.yMMMEd('en_US').format(date);
    // return DateFormat("dd-MMM-yyyy").format(date);
    // return DateFormat.d().add_yMMM().format(date);
  }

  static String dateFormat2(DateTime date) {
    return DateFormat.yMMMMd('en_US').format(date);
    // return DateFormat('E, d MMM, yyyy').format(date);
    // return DateFormat.yMMMEd('en_US').format(date);
    // return DateFormat("dd-MMM-yyyy").format(date);
    // return DateFormat.d().add_yMMM().format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat.jm('en_US').format(date);
  }

  static String getGreeting() {
    DateTime dateTime = DateTime.now();
    int hours = dateTime.hour;
    print('hours: $hours');
    String greeting;
    if (hours >= 00 && hours < 12) {
      greeting = 'Good morning';
    } else if (hours >= 12 && hours < 16) {
      greeting = "Good afternoon";
    } else {
      greeting = 'Good evening';
    }
    return greeting;
  }

  static Icon getGreetingIcon() {
    DateTime dateTime = DateTime.now();
    int hours = dateTime.hour;
    print('hours: $hours');
    Icon greetingIcon;
    if (hours >= 00 && hours < 12) {
      greetingIcon = Icon(
        Icons.wb_sunny,
        color: Colors.black54,
        size: 16,
      );
    } else if (hours >= 12 && hours < 16) {
      greetingIcon = Icon(
        FontAwesomeIcons.sun,
        color: Colors.black54,
        size: 16,
      );
    } else {
      greetingIcon = Icon(
        FontAwesomeIcons.moon,
        color: Colors.black54,
        size: 16,
      );
    }
    return greetingIcon;
  }

  static void showSuccessDialog(
      BuildContext context, String? successMessage, Function onButtonPressed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Successful',
        ),
        content: Text(
          successMessage ?? '',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: CustomColors.appColorTeal,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              onButtonPressed();
            },
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(
      BuildContext context, PlatformException exception) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Operation failed',
        ),
        content: Text(
          exception.message ?? 'Error',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: CustomColors.appColorTeal,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
