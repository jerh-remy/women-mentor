import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_mentor/constants/colors.dart';

class CustomTheme {
  static ThemeData lightTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ThemeData(
      primaryColor: CustomColors.appColorOrange,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      highlightColor: CustomColors.appColorTeal,
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: CustomColors.appColorTeal,
      ),
      textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
          headline6: GoogleFonts.libreBaskerville(
            textStyle: textTheme.headline6!
                .copyWith(color: Colors.white, fontSize: 15),
          ),
          bodyText1: TextStyle(letterSpacing: 0.5)),
      // colorScheme: ColorScheme(
      //     brightness: isDark ? Brightness.dark : Brightness.light,
      //     primary: accent1,
      //     primaryVariant: accent1Darker,
      //     secondary: accent2,
      //     secondaryVariant: ColorUtils.shiftHsl(accent2, -.2),
      //     background: bg1,
      //     surface: surface,
      //     onBackground: txt,
      //     onSurface: txt,
      //     onError: txt,
      //     onPrimary: accentTxt,
      //     onSecondary: accentTxt,
      //     error: error ?? Colors.red.shade400),
    );
  }
}
