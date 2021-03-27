import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_mentor/app/onboarding/dropdown_button.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class MentorAvailabilityView extends StatefulWidget {
  final VoidCallback onTap;

  const MentorAvailabilityView({Key? key, required this.onTap})
      : super(key: key);

  @override
  _MentorAvailabilityViewState createState() => _MentorAvailabilityViewState();
}

class _MentorAvailabilityViewState extends State<MentorAvailabilityView> {
  bool? checkboxValue = false;
  bool? checkboxValue2 = false;
  bool? checkboxValue3 = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageTitle(text: 'Your availability'),
          SizedBox(height: 24),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time commitment availability',
                    style: TextStyle(
                        color: CustomColors.appColorOrange, fontSize: 17),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyDropdownButton(
                        items: ['10', '20', '30', '40'],
                        onItemTapped: (value) {
                          print(value);
                        },
                      ),
                      MyDropdownButton(
                        items: ['Minutes', 'Hours', 'Day'],
                        onItemTapped: (value) {
                          print(value);
                        },
                      ),
                      Text('per',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 15)),
                      MyDropdownButton(
                        items: ['Week', 'Month'],
                        onItemTapped: (value) {
                          print(value);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your available schedule',
                    style: TextStyle(
                        color: CustomColors.appColorOrange, fontSize: 17),
                  ),
                  SizedBox(height: 16),
                  CustomElevatedButton(
                      child: Text(
                        'SYNC GOOGLE CALENDAR',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                      ),
                      onPressed: widget.onTap),
                  SizedBox(height: 5),
                  CustomTextButton(
                      child: Text('INPUT MANUALLY'), onPressed: () {})
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Preferred Mentee Skill Level',
                    style: TextStyle(
                        color: CustomColors.appColorOrange, fontSize: 17),
                  ),
                  SizedBox(height: 10),
                  CheckboxListTile(
                      dense: true,
                      title: Text('Novice', style: TextStyle(fontSize: 15)),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: checkboxValue,
                      activeColor: CustomColors.appColorTeal,
                      checkColor: Colors.white,
                      selectedTileColor:
                          CustomColors.appColorTeal.withOpacity(0.4),
                      onChanged: (value) {
                        setState(() {
                          checkboxValue = value;
                        });
                      }),
                  CheckboxListTile(
                      dense: true,
                      title: Text('Beginner', style: TextStyle(fontSize: 15)),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: checkboxValue2,
                      activeColor: CustomColors.appColorTeal,
                      checkColor: Colors.white,
                      selectedTileColor:
                          CustomColors.appColorTeal.withOpacity(0.4),
                      onChanged: (value) {
                        setState(() {
                          checkboxValue2 = value;
                        });
                      }),
                  CheckboxListTile(
                      dense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      title:
                          Text('Intermediate', style: TextStyle(fontSize: 15)),
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: checkboxValue3,
                      activeColor: CustomColors.appColorTeal,
                      checkColor: Colors.white,
                      selectedTileColor:
                          CustomColors.appColorTeal.withOpacity(0.4),
                      onChanged: (value) {
                        setState(() {
                          checkboxValue3 = value;
                        });
                      }),
                ],
              ),
            ),
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomElevatedButton(
                  child: Text(
                    'START',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                  ),
                  onPressed: widget.onTap),
              SizedBox(height: 5),
              CustomTextButton(child: Text('SKIP FOR NOW'), onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}
