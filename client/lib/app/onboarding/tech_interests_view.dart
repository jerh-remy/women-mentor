import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/onboarding/onboarding_view_model.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class TechInterestsView extends StatefulWidget {
  final VoidCallback onTap;

  const TechInterestsView({Key? key, required this.onTap}) : super(key: key);

  @override
  _TechInterestsViewState createState() => _TechInterestsViewState();
}

class _TechInterestsViewState extends State<TechInterestsView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageTitle(text: 'Tech related interests'),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                'Please select up to 5 interests',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: CustomColors.appColorOrange,
                      fontSize: 18.0,
                    ),
              ),
            ],
          ),
          SizedBox(height: 10),
          InterestChips(),
          Spacer(),
          CustomElevatedButton(
              child: Text(
                'NEXT',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
              ),
              onPressed: widget.onTap),
          SizedBox(height: 10),
          CustomTextButton(child: Text('SKIP FOR NOW'), onPressed: widget.onTap)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class InterestChips extends ConsumerWidget {
  const InterestChips({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final onboardingViewModel = watch(onboardingViewModelProvider);
    final bool canSelect = onboardingViewModel.selectedInterests.length != 5;
    final interestsAsyncValue = watch(interestsStreamProvider);
    return interestsAsyncValue.when(
      data: (interests) {
        final techInterests = interests.techInterests;
        return Wrap(
          spacing: 6.0,
          children: List.generate(
              techInterests!.length,
              (index) => InterestChip(
                    techInterest: techInterests[index],
                    canSelect: canSelect ||
                        onboardingViewModel.selectedInterests
                            .contains(techInterests[index]),
                    onSelected: (isSelected) {
                      isSelected
                          ? onboardingViewModel
                              .addInterest(techInterests[index])
                          : onboardingViewModel
                              .removeInterest(techInterests[index]);
                    },
                  )),
        );
      },
      loading: () => Container(),
      error: (err, st) => Container(),
    );
  }
}

class InterestChip extends StatefulWidget {
  const InterestChip({
    Key? key,
    required this.techInterest,
    required this.onSelected,
    required this.canSelect,
  }) : super(key: key);

  final String techInterest;
  final bool canSelect;
  final Function(bool) onSelected;

  @override
  _InterestChipState createState() => _InterestChipState();
}

class _InterestChipState extends State<InterestChip> {
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
        widget.techInterest,
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
