import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/keys.dart';
import 'package:women_mentor/models/tab_item.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';

class CupertinoScaffold extends StatelessWidget {
  const CupertinoScaffold({
    Key? key,
    required this.currentTab,
    required this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        key: const Key(Keys.tabBar),
        items: [
          _buildTabItem(TabItem.home),
          _buildTabItem(TabItem.explore),
          _buildTabItem(TabItem.schedule),
          _buildTabItem(TabItem.profile),
        ],
        backgroundColor: CustomColors.appColorTeal,
        activeColor: Colors.white,
        inactiveColor: Colors.white70,
        onTap: (index) => onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) {
            return widgetBuilders[item]!(context);
          },
          onGenerateRoute: CupertinoTabViewRouter.generateRoute,
        );
      },
    );
  }

  BottomNavigationBarItem _buildTabItem(TabItem tabItem) {
    final itemData = TabItemData.tabs[tabItem]!;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        size:
            tabItem == TabItem.profile || tabItem == TabItem.schedule ? 22 : 26,
      ),
      label: itemData.title,
    );
  }
}
