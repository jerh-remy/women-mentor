import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:women_mentor/constants/utilities.dart';
import 'package:women_mentor/widgets/logout_dialog.dart';

class ProfileView extends StatelessWidget {
  final String role;

  const ProfileView({Key? key, this.role = 'mentee'}) : super(key: key);

  Future<void> _confirmSignOut(
      BuildContext context, FirebaseAuth firebaseAuth) async {
    showDialog(
        context: context,
        builder: (context) {
          return LogoutDialog(onLogoutTapped: () => _signOut(firebaseAuth));
        });
  }

  void _signOut(FirebaseAuth firebaseAuth) async {
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
              role != 'mentee'
                  ? Flexible(child: MenteeGoalsAndInterestsSection())
                  : Flexible(child: MentorGoalsAndInterestsSection())
            ],
          ),
        ),
      ),
    );
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
                MenteeGoalsAndInterestsSection(),
                MentorSpecificSection(),
              ]),
            );
          },
        ));
  }
}

class MentorSpecificSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        children: [
          SizedBox(height: 24),
          ...buildExpertise(context),
          SizedBox(height: 24),
          ...buildTimeCommitment(context),
          SizedBox(height: 24),
          ...buildMenteeLevel(context),
          SizedBox(height: 24),
          ...buildTechInterests(context),
          SizedBox(height: 24),
          ...buildHobbies(context),
          SizedBox(height: 24)
        ],
      ),
    );
  }
}

List<Widget> buildExpertise(BuildContext context) {
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
              2,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text('Skill $index'),
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

List<Widget> buildMenteeLevel(BuildContext context) {
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
              2,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text('Beginner $index'),
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

List<Widget> buildTimeCommitment(BuildContext context) {
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
          '12 hours per week',
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

class MenteeGoalsAndInterestsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        children: [
          SizedBox(height: 24),
          ...buildGoals(context),
          SizedBox(height: 20),
          ...buildTechInterests(context),
          SizedBox(height: 20),
          ...buildHobbies(context),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

List<Widget> buildGoals(BuildContext context) {
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              Text(
                'Goals',
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
          alignment: WrapAlignment.spaceBetween,
          spacing: 12,
          children: List.generate(
              5,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text('Goal $index'),
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

List<Widget> buildTechInterests(BuildContext context) {
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Row(
            children: [
              Text(
                'Interests',
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
              5,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text('Interest $index'),
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

List<Widget> buildHobbies(BuildContext context) {
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
          alignment: WrapAlignment.spaceBetween,
          spacing: 12,
          children: List.generate(
              3,
              (index) => Chip(
                    backgroundColor: Colors.white,
                    label: Text('Hobby $index'),
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
