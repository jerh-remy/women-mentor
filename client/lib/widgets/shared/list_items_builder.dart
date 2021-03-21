import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:women_mentor/widgets/shared/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key? key,
    this.items,
    required this.itemBuilder,
    this.scrollController,
    this.emptyContent,
  }) : super(key: key);
  final List<T>? items;
  final ItemWidgetBuilder<T> itemBuilder;
  final ScrollController? scrollController;
  final Widget? emptyContent;

  @override
  Widget build(BuildContext context) {
    if (items != null) {
      if (items!.isNotEmpty) {
        return _buildList(items!);
      } else {
        return emptyContent ?? EmptyContent();
      }
    } else {
      return Center(
        child: emptyContent ?? EmptyContent(),
      );
    }
  }

  Widget _buildList(List<T> items) {
    return AnimationLimiter(
      child: ListView.separated(
        itemCount: items.length + 2,
        controller: scrollController,
        // separatorBuilder: (context, index) => Divider(height: 0.5),
        separatorBuilder: (context, index) => SizedBox(height: 4.0),
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
