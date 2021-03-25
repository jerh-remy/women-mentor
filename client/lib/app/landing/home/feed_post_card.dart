import 'dart:io';

import 'package:flutter/material.dart';

class FeedPostCard extends StatelessWidget {
  final String content;

  const FeedPostCard({Key? key, required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20),
      elevation: 0.4,
      child: Container(
        padding: EdgeInsets.all(16),
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
                        content,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    Text(
                      '2 hours ago',
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
            SizedBox(height: 16),
            Row(
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
            SizedBox(height: 16),
            Image.network(
              'https://picsum.photos/250?image=9',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
