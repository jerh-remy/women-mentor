import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 20,
                  color: CustomColors.appColorOrange,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
