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
                      'printing selected date from schedule view via callback');
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
                                  style: TextStyle(fontSize: 18),
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
                                  ? ListTile(
                                      onTap: () {},
                                      leading: Text('13 Mar'),
                                      title: Text('Meet mentor name'),
                                    )
                                  : ListTile(
                                      onTap: () {},
                                      leading: Text('24 Mar'),
                                      title: Text('Mentoring name'),
                                    );
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
