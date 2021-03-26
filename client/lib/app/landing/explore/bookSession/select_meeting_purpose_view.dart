import 'package:flutter/material.dart';
import 'package:women_mentor/app/landing/explore/bookSession/add_cv_view.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class SelectMeetingPurposeView extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.selectMeetingPurposePage,
      // arguments: job,
    );
  }

  @override
  _SelectMeetingPurposeViewState createState() =>
      _SelectMeetingPurposeViewState();
}

class _SelectMeetingPurposeViewState extends State<SelectMeetingPurposeView> {
  bool? checkboxValue = false;
  bool? checkboxValue2 = false;
  bool? checkboxValue3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: PageTitle(text: 'What do you want to talk about?'),
          ),
          Column(
            children: [
              Card(
                margin: const EdgeInsets.all(24.0),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CheckboxListTile(
                          title: Text('Career Advice'),
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
                      Divider(),
                      CheckboxListTile(
                          title: Text('Technical advice'),
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
                      Divider(),
                      CheckboxListTile(
                          title: Text('Chat'),
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
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              CustomElevatedButton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text('NEXT'),
                  onPressed: () {
                    AddCVView.show(context);
                  }),
              SizedBox(height: 16),
              CustomTextButton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text('NOT SURE YET'),
                  onPressed: () {
                    AddCVView.show(context);
                  }),
              SizedBox(height: 24),
            ],
          )
        ],
      ),
    );
  }
}
