import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_mentor/app/login/setup_acc_view.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/routing/app_router.gr.dart';
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
                Strings.logo,
                height: 100,
                color: CustomColors.appColorTeal,
                semanticsLabel: 'Women Mentor Logo',
              ),
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Text(
                    'Women',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 28,
                        color: CustomColors.appColorTeal,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Mentor',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 28,
                        color: CustomColors.appColorTeal,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Text(
                'Join our community',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              CustomElevatedButton(
                child: Text(
                  'SIGN UP',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                ),
                onPressed: () {
                  AutoRouter.of(context)
                      .push(SetupAccountRoute(setupType: SetupType.signUp));
                },
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
                onPressed: () {
                  context.router.push(SignInOptionsRoute());
                },
              )
            ],
          )),
    );
  }
}
