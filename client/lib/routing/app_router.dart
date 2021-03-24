import 'package:auto_route/auto_route.dart';
import 'package:women_mentor/app/login/login_view.dart';
import 'package:women_mentor/app/login/setup_acc_view.dart';
import 'package:women_mentor/app/login/sign_in_options_view.dart';
import 'package:women_mentor/app/onboarding/onboarding_view.dart';

import 'package:women_mentor/app/startup/startup_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: StartUpView, initial: true),
    AutoRoute(page: LoginView),
    AutoRoute(page: SignInOptionsView),
    AutoRoute(page: SetupAccountView),
    AutoRoute(page: OnboardingView),
  ],
)
class $AppRouter {}
