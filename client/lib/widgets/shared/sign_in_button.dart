import 'package:flutter/material.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    Key? key,
    required String text,
    required Color color,
    Color? textColor,
    required VoidCallback onPressed,
  }) : super(
          key: key,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 16.0),
            ),
          ),
          color: color,
          onPressed: onPressed,
        );
}
