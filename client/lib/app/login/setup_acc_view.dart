import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/horizontal_logo.dart';
import 'package:women_mentor/widgets/shared/input_dropdown.dart';
import 'package:women_mentor/widgets/shared/input_field.dart';
import 'package:women_mentor/widgets/shared/remove_scroll_highlight.dart';

class SetupAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              EdgeInsets.only(left: 24.0, right: 24.0, top: 20, bottom: 16.0),
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              children: [
                HorizontalLogo(
                  logoHeight: 32,
                  textSize: 12,
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Setup your account',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20,
                            color: CustomColors.appColorOrange,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                InputField(
                  // controller: email,
                  placeholder: 'Email',
                  // fieldFocusNode: emailFocusNode,
                  // nextFocusNode: passwordFocusNode,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                InputField(
                  // controller: password,
                  placeholder: 'Password',
                  password: true,
                  // fieldFocusNode: passwordFocusNode,
                  textInputAction: TextInputAction.done,
                  enterPressed: () {},
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Tell us a bit about you',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: CustomColors.appColorOrange,
                            fontSize: 18.0,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                InputField(
                  // controller: email,
                  placeholder: 'Name',
                  // fieldFocusNode: emailFocusNode,
                  // nextFocusNode: passwordFocusNode,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                InputField(
                  // controller: email,
                  placeholder: 'Age',
                  // fieldFocusNode: emailFocusNode,
                  // nextFocusNode: passwordFocusNode,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                InputDropdown(
                    labelText: 'Tech level',
                    valueText: 'Beginner',
                    onPressed: () {}),
                SizedBox(height: 20),
                InputField(
                  // controller: email,
                  placeholder: 'Ethnicity',
                  // fieldFocusNode: emailFocusNode,
                  // nextFocusNode: passwordFocusNode,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 40),
                CustomElevatedButton(
                    child: Text(
                      'SUBMIT',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
