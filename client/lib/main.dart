import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:women_mentor/app/custom_theme.dart';
import 'package:women_mentor/app/login/login_view.dart';
import 'package:women_mentor/app/login/setup_acc_view.dart';
import 'package:women_mentor/app/onboarding/onboarding_view.dart';
import 'package:women_mentor/app/onboarding/select_role_view.dart';
import 'package:women_mentor/routing/app_router.gr.dart';

import 'app/login/signup_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

final _appRouter = AppRouter();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      title: 'Women Mentor',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme(context),
    );
  }
}
