import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:women_mentor/app/landing/explore/bookSession/back_button.dart';
import 'package:women_mentor/app/landing/explore/bookSession/book_session_view_model.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_call_provider_view.dart';
import 'package:women_mentor/app/landing/schedule/session_calendar.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectDateView extends ConsumerWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.selectBookingDatePage,
      // arguments: job,
    );
  }

  final List<String> availableTimes = [
    '9:00 - 9:30',
    '10:00 - 11:30',
    '12:00 - 13:00',
    '14:00 - 14:30',
    '15:00 - 16:30',
  ];

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final bookingViewModel =
        watch<BookSessionViewModel>(bookSessionViewModelProvider);

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
                            final availableTime = availableTimes[index];
                            return Container(
                              color: index == 1
                                  ? CustomColors.appColorTeal.withOpacity(0.3)
                                  : Colors.transparent,
                              child: ListTile(
                                onTap: () {},
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  availableTime,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
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
                                child: Text('NEXT'),
                                onPressed: () {
                                  bookingViewModel.setMeetingDate(selectedDate);
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
    );
  }
}
