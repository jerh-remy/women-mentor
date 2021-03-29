import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:women_mentor/constants/colors.dart';
import 'package:women_mentor/widgets/shared/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
    this.scrollController,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return data.when(
        data: (items) =>
            items.isNotEmpty ? _buildList(items) : const EmptyContent(),
        loading: () => const Center(
                child: SpinKitCircle(
              color: CustomColors.appColorTeal,
            )),
        error: (err, st) {
          print(err);
          print(st);
          return const EmptyContent(
            title: 'Something went wrong',
            message: 'Can\'t load items right now',
          );
        });
  }

  Widget _buildList(List<T> items) {
    return AnimationLimiter(
      child: ListView.separated(
        itemCount: items.length + 2,
        controller: scrollController,
        // separatorBuilder: (context, index) => Divider(height: 0.5),
        separatorBuilder: (context, index) => SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          if (index == 0 || index == items.length + 1) {
            return Container();
          }
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 250),
            child: FadeInAnimation(
              child: itemBuilder(context, items[index - 1]),
            ),
          );
        },
      ),
    );
  }
}
