import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/widgets/shared/input_field.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class MentorProfileSetupView extends HookWidget {
  final VoidCallback onTap;

  const MentorProfileSetupView({Key? key, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final companyController = useTextEditingController();
    final jobTitleController = useTextEditingController();
    final yearsOfExperienceController = useTextEditingController();
    final expertiseController = useTextEditingController();

    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(30.0),
        children: [
          PageTitle(text: 'Setup profile'),
          SizedBox(height: 24),
          Column(
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.grey.shade100,
              ),
              SizedBox(height: 8),
              Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Role in company',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          InputField(
            controller: companyController,
            placeholder: 'Company',
            // fieldFocusNode: emailFocusNode,
            // nextFocusNode: passwordFocusNode,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 20),
          InputField(
            controller: jobTitleController,
            placeholder: 'Job Title',
            // fieldFocusNode: emailFocusNode,
            // nextFocusNode: passwordFocusNode,
            textInputType: TextInputType.text,
          ),
          SizedBox(height: 20),
          InputField(
            controller: yearsOfExperienceController,
            placeholder: 'Years of experience',
            // fieldFocusNode: emailFocusNode,
            // nextFocusNode: passwordFocusNode,
            textInputType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expertise to share',
                    style: TextStyle(
                        color: CustomColors.appColorOrange, fontSize: 17),
                  ),
                  SizedBox(height: 10),
                  InputField(
                    controller: expertiseController,
                    placeholder: 'Add new',
                    // fieldFocusNode: emailFocusNode,
                    // nextFocusNode: passwordFocusNode,
                    textInputType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    runSpacing: 2.0,
                    spacing: 8.0,
                    children: List.generate(
                        3,
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
              onPressed: onTap),
          SizedBox(height: 10),
          CustomTextButton(child: Text('SKIP FOR NOW'), onPressed: () {})
        ],
      ),
    );
  }
}
