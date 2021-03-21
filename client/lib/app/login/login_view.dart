import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          color: CustomColors.appColorOrange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Strings.logoWithText,
                height: 200,
                semanticsLabel: 'Women Mentor Logo',
              ),
              SizedBox(height: 60),
              Text(
                'Join our community',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              SizedBox(
                child: CustomElevatedButton(
                  child: Text(
                    'SIGN UP',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 10),
              CustomTextButton(
                child: Text(
                  'LOG IN',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: CustomColors.appColorTeal,
                        fontSize: 15.0,
                      ),
                ),
                onPressed: () {},
              )
            ],
          )),
    );
  }
}
