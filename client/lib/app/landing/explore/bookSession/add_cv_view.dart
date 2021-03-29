import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/app/landing/explore/bookSession/confirmation_view.dart';
import 'package:women_mentor/app/landing/explore/bookSession/uploaded_cv.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class AddCVView extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.addCVPage,
      // arguments: job,
    );
  }

  @override
  _AddCVViewState createState() => _AddCVViewState();
}

class _AddCVViewState extends State<AddCVView> {
  bool? checkboxValue = false;
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
            child: PageTitle(text: 'Share your CV for them to get to know you'),
          ),
          Column(
            children: [
              Card(
                margin: const EdgeInsets.all(24.0),
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              UploadedCV(),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FloatingActionButton(
                                backgroundColor: CustomColors.appColorOrange,
                                onPressed: () {},
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(),
                        CheckboxListTile(
                            title: Text('Share with mentor'),
                            controlAffinity: ListTileControlAffinity.leading,
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
                        SizedBox(height: 5),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              CustomElevatedButton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text('NEXT'),
                  onPressed: () {
                    BookingConfirmationView.show(context);
                  }),
              SizedBox(height: 16),
              CustomTextButton(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text('SKIP FOR NOW'),
                  onPressed: () {
                    BookingConfirmationView.show(context);
                  }),
              // SizedBox(height: 24),
            ],
          )
        ],
      ),
    );
  }
}
