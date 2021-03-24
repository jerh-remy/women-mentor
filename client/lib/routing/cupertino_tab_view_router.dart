import 'package:flutter/cupertino.dart';
import 'package:women_mentor/app/landing/explore/mentor_profile_view.dart';

class CupertinoTabViewRoutes {
  static const mentorProfilePage = '/mentor-profile-page';
}

class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.mentorProfilePage:
        // final job = settings.arguments as Job;
        return CupertinoPageRoute(
          builder: (_) => MentorProfileView(),
          settings: settings,
          fullscreenDialog: false,
        );
    }
    return null;
  }
}
