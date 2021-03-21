import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';

class PageIndicator extends StatefulWidget {
  final bool isActive;

  const PageIndicator({Key? key, required this.isActive}) : super(key: key);
  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      height: 10.0,
      width: widget.isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
        border: widget.isActive
            ? Border.all(
                color: CustomColors.appColorTeal,
              )
            : null,
        color: widget.isActive
            ? CustomColors.appColorTeal
            : CustomColors.appColorTeal.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }
}
