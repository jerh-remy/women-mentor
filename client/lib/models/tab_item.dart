import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_mentor/constants/keys.dart';
import 'package:women_mentor/constants/strings.dart';

enum TabItem { home, explore, schedule, profile }

class TabItemData {
  const TabItemData(
      {required this.key, required this.title, required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> tabs = {
    TabItem.home: TabItemData(
      key: Keys.homeTab,
      title: Strings.homePage,
      icon: Icons.home,
    ),
    TabItem.explore: TabItemData(
      key: Keys.exploreTab,
      title: Strings.explore,
      icon: Icons.explore,
    ),
    TabItem.schedule: TabItemData(
      key: Keys.scheduleTab,
      title: Strings.schedule,
      icon: FontAwesomeIcons.calendarAlt,
    ),
    TabItem.profile: TabItemData(
      key: Keys.profileTab,
      title: Strings.profile,
      icon: FontAwesomeIcons.userAlt,
    ),
  };
}
