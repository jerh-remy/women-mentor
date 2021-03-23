import 'package:auto_route/auto_route.dart';
import 'package:women_mentor/app/login/login_view.dart';
import 'package:women_mentor/app/login/signup_view.dart';
import 'package:women_mentor/app/onboarding/onboarding_view.dart';
import 'package:women_mentor/app/profile/profile_view.dart';
import 'package:women_mentor/app/schedule/schedule_view.dart';
import 'package:women_mentor/app/startup/startup_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: StartUpView, initial: true),
    AutoRoute(page: LoginView),
    AutoRoute(page: SignUpView),
    AutoRoute(page: OnboardingView),
    AutoRoute(page: ProfileView),
    AutoRoute(page: ScheduleView),
  ],
)
class $AppRouter {}
