import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/search_field.dart';

class HobbiesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Your hobbies and other interests',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 20,
                      color: CustomColors.appColorOrange,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Placeholder(
            fallbackHeight: 80,
          ),
          SizedBox(
            child: SearchField(),
            height: 56,
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                'App development',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: CustomColors.appColorOrange,
                      fontSize: 18.0,
                    ),
              ),
            ],
          ),
          Wrap(
            runSpacing: 2.0,
            spacing: 8.0,
            children:
                List.generate(6, (index) => Chip(label: Text('Option $index'))),
          ),
          Spacer(),
          CustomElevatedButton(
              child: Text(
                'FINISH',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
              ),
              onPressed: () {}),
          SizedBox(height: 10),
          CustomTextButton(child: Text('SKIP FOR NOW'), onPressed: () {})
        ],
      ),
    );
  }
}
