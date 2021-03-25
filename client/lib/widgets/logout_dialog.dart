import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogoutTapped;

  const LogoutDialog({Key? key, required this.onLogoutTapped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 24.0,
      ),
      title: Text(
        'Confirm Logout',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black87,
        ),
      ),
      content: const Text(
        'Are you sure you want to logout?',
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black54,
        ),
        textAlign: TextAlign.start,
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          child: Text(
            'Cancel'.toUpperCase(),
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          child: Text(
            'Logout'.toUpperCase(),
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onLogoutTapped();
          },
        )
      ],
    );
  }
}
