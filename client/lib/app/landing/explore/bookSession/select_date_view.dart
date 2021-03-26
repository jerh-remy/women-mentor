import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_call_provider_view.dart';
import 'package:women_mentor/app/landing/schedule/session_calendar.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';

class SelectDateView extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.selectBookingDatePage,
      // arguments: job,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: PageTitle(text: 'Select Meet Date'),
          ),
          SessionCalendar(
            onDaySelected: (selectedDate) {
              print(
                  'printing selected date from schedule view via callback: $selectedDate');
              showMaterialModalBottomSheet(
                context: context,
                elevation: 2.0,
                barrierColor: Colors.grey.withOpacity(0.1),
                builder: (context) => Container(
                  color: Colors.white,
                  // height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Select the time',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.4,
                              ),
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              Utilities.dateFormat(selectedDate),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: ListView.separated(
                          padding: EdgeInsets.all(16),
                          controller: ModalScrollController.of(context),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (ctx, index) {
                            return ListTile(
                              onTap: () {},
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                '11:00 - 11:30',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 2.0);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomElevatedButton(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Text('NEXT'),
                                onPressed: () {
                                  SelectCallProviderView.show(context);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            events: [],
          )
        ],
      ),

      // Container(
      //   child: Center(
      //     child: TextButton.icon(
      //         style: TextButton.styleFrom(
      //           backgroundColor: CustomColors.appColorTeal,
      //           primary: Colors.white,
      //           elevation: 2.0,
      //           textStyle: TextStyle(
      //             letterSpacing: 0.6,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //         onPressed: () {
      //           SelectCallProviderView.show(context);
      //         },
      //         icon: Icon(
      //           Icons.calendar_today_outlined,
      //           size: 20,
      //         ),
      //         label: Text('BOOK A SESSION')),
      //   ),
      // ),
    );
  }
}
