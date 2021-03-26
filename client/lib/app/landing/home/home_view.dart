import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:women_mentor/app/landing/home/feed_post_card.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:women_mentor/widgets/shared/search_field.dart';

final posts = List.generate(30, (index) => 'Lorem Ipsum $index');

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: HomeFeed(),
        ),
      ),
    );
  }
}

class HomeFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageTitle(text: 'Feed'),
        ),
        Expanded(child: HomeFeedPosts()),
      ],
    );
  }
}

class HomeFeedPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBarScrollNotifier(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 16.0),
        itemBuilder: (ctx, index) {
          if (index == posts.length - 1) return SizedBox(height: 8.0);
          return FeedPostCard(content: posts[index]);
        },
        itemCount: posts.length,
      ),
    );
  }
}
