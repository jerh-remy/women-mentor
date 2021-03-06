import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:women_mentor/constants/colors.dart';

class FeedPostCard extends StatelessWidget {
  final String content;
  final String photoUrl;

  const FeedPostCard({Key? key, required this.content, required this.photoUrl})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade100,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
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
                        content,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    Text(
                      '8 hours ago',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Platform.isAndroid
                    ? IconButton(
                        icon: Icon(Icons.share_outlined),
                        iconSize: 20,
                        onPressed: () {},
                      )
                    : IconButton(
                        icon: Icon(Icons.ios_share),
                        iconSize: 20,
                        onPressed: () {},
                      )
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Lorem nulla fugiat id incididunt eiusmod do proident cupidatat in. Dolor nostrud exercitation laboris in aute. Aliquip elit magna minim laborum sint qui voluptate aliquip officia eu. Esse nulla incididunt reprehenderit do irure amet laboris quis deserunt veniam cupidatat elit fugiat. Veniam enim esse ea deserunt nisi minim consequat mollit ut. Nostrud elit est nulla et nulla voluptate. Deserunt minim fugiat exercitation deserunt et cupidatat sint laboris amet adipisicing.',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
            child: Image.network(
              photoUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.network(
                'https://picsum.photos/300',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
