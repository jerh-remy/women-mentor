import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:women_mentor/widgets/shared/search_field.dart';

class HobbiesView extends StatelessWidget {
  final VoidCallback onTap;

  const HobbiesView({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageTitle(text: 'Your hobbies and other interests'),
          SizedBox(height: 24),
          Wrap(
            children: [
              InputChip(
                onPressed: () {},
                onDeleted: () {},
                backgroundColor: Colors.teal.shade50,
                deleteIconColor: CustomColors.appColorTeal,
                label: Text(
                  'Selected',
                  style: TextStyle(color: CustomColors.appColorTeal),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
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
          SizedBox(height: 10),
          Wrap(
            runSpacing: 2.0,
            spacing: 8.0,
            children: List.generate(
                6,
                (index) => Chip(
                      label: Text(
                        'Option $index',
                        style: TextStyle(
                          color: CustomColors.appColorTeal,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: CustomColors.appColorTeal,
                      ),
                    )),
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
              onPressed: onTap),
          SizedBox(height: 10),
          CustomTextButton(child: Text('SKIP FOR NOW'), onPressed: () {})
        ],
      ),
    );
  }
}
