import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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

// class AppRoutes {
//   static const startupPage = '/startup-page';
//   static const loginPage = '/login-page';
//   static const signInOptionsPage = '/sign-in-options-page';
//   static const setUpAccountPage = '/setup-account-page';
//   static const onboardingPage = '/onboarding-page';
// }

// class AppRouter {
//   static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//     switch (settings.name) {
//       // case AppRoutes.emailPasswordSignInPage:
//       //   return MaterialPageRoute<dynamic>(
//       //     builder: (_) => EmailPasswordSignInPage.withFirebaseAuth(firebaseAuth,
//       //         onSignedIn: args as void Function()),
//       //     settings: settings,
//       //     fullscreenDialog: true,
//       //   );
//       case AppRoutes.startupPage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => StartUpView(),
//           settings: settings,
//         );
//       case AppRoutes.loginPage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => LoginView(),
//           settings: settings,
//         );
//       case AppRoutes.signInOptionsPage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => SignInOptionsView(),
//           settings: settings,
//         );
//       default:
//         // TODO: Throw
//         return null;
//     }
//   }
// }
