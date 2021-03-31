import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/app/landing/explore/mentor_profile_view.dart';
import 'package:women_mentor/constants/colors.dart';

class MentorCard extends StatelessWidget {
  final String mentorId;
  final String fullName;
  final String? role;
  final String? offerStatement;

  const MentorCard(
      {Key? key,
      required this.mentorId,
      required this.fullName,
      required this.role,
      required this.offerStatement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: CustomColors.appColorTeal.withOpacity(0.2),
                child: Icon(
                  Ionicons.person_outline,
                  color: CustomColors.appColorTeal,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      fullName,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 17,
                          ),
                    ),
                  ),
                  Text(
                    role ?? 'Developer',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text(
                  offerStatement ??
                      'Fugiat labore commodo qui aute proident non deserunt aute anim velit.',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          OutlinedButton(
            child: Text('VIEW PROFILE'),
            onPressed: () {
              MentorProfileView.show(context, mentorId);
            },
            style: OutlinedButton.styleFrom(
              primary: CustomColors.appColorTeal,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          )
        ],
      ),
    );
  }
}
