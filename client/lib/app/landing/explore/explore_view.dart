import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:women_mentor/app/landing/explore/mentor_card.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/models/user.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:women_mentor/widgets/shared/search_field.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              BottomLayer(),
              Positioned(
                child: SearchField(),
                top: 50,
                left: 10,
                right: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomLayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: PageTitle(text: 'Explore Mentors')),
        SizedBox(height: 48),
        FilterSection(),
        Expanded(child: MentorList()),
      ],
    );
  }
}

class MentorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBarScrollNotifier(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => SizedBox(height: 16.0),
        itemBuilder: (ctx, index) {
          if (index == 0 || index == 19) return SizedBox(height: 8.0);
          return MentorCard();
        },
        itemCount: 20,
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ActionChip(
              side: BorderSide(
                width: 0.8,
                color: Colors.grey.shade200,
              ),
              backgroundColor: Colors.white,
              avatar: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.filter_alt,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
              label: Text('Filter'),
              onPressed: () {
                print("If you stand for nothing, Burr, what’ll you fall for?");
              }),
          SizedBox(width: 10),
          InputChip(
            onPressed: () {},
            onDeleted: () {},
            avatar: const Icon(
              Icons.directions_bike,
              size: 20,
              color: Colors.black54,
            ),
            deleteIconColor: Colors.black54,
            label: Text('Selected'),
          ),
        ],
      ),
    );
  }
}
