import 'package:flutter/material.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 17.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: textColor, fontSize: 15.0, letterSpacing: 0.5),
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
