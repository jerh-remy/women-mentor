import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';

class HomeView extends StatelessWidget {
  final _tabViews = [
    Text('Home Page'),
    Text('Explore Page'),
    Text('Schedule Page'),
    Text('Profile Page'),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        controller: CupertinoTabController(),
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Feed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
          backgroundColor: CustomColors.appColorTeal,
          activeColor: Colors.white,
          inactiveColor: Colors.white60,
          iconSize: 24,
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(builder: (BuildContext context) {
            return CupertinoPageScaffold(child: _tabViews.elementAt(index));
          });
        });

    /** vv Documentation Sample Code vv */
    //   tabBuilder: (BuildContext context, int index) {
    //     return CupertinoTabView(
    //       builder: (BuildContext context) {
    //         return CupertinoPageScaffold(
    //           navigationBar: CupertinoNavigationBar(
    //             middle: Text('Page 1 of tab $index'),
    //           ),
    //           child: Center(
    //             child: CupertinoButton(
    //               child: const Text('Next page'),
    //               onPressed: () {
    //                 Navigator.of(context).push(
    //                   CupertinoPageRoute<void>(
    //                     builder: (BuildContext context) {
    //                       return CupertinoPageScaffold(
    //                         navigationBar: CupertinoNavigationBar(
    //                           middle: Text('Page 2 of tab $index'),
    //                         ),
    //                         child: Center(
    //                           child: CupertinoButton(
    //                             child: const Text('Back'),
    //                             onPressed: () {
    //                               Navigator.of(context).pop();
    //                             },
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
