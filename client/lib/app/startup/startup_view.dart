import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/app/auth_widget.dart';
import 'package:women_mentor/app/landing/landing_view.dart';
import 'package:women_mentor/app/login/login_view.dart';

class StartUpView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AuthWidget(
      nonSignedInBuilder: (_) => Consumer(
        builder: (context, watch, _) {
          // final didCompleteOnboarding =
          //     watch(onboardingViewModelProvider.state);
          // return didCompleteOnboarding ? LoginView() : OnboardingView();
          return LoginView();
        },
      ),
      signedInBuilder: (_) {
        return LandingView();
      },
    );
  }
}
