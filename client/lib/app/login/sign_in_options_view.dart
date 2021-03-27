import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/login/login_view_model.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/app_router.gr.dart';
import 'package:women_mentor/widgets/shared/horizontal_logo.dart';
import 'package:women_mentor/widgets/shared/social_sign_in_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginModelProvider = ChangeNotifierProvider<LoginViewModel>(
    (ref) => LoginViewModel(auth: ref.watch(firebaseAuthProvider)));

class SignInOptionsView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final loginViewModel = watch(loginModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HorizontalLogo(),
          const SizedBox(height: 50),
          Text(
            'Log in or create account',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 20,
                  color: CustomColors.appColorOrange,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 50),
          SocialSignInButton(
            onPressed: () {
              _signInWithGoogle(loginViewModel, context);
            },
            icon: FontAwesomeIcons.google,
            text: 'SIGN IN WITH GOOGLE',
            color: Color(0xffF7F7F7),
            iconColor: Colors.black54,
          ),
          const SizedBox(height: 20),
          // SocialSignInButton(
          //   onPressed: () {},
          //   icon: FontAwesomeIcons.apple,
          //   text: 'SIGN IN WITH APPLE',
          //   textColor: Colors.white,
          //   color: Color(0xff313131),
          // ),
          // SizedBox(height: 20),
          SocialSignInButton(
            onPressed: () {
              _signInWithFacebook(loginViewModel, context);
            },
            icon: FontAwesomeIcons.facebookSquare,
            text: 'SIGN IN WITH FACEBOOK',
            color: Color(0xff405796),
            textColor: Colors.white,
          ),
          const SizedBox(height: 20),
          SocialSignInButton(
            text: 'SIGN IN WITH EMAIL',
            textColor: Colors.white,
            color: CustomColors.appColorTeal,
            icon: Icons.email,
            onPressed: () {
              context.router.push(SetupAccountRoute(isSigningUp: false));
            },
          ),
          if (loginViewModel.isLoading) ...[
            const SizedBox(height: 30),
            SpinKitCircle(
              color: CustomColors.appColorTeal,
            ),
          ],
        ],
      ),
    );
  }

  void _signInWithGoogle(
      LoginViewModel loginViewModel, BuildContext context) async {
    try {
      await loginViewModel
          .signInWithGoogle()
          .then((value) => Navigator.of(context).pop());
    } catch (e) {
      Utilities.showErrorDialog(
        context: context,
        title: Strings.signInFailed,
        exception: e,
      );
    }
  }

  void _signInWithFacebook(
      LoginViewModel loginViewModel, BuildContext context) async {
    try {
      await loginViewModel
          .signInWithFacebook()
          .then((value) => Navigator.of(context).pop());
    } catch (e) {
      Utilities.showErrorDialog(
        context: context,
        title: Strings.signInFailed,
        exception: e,
      );
    }
  }
}
