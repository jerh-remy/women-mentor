import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_mentor/app/onboarding/dropdown_button.dart';
import 'package:women_mentor/app/onboarding/onboarding_view_model.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/app_router.gr.dart';
import 'package:women_mentor/services/firestore_database.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';

class MentorAvailabilityView extends StatefulWidget {
  final VoidCallback onTap;

  const MentorAvailabilityView({Key? key, required this.onTap})
      : super(key: key);

  @override
  _MentorAvailabilityViewState createState() => _MentorAvailabilityViewState();
}

class _MentorAvailabilityViewState extends State<MentorAvailabilityView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    final onboardingViewModel = context.read(onboardingViewModelProvider);
    onboardingViewModel.initialiseValues();
    super.initState();
  }

  Future<void> completeProfileSetupAndOnboarding(
      OnboardingViewModel onboardingViewModel) async {
    try {
      final database = context.read<FirestoreDatabase>(databaseProvider);
      await onboardingViewModel.completeProfileSetupAndOnboarding(database,
          isMentorOnboarding: true);
      context.router.push(StartUpRoute());
    } catch (e) {
      Utilities.showErrorDialog(context: context, exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer(
      builder: (BuildContext context,
          T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
        final onboardingViewModel = watch(onboardingViewModelProvider);

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
                            items: onboardingViewModel.values1,
                            onItemTapped: (value) {
                              onboardingViewModel.setValue1(value);
                            },
                          ),
                          MyDropdownButton(
                            items: onboardingViewModel.values2,
                            onItemTapped: (value) {
                              onboardingViewModel.setValue2(value);
                            },
                          ),
                          Text('per',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 15)),
                          MyDropdownButton(
                            items: onboardingViewModel.values3,
                            onItemTapped: (value) {
                              onboardingViewModel.setValue3(value);
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
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
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
                          value: onboardingViewModel.checkboxValue,
                          activeColor: CustomColors.appColorTeal,
                          checkColor: Colors.white,
                          selectedTileColor:
                              CustomColors.appColorTeal.withOpacity(0.4),
                          onChanged: (value) {
                            onboardingViewModel.setCheckBoxValue(
                                value, 'Novice');
                          }),
                      CheckboxListTile(
                          dense: true,
                          title:
                              Text('Beginner', style: TextStyle(fontSize: 15)),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: onboardingViewModel.checkboxValue2,
                          activeColor: CustomColors.appColorTeal,
                          checkColor: Colors.white,
                          selectedTileColor:
                              CustomColors.appColorTeal.withOpacity(0.4),
                          onChanged: (value) {
                            onboardingViewModel.setCheckBoxValue2(
                                value, 'Beginner');
                          }),
                      CheckboxListTile(
                          dense: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          title: Text('Intermediate',
                              style: TextStyle(fontSize: 15)),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: onboardingViewModel.checkboxValue3,
                          activeColor: CustomColors.appColorTeal,
                          checkColor: Colors.white,
                          selectedTileColor:
                              CustomColors.appColorTeal.withOpacity(0.4),
                          onChanged: (value) {
                            onboardingViewModel.setCheckBoxValue3(
                                value, 'Intermediate');
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
                        'FINISH',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                      ),
                      onPressed: () => completeProfileSetupAndOnboarding(
                          onboardingViewModel)),
                  SizedBox(height: 5),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
