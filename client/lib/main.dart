import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:women_mentor/app/custom_theme.dart';
import 'package:women_mentor/routing/app_router.gr.dart';
import 'package:women_mentor/services/shared_preferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      sharedPreferencesServiceProvider.overrideWithValue(
        SharedPreferencesService(sharedPreferences),
      ),
    ],
    child: App(),
  ));
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

    // return MaterialApp(
    //   title: 'Women Mentor',
    //   debugShowCheckedModeBanner: false,
    //   theme: CustomTheme.lightTheme(context),
    //   home: GetToken(),
    //   onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    // );
  }
}
