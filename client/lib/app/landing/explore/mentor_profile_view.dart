import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/app/landing/explore/bookSession/book_session_view_model.dart';
import 'package:women_mentor/app/landing/explore/bookSession/mentor_profile_view_model.dart';
import 'package:women_mentor/app/landing/explore/bookSession/select_date_view.dart';
import 'package:women_mentor/app/landing/profile/profile_view.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/routing/cupertino_tab_view_router.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:women_mentor/extensions/capitalize_first_letter.dart';

final mentorProfileStreamProvider =
    StreamProvider.autoDispose.family<MentorAppUser, String>(
  (ref, mentorId) {
    final database = ref.watch(databaseProvider);
    final vm = MentorProfileViewModel(database: database);
    return vm.mentorProfileStream(mentorId);
  },
);

class MentorProfileView extends ConsumerWidget {
  final String mentorId;

  const MentorProfileView({
    Key? key,
    required this.mentorId,
  }) : super(key: key);

  static Future<void> show(BuildContext context, String mentorId) async {
    await Navigator.of(context).pushNamed(
      CupertinoTabViewRoutes.mentorProfilePage,
      arguments: mentorId,
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mentorProfileAsyncValue =
        watch(mentorProfileStreamProvider(mentorId));
    return mentorProfileAsyncValue.when(
        data: (mentor) {
          return buildProfile(context, mentor, watch);
        },
        loading: () => Container(),
        error: (e, st) {
          print(e);
          print(st);
          return Container();
        });
  }

  Widget buildProfile(
      BuildContext context, MentorAppUser mentor, ScopedReader watch) {
    final vm = watch(mentorViewModelProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
              PageTitle(text: 'Mentor Profile'),
              SizedBox(height: 30),
              Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: CustomColors.appColorTeal.withOpacity(0.2),
                    child: Icon(
                      Ionicons.person_outline,
                      color: CustomColors.appColorTeal,
                      size: 36,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          '${mentor.firstName} ${mentor.lastName}'
                              .split(" ")
                              .map((e) => e.capitalizeFirstLetter())
                              .join(" "),
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                      Text(
                        mentor.jobTitle?.capitalizeFirstLetter() ?? 'Developer',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      vm.isFollowClicked
                          ? TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: CustomColors.appColorOrange,
                                primary: Colors.white,
                                padding:
                                    EdgeInsets.only(right: 16.0, left: 10.0),
                                textStyle: TextStyle(
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold,
                                ),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              onPressed: () {
                                vm.setFollowClicked();
                              },
                              icon: Icon(Icons.add),
                              label: Text('FOLLOWING'))
                          : TextButton.icon(
                              style: TextButton.styleFrom(
                                backgroundColor: CustomColors.appColorTeal,
                                primary: Colors.white,
                                padding:
                                    EdgeInsets.only(right: 16.0, left: 10.0),
                                textStyle: TextStyle(
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold,
                                ),
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                              onPressed: () {
                                print('isfollow ${vm.isFollowClicked}');
                                vm.setFollowClicked();
                              },
                              icon: Icon(Icons.add),
                              label: vm.isFollowClicked
                                  ? Text('FOLLOWING')
                                  : Text('FOLLOW'),
                            )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 36),
              if (mentor.techInterests!.isNotEmpty) ...[
                ...buildExpertise(context, mentor.techInterests!),
                SizedBox(height: 16),
              ],
              if (mentor.hobbies!.isNotEmpty) ...[
                ...buildHobbies(context, mentor.hobbies!)
              ],
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
                  onPressed: () {
                    final bookingViewModel =
                        watch(bookSessionViewModelProvider);
                    bookingViewModel.setMentorID(mentorId);
                    SelectDateView.show(context);
                  },
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
              SocialMediaButtons(),
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
              RecentActivitiesList()
            ],
          ),
        ),
      ),
    );
  }
}

class RecentActivitiesList extends StatelessWidget {
  const RecentActivitiesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
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
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
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
        });
  }
}

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
            child: Icon(Ionicons.logo_instagram, color: Colors.black54)),
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
    );
  }
}
