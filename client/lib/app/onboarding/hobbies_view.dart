import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/onboarding/onboarding_view_model.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/app_router.gr.dart';
import 'package:women_mentor/services/firestore_database.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class HobbiesView extends StatefulWidget {
  final VoidCallback? onTap;
  final bool isMentorOnboarding;

  const HobbiesView({Key? key, this.onTap, this.isMentorOnboarding = false})
      : super(key: key);
  @override
  _HobbiesViewState createState() => _HobbiesViewState();
}

class _HobbiesViewState extends State<HobbiesView>
    with AutomaticKeepAliveClientMixin {
  Future<void> completeProfileSetupAndOnboarding() async {
    try {
      final database = context.read<FirestoreDatabase>(databaseProvider);
      final OnboardingViewModel onboardingViewModel =
          context.read<OnboardingViewModel>(onboardingViewModelProvider);
      await onboardingViewModel.completeProfileSetupAndOnboarding(database);
      context.router.push(StartUpRoute());
    } catch (e) {
      Utilities.showErrorDialog(context: context, exception: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageTitle(text: 'Your hobbies and other interests'),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Please select up to 5 hobbies',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: CustomColors.appColorOrange,
                      fontSize: 18.0,
                    ),
              ),
            ],
          ),
          SizedBox(height: 10),
          HobbiesChips(),
          Spacer(),
          CustomElevatedButton(
              child: Text(
                widget.isMentorOnboarding ? 'NEXT' : 'FINISH',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
              ),
              onPressed: () {
                widget.isMentorOnboarding
                    ? widget.onTap!()
                    : completeProfileSetupAndOnboarding();
              }),
          SizedBox(height: 10),
          // CustomTextButton(child: Text('SKIP FOR NOW'), onPressed: () {})
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HobbiesChips extends ConsumerWidget {
  const HobbiesChips({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final onboardingViewModel = watch(onboardingViewModelProvider);
    final bool canSelect = onboardingViewModel.selectedHobbies.length != 5;
    final interestsAsyncValue = watch(interestsStreamProvider);
    return interestsAsyncValue.when(
      data: (interests) {
        final hobbies = interests.hobbies;
        return Wrap(
          spacing: 6.0,
          children: List.generate(
              hobbies!.length,
              (index) => HobbyChip(
                    hobby: hobbies[index],
                    canSelect: canSelect ||
                        onboardingViewModel.selectedHobbies
                            .contains(hobbies[index]),
                    onSelected: (isSelected) {
                      isSelected
                          ? onboardingViewModel.addHobby(hobbies[index])
                          : onboardingViewModel.removeHobby(hobbies[index]);
                    },
                  )),
        );
      },
      loading: () => Container(),
      error: (err, st) => Container(),
    );
  }
}

class HobbyChip extends StatefulWidget {
  const HobbyChip({
    Key? key,
    required this.hobby,
    required this.canSelect,
    required this.onSelected,
  }) : super(key: key);

  final String hobby;
  final bool canSelect;
  final Function(bool) onSelected;

  @override
  _HobbyChipState createState() => _HobbyChipState();
}

class _HobbyChipState extends State<HobbyChip> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      selected: isSelected,
      selectedColor: CustomColors.appColorTeal.withOpacity(0.2),
      checkmarkColor: CustomColors.appColorTeal,
      labelStyle: TextStyle(
        color: CustomColors.appColorTeal,
      ),
      label: Text(
        widget.hobby,
        style: TextStyle(
          color: CustomColors.appColorTeal,
        ),
      ),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: CustomColors.appColorTeal,
      ),
      onSelected: (bool value) {
        if (widget.canSelect) {
          setState(() {
            isSelected = value;
          });
          widget.onSelected(isSelected);
        }
      },
    );
  }
}
