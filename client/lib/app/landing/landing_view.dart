import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_mentor/app/landing/cupertino_scaffold.dart';
import 'package:women_mentor/app/landing/explore/explore_view.dart';
import 'package:women_mentor/app/landing/home/home_view.dart';
import 'package:women_mentor/app/landing/profile/profile_view.dart';
import 'package:women_mentor/app/landing/schedule/schedule_view.dart';
import 'package:women_mentor/models/tab_item.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  TabItem _currentTab = TabItem.home;

  // need this to be able to perform parallel nested navigation within the
  // different tabs
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.explore: GlobalKey<NavigatorState>(),
    TabItem.schedule: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get tabViewBuilders {
    return {
      TabItem.home: (_) => HomeView(),
      TabItem.explore: (_) => ExploreView(),
      TabItem.schedule: (_) => ScheduleView(),
      TabItem.profile: (_) => ProfileView(),
    };
  }

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem]!.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !(await navigatorKeys[_currentTab]!.currentState?.maybePop() ??
              false),
      child: CupertinoScaffold(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
        widgetBuilders: tabViewBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
