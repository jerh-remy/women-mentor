// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../app/login/login_view.dart' as _i3;
import '../app/login/setup_acc_view.dart' as _i5;
import '../app/login/sign_in_options_view.dart' as _i4;
import '../app/onboarding/onboarding_view.dart' as _i6;
import '../app/startup/startup_view.dart' as _i2;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    StartUpRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i2.StartUpView());
    },
    LoginRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.LoginView());
    },
    SignInOptionsRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i4.SignInOptionsView());
    },
    SetupAccountRoute.name: (entry) {
      var args = entry.routeData.argsAs<SetupAccountRouteArgs>();
      return _i1.MaterialPageX(
          entry: entry, child: _i5.SetupAccountView(args.setupType));
    },
    OnboardingRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i6.OnboardingView());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(StartUpRoute.name, path: '/'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-view'),
        _i1.RouteConfig(SignInOptionsRoute.name, path: '/sign-in-options-view'),
        _i1.RouteConfig(SetupAccountRoute.name, path: '/setup-account-view'),
        _i1.RouteConfig(OnboardingRoute.name, path: '/onboarding-view')
      ];
}

class StartUpRoute extends _i1.PageRouteInfo {
  const StartUpRoute() : super(name, path: '/');

  static const String name = 'StartUpRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login-view');

  static const String name = 'LoginRoute';
}

class SignInOptionsRoute extends _i1.PageRouteInfo {
  const SignInOptionsRoute() : super(name, path: '/sign-in-options-view');

  static const String name = 'SignInOptionsRoute';
}

class SetupAccountRoute extends _i1.PageRouteInfo<SetupAccountRouteArgs> {
  SetupAccountRoute({required _i5.SetupType setupType})
      : super(name,
            path: '/setup-account-view',
            args: SetupAccountRouteArgs(setupType: setupType));

  static const String name = 'SetupAccountRoute';
}

class SetupAccountRouteArgs {
  const SetupAccountRouteArgs({required this.setupType});

  final _i5.SetupType setupType;
}

class OnboardingRoute extends _i1.PageRouteInfo {
  const OnboardingRoute() : super(name, path: '/onboarding-view');

  static const String name = 'OnboardingRoute';
}
