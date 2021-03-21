import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:women_mentor/widgets/shared/custom_raised_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    required IconData icon,
    required String text,
    Color color: Colors.transparent,
    Color textColor: Colors.black54,
    Color iconColor: Colors.white,
    required VoidCallback onPressed,
  }) : super(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 18.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    text,
                    style: TextStyle(color: textColor, fontSize: 16.0),
                  ),
                ),
              ),
              // Opacity(
              //   opacity: 0.0,
              //   child: Image.asset(assetName),
              // ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
