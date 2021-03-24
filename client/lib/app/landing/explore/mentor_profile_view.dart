import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/app/landing/profile/profile_view.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';

class MentorProfileView extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.mentorProfilePage,
      // arguments: job,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Text(
                    'Mentor Profile',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 20,
                          color: CustomColors.appColorOrange,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey.shade100,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          'Samantha Tung',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                      Text(
                        'VP Figma Design',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: CustomColors.appColorTeal,
                          primary: Colors.white,
                          padding: EdgeInsets.only(right: 16.0, left: 10.0),
                          textStyle: TextStyle(
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.bold,
                          ),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text('FOLLOW'),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 36),
              ...buildExpertise(context),
              SizedBox(height: 16),
              ...buildHobbies(context),
              SizedBox(height: 36),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  primary: CustomColors.appColorTeal,
                  textStyle: TextStyle(
                    letterSpacing: 0.6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.message,
                  size: 20,
                ),
                label: Text('QUICK MESSAGE'),
              ),
              SizedBox(height: 5),
              TextButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: CustomColors.appColorTeal,
                    primary: Colors.white,
                    elevation: 2.0,
                    textStyle: TextStyle(
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                  ),
                  label: Text('BOOK A SESSION')),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  children: [
                    Text(
                      'Connect with her',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            color: CustomColors.appColorOrange,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Icon(Ionicons.globe, color: Colors.black54)),
                  InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Icon(Ionicons.logo_github, color: Colors.black54)),
                  InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child:
                          Icon(Ionicons.logo_instagram, color: Colors.black54)),
                  InkWell(
                      highlightColor: Colors.transparent,
                      onTap: () {},
                      child: Icon(Ionicons.logo_medium, color: Colors.black54)),
                  Opacity(
                      opacity: 0,
                      child: Icon(Ionicons.logo_medium, color: Colors.black54)),
                  Opacity(
                      opacity: 0,
                      child: Icon(Ionicons.logo_medium, color: Colors.black54)),
                  Opacity(
                      opacity: 0,
                      child: Icon(Ionicons.logo_medium, color: Colors.black54)),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  children: [
                    Text(
                      'Activities',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                            color: CustomColors.appColorOrange,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        Theme(
                          data: ThemeData(
                            highlightColor: Colors.transparent,
                          ),
                          child: ListTile(
                            onTap: () {},
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    'This is a title',
                                  ),
                                ),
                                Text(
                                  '${Utilities.dateFormat(DateTime.now())}',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black45,
                                  ),
                                )
                              ],
                            ),
                            isThreeLine: true,
                            contentPadding: EdgeInsets.all(0.0),
                            subtitle: Text(
                              'Ut laborum quis dolore dolor. Minim enim consectetur labore aliquip magna. Id fugiat consectetur ea voluptate voluptate eiusmod labore nulla.',
                              style: TextStyle(fontSize: 14, height: 1.3),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        if (index != 4) ...[Divider()],
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
