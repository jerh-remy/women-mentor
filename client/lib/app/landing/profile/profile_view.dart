import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/app/landing/explore/bookSession/mentor_profile_view_model.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/services/shared_preferences_service.dart';
import 'package:women_mentor/widgets/logout_dialog.dart';

final mentorProfileStreamProvider =
    StreamProvider.autoDispose.family<MentorAppUser, String>(
  (ref, mentorId) {
    final database = ref.watch(databaseProvider);
    final vm = MentorProfileViewModel(database: database);
    return vm.mentorProfileStream(mentorId);
  },
);

class ProfileView extends StatelessWidget {
  final String role;

  const ProfileView({Key? key, this.role = 'mentee'}) : super(key: key);

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuth firebaseAuth) async {
    showDialog(
        context: context,
        builder: (context) {
          return LogoutDialog(
              onLogoutTapped: () => _signOut(firebaseAuth, context));
        });
  }

  void _signOut(FirebaseAuth firebaseAuth, BuildContext context) async {
    //TODO remove force onboarding == false after testing
    //These next few lines are just for testing. Will remove later
    // final SharedPreferencesService sharedPreferencesService = context
    //     .read<SharedPreferencesService>(sharedPreferencesServiceProvider);
    // await sharedPreferencesService.setOnboardingInComplete();
    await firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = context.read(firebaseAuthProvider);
    final user = firebaseAuth.currentUser!;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Profile',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20,
                            color: CustomColors.appColorOrange,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Theme(
                      data: ThemeData(highlightColor: Colors.transparent),
                      child: IconButton(
                          onPressed: () {
                            _confirmSignOut(context, firebaseAuth);
                          },
                          icon: Icon(
                            Ionicons.power,
                            color: CustomColors.appColorTeal,
                          )),
                    ),
                  ),
                ],
              ),
              ProfileCard(
                user: user,
              ),
              SizedBox(height: 10),
              DetailSection(user: user),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailSection extends ConsumerWidget {
  final User user;

  DetailSection({required this.user});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mentorProfileAsyncValue =
        watch(mentorProfileStreamProvider(user.uid));
    return mentorProfileAsyncValue.when(
        data: (mentor) {
          if (!mentor.isMentor) {
            return Flexible(
                child: MenteeGoalsAndInterestsSection(
              hobbies: mentor.hobbies!,
              techInterests: mentor.techInterests!,
            ));
          } else {
            return Flexible(
                child: MentorGoalsAndInterestsSection(
              hobbies: mentor.hobbies!,
              techInterests: mentor.techInterests!,
              timeCommitment: mentor.timeAvailability!,
              menteeSkillLevel: mentor.preferredMenteeSkillLevels!,
            ));
          }
        },
        loading: () => Container(),
        error: (e, st) {
          print(e);
          print(st);
          return Container();
        });
  }
}

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePic(
                photoURL: user.photoURL,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: user.displayName == null
                        ? Text(
                            user.email!,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                    ),
                          )
                        : Text(
                            user.displayName!,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 16,
                                    ),
                          ),
                  ),
                  Text(
                    'Software Engineer - Microsoft UK',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    child: Text(
                      'EDIT ACCOUNT DETAILS',
                      style: TextStyle(
                        letterSpacing: 0.6,
                        color: CustomColors.appColorTeal,
                      ),
                    ),
                    splashColor: CustomColors.appColorTeal.withOpacity(0.2),
                    onTap: () {},
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  final String? photoURL;

  const ProfilePic({Key? key, this.photoURL}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      child: CachedNetworkImage(
        imageUrl: photoURL ?? '',
        placeholder: (context, url) => SpinKitCircle(
          size: 45.0,
          color: CustomColors.appColorTeal,
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              border: Border.all(
                style: BorderStyle.solid,
                width: 1.5,
                color: CustomColors.appColorTeal,
              ),
              shape: BoxShape.circle),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
          ),
        ),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
              width: 1.5,
              color: CustomColors.appColorTeal,
            ),
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MentorGoalsAndInterestsSection extends StatelessWidget {
  final List<String> hobbies;
  final List<String> techInterests;
  final List<String> menteeSkillLevel;
  final String timeCommitment;

  const MentorGoalsAndInterestsSection(
      {Key? key,
      required this.hobbies,
      required this.techInterests,
      required this.menteeSkillLevel,
      required this.timeCommitment})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0.5,
                flexibleSpace: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabBar(
                      indicatorColor: Colors.teal,
                      indicatorWeight: 3.5,
                      // unselectedLabelColor: ,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                      labelColor: CustomColors.appColorTeal,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "MENTEE",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "MENTOR",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                MenteeGoalsAndInterestsSection(
                  hobbies: hobbies,
                  techInterests: techInterests,
                ),
                MentorSpecificSection(
                  timeAvailability: timeCommitment,
                  menteeSkillLevel: menteeSkillLevel,
                ),
              ]),
            );
          },
        ));
  }
}

class MentorSpecificSection extends StatelessWidget {
  final String timeAvailability;
  final List<String> menteeSkillLevel;

  const MentorSpecificSection(
      {Key? key,
      required this.timeAvailability,
      required this.menteeSkillLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        children: [
          SizedBox(height: 24),
          ...buildTimeCommitment(context, timeAvailability),
          SizedBox(height: 24),
          ...buildMenteeLevel(context, menteeSkillLevel),
          SizedBox(height: 24),
          // ...buildExpertise(context),
          // SizedBox(height: 24),
          // ...buildHobbies(context),
          // SizedBox(height: 24)
        ],
      ),
    );
  }
}

List<Widget> buildExpertise(BuildContext context, List<String> techInterests) {
  // print(techInterests);
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              Text(
                'Expertise',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: CustomColors.appColorOrange,
                    ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 12,
          children: List.generate(
              techInterests.length,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text(techInterests[index]),
                    labelStyle: TextStyle(color: CustomColors.appColorTeal),
                    side: BorderSide(
                      color: CustomColors.appColorTeal,
                    ),
                  )),
        ),
      ],
    )
  ];
}

List<Widget> buildMenteeLevel(
    BuildContext context, List<String> menteeSkillLevel) {
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              Text(
                'Mentee Skill Level preference',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: CustomColors.appColorOrange,
                    ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Wrap(
          spacing: 12,
          children: List.generate(
              menteeSkillLevel.length,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text(menteeSkillLevel[index]),
                    labelStyle: TextStyle(color: CustomColors.appColorTeal),
                    side: BorderSide(
                      color: CustomColors.appColorTeal,
                    ),
                  )),
        ),
      ],
    )
  ];
}

List<Widget> buildTimeCommitment(
    BuildContext context, String timeAvailability) {
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              Text(
                'Time Commitment',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: CustomColors.appColorOrange,
                    ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
        Text(
          timeAvailability,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 16,
                color: CustomColors.appColorTeal,
              ),
          textAlign: TextAlign.start,
        ),
      ],
    )
  ];
}

class MenteeGoalsAndInterestsSection extends ConsumerWidget {
  final List<String> hobbies;
  final List<String> techInterests;

  MenteeGoalsAndInterestsSection(
      {required this.hobbies, required this.techInterests});
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        children: [
          SizedBox(height: 24),
          ...buildExpertise(context, techInterests),
          SizedBox(height: 20),
          ...buildHobbies(context, hobbies),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

// List<Widget> buildTechInterests(BuildContext context, String userId) {
//   final userId = context.read(firebaseAuthProvider).currentUser!.uid;
//   return [
//     Consumer(
//       builder: (BuildContext context,
//           T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
//         final mentorProfileAsyncValue =
//             watch(mentorProfileStreamProvider(userId));

//         return mentorProfileAsyncValue.when(
//             data: (mentor) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 5.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Interests',
//                           style:
//                               Theme.of(context).textTheme.bodyText2!.copyWith(
//                                     fontSize: 16,
//                                     color: CustomColors.appColorOrange,
//                                   ),
//                           textAlign: TextAlign.start,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Wrap(
//                     spacing: 12,
//                     children: List.generate(
//                         mentor.techInterests.length,
//                         (index) => Chip(
//                               backgroundColor: Colors.white,
//                               label: Text('Interest $index'),
//                               labelStyle:
//                                   TextStyle(color: CustomColors.appColorTeal),
//                               side: BorderSide(
//                                 color: CustomColors.appColorTeal,
//                               ),
//                             )),
//                   ),
//                 ],
//               );
//             },
//             loading: () => Container(),
//             error: (e, st) {
//               print(e);
//               print(st);
//               return Container();
//             });
//       },
//     )
//   ];
// }

List<Widget> buildHobbies(BuildContext context, List<String> hobbies) {
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              Text(
                'Hobbies',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      color: CustomColors.appColorOrange,
                    ),
              ),
            ],
          ),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 12,
          children: List.generate(
              hobbies.length,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text(hobbies[index]),
                    labelStyle: TextStyle(color: CustomColors.appColorTeal),
                    side: BorderSide(
                      color: CustomColors.appColorTeal,
                    ),
                  )),
        ),
      ],
    )
  ];
}
