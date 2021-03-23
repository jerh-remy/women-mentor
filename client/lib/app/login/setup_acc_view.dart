import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/login/login_view_model.dart';
import 'package:women_mentor/app/login/sign_in_options_view.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/horizontal_logo.dart';
import 'package:women_mentor/widgets/shared/input_dropdown.dart';
import 'package:women_mentor/widgets/shared/input_field.dart';
import 'package:women_mentor/widgets/shared/remove_scroll_highlight.dart';

class SetupAccountView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final ethnicityController = useTextEditingController();
    final ageController = useTextEditingController();

    final loginViewModel = useProvider(loginModelProvider);

    return ProviderListener<LoginViewModel>(
      provider: loginModelProvider,
      onChange: (context, model) async {
        print(model.error);
        if (model.error != null) {
          Utilities.showErrorDialog(
            context: context,
            title: Strings.signInFailed,
            exception: model.error,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: ScrollConfiguration(
              behavior: MyCustomScrollBehavior(),
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                shrinkWrap: true,
                children: [
                  SizedBox(height: 20),
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
                    controller: emailController,
                    placeholder: 'Email',
                    // fieldFocusNode: emailFocusNode,
                    // nextFocusNode: passwordFocusNode,
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  InputField(
                    controller: passwordController,
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
                    controller: firstNameController,
                    placeholder: 'First Name',
                    // fieldFocusNode: emailFocusNode,
                    // nextFocusNode: passwordFocusNode,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 20),
                  InputField(
                    controller: lastNameController,
                    placeholder: 'Last Name',
                    // fieldFocusNode: emailFocusNode,
                    // nextFocusNode: passwordFocusNode,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 20),
                  InputField(
                    controller: ageController,
                    placeholder: 'Age',
                    // fieldFocusNode: emailFocusNode,
                    // nextFocusNode: passwordFocusNode,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  InputDropdown(
                      labelText: 'Tech level',
                      valueText: 'Beginner',
                      onPressed: () {}),
                  SizedBox(height: 20),
                  InputField(
                    controller: ethnicityController,
                    placeholder: 'Ethnicity',
                    // fieldFocusNode: emailFocusNode,
                    // nextFocusNode: passwordFocusNode,
                    textInputType: TextInputType.name,
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
                      onPressed: () {
                        loginViewModel.signInWithEmailAndPassword(
                            emailController.text.trim(),
                            passwordController.text.trim());
                      }),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
