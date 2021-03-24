import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';

class ProfileView extends StatelessWidget {
  final String role;

  const ProfileView({Key? key, this.role = 'mentee'}) : super(key: key);
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
                      'Profile',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20,
                            color: CustomColors.appColorOrange,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              ProfileCard(),
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
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 20),
        elevation: 0.50,
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade100,
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Text(
                          'Jeremy Offori',
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
        ));
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
