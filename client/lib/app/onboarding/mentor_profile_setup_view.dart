import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/landing/profile/profile_view.dart';
import 'package:women_mentor/app/onboarding/add_offer_statement_dialog.dart';
import 'package:women_mentor/app/onboarding/onboarding_view_model.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/styles.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/input_field.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class MentorProfileSetupForm extends HookWidget {
  final VoidCallback onTap;

  const MentorProfileSetupForm({Key? key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final companyController = useTextEditingController();
    final jobTitleController = useTextEditingController();
    final yearsOfExperienceController = useTextEditingController();

    final jobTitleNode = useFocusNode();
    final yearsNode = useFocusNode();

    final firebaseAuth = useProvider(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;

    final offerStatement = useState('');

    _showAddOfferStatementDialog() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Dialog(
              child: AddOfferStatementDialog(
                  text: offerStatement.value,
                  onExpertiseEntered: (value) {
                    Navigator.of(context).pop();
                    offerStatement.value = value;
                    // _editNarration(value);
                  }));
        },
      );
    }

    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(30.0),
        children: [
          PageTitle(text: 'Setup profile'),
          SizedBox(height: 24),
          Column(
            children: [
              SizedBox(
                child: ProfilePic(photoURL: user.photoURL),
                height: 70,
                width: 70,
              ),
              SizedBox(height: 8),
              Text(
                user.displayName ?? 'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // SizedBox(height: 2),
              // Text(
              //   'Role in company',
              //   style: TextStyle(
              //     color: Colors.black54,
              //     fontSize: 15,
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 24),
          InputField(
            controller: companyController,
            placeholder: 'Company',
            nextFocusNode: jobTitleNode,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 20),
          InputField(
            controller: jobTitleController,
            placeholder: 'Job Title',
            fieldFocusNode: jobTitleNode,
            nextFocusNode: yearsNode,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 20),
          InputField(
            controller: yearsOfExperienceController,
            placeholder: 'Years of experience',
            fieldFocusNode: yearsNode,
            textInputType: TextInputType.number,
            enterPressed: () => FocusScope.of(context).unfocus(),
          ),
          SizedBox(height: 20),
          Card(
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expertise to share',
                    style: TextStyle(
                        color: CustomColors.appColorOrange, fontSize: 17),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: fieldDecoration,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(offerStatement.value,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                )),
                          ),
                          IconButton(
                              visualDensity: VisualDensity.compact,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: _showAddOfferStatementDialog,
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black54,
                              ))
                        ],
                      ),
                    ),
                    onTap: _showAddOfferStatementDialog,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          CustomElevatedButton(
              child: Text(
                'NEXT',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
              ),
              onPressed: () {
                final onboardingViewModel =
                    context.read(onboardingViewModelProvider);
                onboardingViewModel.setCompany(companyController.text.trim());
                onboardingViewModel.setJobTitle(jobTitleController.text.trim());
                onboardingViewModel.setYearsOfExperience(
                    int.parse(yearsOfExperienceController.text.trim()));
                onboardingViewModel.setOfferStatement(offerStatement.value);

                onTap();
              }),
          SizedBox(height: 10),
          CustomTextButton(child: Text('SKIP FOR NOW'), onPressed: () {})
        ],
      ),
    );
  }
}

class MentorProfileSetupView extends StatefulWidget {
  final VoidCallback onTap;

  const MentorProfileSetupView({Key? key, required this.onTap})
      : super(key: key);
  @override
  _MentorProfileSetupViewState createState() => _MentorProfileSetupViewState();
}

class _MentorProfileSetupViewState extends State<MentorProfileSetupView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MentorProfileSetupForm(
      onTap: widget.onTap,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
