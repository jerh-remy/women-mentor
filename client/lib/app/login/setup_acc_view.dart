import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/login/login_view_model.dart';
import 'package:women_mentor/app/login/sign_in_options_view.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/app_router.gr.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/horizontal_logo.dart';
import 'package:women_mentor/widgets/shared/input_dropdown.dart';
import 'package:women_mentor/widgets/shared/input_field.dart';
import 'package:women_mentor/widgets/shared/remove_scroll_highlight.dart';
import 'package:auto_route/auto_route.dart';

class SetupAccountView extends HookWidget {
  final bool isSigningUp;

  SetupAccountView(this.isSigningUp);

  void signUp({
    required LoginViewModel loginViewModel,
    required BuildContext context,
    required String email,
    required String password,
    required String confirmPassword,
    required String firstName,
    required String lastName,
    required String techLevel,
    int? age,
    String? ethnicity,
  }) {
    FocusScope.of(context).unfocus();
    if (email.isEmpty) {
      Utilities.displayErrorSnackBar(context, 'Email cannot be empty');
      return;
    }
    if (password.isEmpty) {
      Utilities.displayErrorSnackBar(context, 'Password cannot be empty');
      return;
    }

    if (password != confirmPassword) {
      Utilities.displayErrorSnackBar(context, 'Passwords do not match');
      return;
    }

    loginViewModel
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          techLevel: techLevel,
          age: age,
          ethnicity: ethnicity,
        )
        .then((value) => context.router.push(OnboardingRoute()));
  }

  void login({
    required LoginViewModel loginViewModel,
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      FocusScope.of(context).unfocus();
      if (email.isEmpty) {
        Utilities.displayErrorSnackBar(context, 'Email cannot be empty');
        return;
      }
      if (password.isEmpty) {
        Utilities.displayErrorSnackBar(context, 'Password cannot be empty');
        return;
      }
      final result =
          await loginViewModel.signInWithEmailAndPassword(email, password);
      if (result != null && result as bool == true)
        context.router.push(StartUpRoute());
    } catch (e) {
      Utilities.showErrorDialog(
        context: context,
        title: Strings.signInFailed,
        exception: e,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final ethnicityController = useTextEditingController();
    final ageController = useTextEditingController();

    final emailNode = useFocusNode();
    final passwordNode = useFocusNode();
    final password2Node = useFocusNode();
    final firstNameNode = useFocusNode();
    final lastNameNode = useFocusNode();
    final ethnicityNode = useFocusNode();
    final ageNode = useFocusNode();

    final loginViewModel = useProvider(loginModelProvider);

    final techLevels = ['Novice', 'Beginner', 'Intermediate', 'Expert'];
    String techLevel = techLevels[0];

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior(),
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                      isSigningUp ? 'Setup your account' : 'Login',
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
                  fieldFocusNode: emailNode,
                  nextFocusNode: passwordNode,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                InputField(
                  controller: passwordController,
                  placeholder: 'Password',
                  password: true,
                  fieldFocusNode: passwordNode,
                  textInputAction: TextInputAction.done,
                  enterPressed: () {},
                ),
                if (isSigningUp) ...[
                  SizedBox(height: 20),
                  InputField(
                    controller: confirmPasswordController,
                    placeholder: 'Confirm Password',
                    password: true,
                    fieldFocusNode: password2Node,
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
                    fieldFocusNode: firstNameNode,
                    nextFocusNode: lastNameNode,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 20),
                  InputField(
                    controller: lastNameController,
                    placeholder: 'Last Name',
                    fieldFocusNode: lastNameNode,
                    nextFocusNode: ageNode,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 20),
                  InputField(
                    controller: ageController,
                    placeholder: 'Age',
                    fieldFocusNode: ageNode,
                    nextFocusNode: ethnicityNode,
                    textInputType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  InputDropdown(
                    labelText: 'Tech level',
                    items: techLevels,
                    onItemTapped: (value) {
                      print('value: $value');
                      techLevel = value;
                    },
                  ),
                  SizedBox(height: 20),
                  InputField(
                    controller: ethnicityController,
                    placeholder: 'Ethnicity',
                    fieldFocusNode: ethnicityNode,
                    textInputType: TextInputType.name,
                  ),
                ],
                SizedBox(height: 40),
                CustomElevatedButton(
                    child: Text(
                      isSigningUp ? 'NEXT' : 'SUBMIT',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                    ),
                    onPressed: () {
                      isSigningUp
                          ? signUp(
                              loginViewModel: loginViewModel,
                              context: context,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              confirmPassword:
                                  confirmPasswordController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              techLevel: techLevel!,
                              age: int.parse(ageController.text.trim()),
                              ethnicity: ethnicityController.text.trim(),
                            )
                          : login(
                              context: context,
                              loginViewModel: loginViewModel,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                    }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
