import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:women_mentor/app/landing/cupertino_scaffold.dart';
import 'package:women_mentor/app/landing/explore/explore_view.dart';
import 'package:women_mentor/app/landing/home/home_view.dart';
import 'package:women_mentor/app/landing/profile/profile_view.dart';
import 'package:women_mentor/app/landing/schedule/schedule_view.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/strings.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/models/notification.dart';
import 'package:women_mentor/models/tab_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/services/firestore_database.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/custom_text_button.dart';
import 'package:women_mentor/extensions/capitalize_first_letter.dart';

class LandingView extends StatefulWidget {
  final AppNotification? notificationToDisplay;

  const LandingView({Key? key, this.notificationToDisplay}) : super(key: key);
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  void initState() {
    print('INIT STATE CALLED');
    super.initState();
    FirebaseMessaging.instance.getToken().then((token) => {
          if (token != null) {saveMessagingTokenToFirestore(token)}
        });
    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh
        .listen(saveMessagingTokenToFirestore);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => print('[getInitialMessage] $value'));
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print('[onMessageOpenedApp] $event');
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (widget.notificationToDisplay != null) {
        final meetingDetails = widget.notificationToDisplay;
        await showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            CustomColors.appColorTeal.withOpacity(0.2),
                        child: SvgPicture.asset(
                          Strings.logo,
                          height: 24,
                          color: CustomColors.appColorTeal,
                          semanticsLabel: 'Women Mentor Logo',
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Text(
                              'You have a new meeting request from',
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              '${meetingDetails?.requesterUserProfile.firstName} ${meetingDetails?.requesterUserProfile.lastName}'
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 18,
                                color: CustomColors.appColorTeal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 40),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Proposed meeting purpose: ',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '${meetingDetails?.bookingData.purpose.join(', ')}',
                            style: TextStyle(
                                color: CustomColors.appColorTeal,
                                fontSize: 16,
                                letterSpacing: 0.3),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Date:',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '${Utilities.dateFormat(meetingDetails!.bookingData.date)} via ${meetingDetails.bookingData.preferredCallProvider.capitalizeFirstLetter()}',
                            style: TextStyle(
                                color: CustomColors.appColorTeal,
                                fontSize: 16,
                                letterSpacing: 0.3),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      Divider(height: 40),
                      Column(
                        children: [
                          CustomElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: CustomColors.appColorTeal,
                              child: Text(
                                'YES, CONFIRM',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                ),
                              )),
                          SizedBox(height: 4),
                          CustomTextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.white,
                              child: Text(
                                'NO, DECLINE',
                                style: TextStyle(
                                  color: CustomColors.appColorTeal,
                                  fontSize: 14.0,
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      }
    });
  }

  Future<void> saveMessagingTokenToFirestore(String token) async {
    final database = context.read<FirestoreDatabase>(databaseProvider);
    await database.setRegistration(token);
  }

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
    print('BUILD CALLED');

    print('###### FCM Booking data #######: ${widget.notificationToDisplay}');

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
