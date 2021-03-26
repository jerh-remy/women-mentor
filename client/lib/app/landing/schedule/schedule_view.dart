import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:women_mentor/app/landing/schedule/session_calendar.dart';
import 'package:women_mentor/constants/colors.dart';

class ScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Your schedule',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20,
                            color: CustomColors.appColorOrange,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
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
                      height: MediaQuery.of(context).size.height * 0.38,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Schedule',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Ionicons.chevron_down,
                                    ))
                              ],
                            ),
                          ),
                          Flexible(
                              child: ListView.separated(
                            padding: EdgeInsets.all(16),
                            controller: ModalScrollController.of(context),
                            shrinkWrap: true,
                            itemCount: 6,
                            itemBuilder: (ctx, index) {
                              return index % 3 == 0
                                  ? SessionListItem(
                                      date: '13 Mar',
                                      meetingTitle: 'Meet mentor name',
                                      meetingTime: '12:00 - 13:00',
                                      meetingDesc:
                                          'Eiusmod ex ex eu exercitation aliquip eiusmod fugiat nostrud nisi.')
                                  : SessionListItem(
                                      date: '24 Mar',
                                      meetingTitle: 'Mentoring name',
                                      meetingTime: '14:00 - 15:00',
                                      titleColor: CustomColors.appColorOrange,
                                      meetingDesc:
                                          'Eiusmod ex ex eu exercitation aliquip eiusmod fugiat nostrud nisi.');
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          ))
                        ],
                      ),
                    ),
                  );
                },
                events: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SessionListItem extends StatelessWidget {
  final String date;
  final String meetingTitle;
  final Color titleColor;
  final String meetingTime;
  final String meetingDesc;

  const SessionListItem({
    Key? key,
    required this.date,
    required this.meetingTitle,
    required this.meetingTime,
    required this.meetingDesc,
    this.titleColor = CustomColors.appColorTeal,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      meetingTitle,
                      style: TextStyle(
                        fontSize: 15,
                        color: titleColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  meetingTime,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              meetingDesc,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
