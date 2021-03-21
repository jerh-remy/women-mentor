import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/horizontal_logo.dart';
import 'package:women_mentor/widgets/shared/social_sign_in_button.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HorizontalLogo(),
            SizedBox(height: 50),
            Text(
              'Log in or create account',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 20,
                    color: CustomColors.appColorOrange,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 50),
            SocialSignInButton(
              onPressed: () {},
              icon: FontAwesomeIcons.apple,
              text: 'SIGN IN WITH APPLE',
              textColor: Colors.white,
              color: Color(0xff313131),
            ),
            SizedBox(height: 20),
            SocialSignInButton(
              onPressed: () {},
              icon: FontAwesomeIcons.google,
              text: 'SIGN IN WITH GOOGLE',
              color: Color(0xffF7F7F7),
              iconColor: Colors.black54,
            ),
            SizedBox(height: 20),
            SocialSignInButton(
              onPressed: () {},
              icon: FontAwesomeIcons.facebookSquare,
              text: 'SIGN IN WITH FACEBOOK',
              color: Color(0xff405796),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
            SocialSignInButton(
              text: 'SIGN IN WITH EMAIL',
              textColor: Colors.white,
              color: CustomColors.appColorTeal,
              icon: Icons.email,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
