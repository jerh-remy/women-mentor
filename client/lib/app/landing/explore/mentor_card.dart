import 'package:flutter/material.dart';
import 'package:women_mentor/app/landing/explore/mentor_profile_view.dart';
import 'package:women_mentor/constants/colors.dart';

class MentorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
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
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ),
                  Text(
                    'VP Figma Design',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
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
                  'Dolor elit ipsum adipisicing excepteur proident esse nisi irure anim in qui. Mollit amet commodo commodo fugiat quis adipisicing ut consectetur et laboris.',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                  maxLines: 3,
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          OutlinedButton(
            child: Text('VIEW PROFILE'),
            onPressed: () {
              MentorProfileView.show(context);
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
