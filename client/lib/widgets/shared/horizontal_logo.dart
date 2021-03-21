import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';

class HorizontalLogo extends StatelessWidget {
  const HorizontalLogo({
    Key? key,
    this.logoHeight: 48,
    this.textSize: 18,
  }) : super(key: key);
  final double logoHeight;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Strings.logo,
          height: logoHeight,
          color: CustomColors.appColorTeal,
          semanticsLabel: 'Women Mentor Logo',
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 12.0)),
            Text(
              'Women',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: textSize,
                  color: CustomColors.appColorTeal,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Mentor',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: textSize,
                  color: CustomColors.appColorTeal,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
          ],
        ),
      ],
    );
  }
}
