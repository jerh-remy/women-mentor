import 'package:flutter/material.dart';
import 'package:women_mentor/constants/colors.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.child,
    this.color: CustomColors.appColorTeal,
    this.borderRadius: 4.0,
    this.height: 40.0,
    required this.onPressed,
    this.width,
  }) : super(key: key);
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final double? width;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width * 0.75,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}
