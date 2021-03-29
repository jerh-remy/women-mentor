import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:women_mentor/app/landing/explore/mentor_card.dart';
import 'package:women_mentor/app/top_level_providers.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/models/ranked_mentors_response.dart';
import 'package:women_mentor/models/user.dart';
import 'package:women_mentor/services/api.dart';
import 'package:women_mentor/widgets/shared/list_items_builder.dart';
import 'package:women_mentor/widgets/shared/page_title.dart';
import 'package:women_mentor/widgets/shared/search_field.dart';

final rankedMentorsProvider = FutureProvider<List<RankedMentor>>((ref) {
  final ApiProvider api = ApiProvider();
  final currentUser = ref.watch(authCurrentUserProvider);
  return api.getRankedMentors(currentUser!.uid);
});

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

class MentorList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final rankedMentorsAsyncValue = watch(rankedMentorsProvider);

    return ListItemsBuilder<RankedMentor>(
        data: rankedMentorsAsyncValue,
        itemBuilder: (context, mentor) {
          return MentorCard(
            mentorId: mentor.id,
            fullName: '${mentor.firstName} ${mentor.lastName} ',
            role: mentor.jobTitle,
            offerStatement: mentor.offerStatement,
          );
        });
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
          // InputChip(
          //   onPressed: () {},
          //   onDeleted: () {},
          //   avatar: const Icon(
          //     Icons.directions_bike,
          //     size: 20,
          //     color: Colors.black54,
          //   ),
          //   deleteIconColor: Colors.black54,
          //   label: Text('Selected'),
          // ),
        ],
      ),
    );
  }
}
