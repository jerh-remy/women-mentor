import 'package:flutter/material.dart';
import 'package:women_mentor/app/auth_widget.dart';
import 'package:women_mentor/app/landing/landing_view.dart';
import 'package:women_mentor/app/onboarding/onboarding_view.dart';
import 'package:women_mentor/app/onboarding/onboarding_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LandingView();

    // return AuthWidget(
    //   nonSignedInBuilder: (_) => Consumer(
    //     builder: (context, watch, _) {
    //       final didCompleteOnboarding =
    //           watch(onboardingViewModelProvider.state);
    //       return didCompleteOnboarding ? LoginView() : OnboardingView();
    //     },
    //   ),
    //   signedInBuilder: (_) => HomeView(),
    // );
  }
}
