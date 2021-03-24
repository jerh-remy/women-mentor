import 'package:flutter/cupertino.dart';

class CupertinoTabViewRoutes {
  static const jobEntriesPage = '/job-entries-page';
}

class CupertinoTabViewRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.jobEntriesPage:
      // final job = settings.arguments as Job;
      // return CupertinoPageRoute(
      //   builder: (_) => JobEntriesPage(job: job),
      //   settings: settings,
      //   fullscreenDialog: false,
      // );
    }
    return null;
  }
}
