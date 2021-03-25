import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class GetToken extends StatefulWidget {
  @override
  _GetTokenState createState() => _GetTokenState();
}

class _GetTokenState extends State<GetToken> {
  String _token = '';

  Future<void> saveMessagingTokenToFirestore(String token) async {
    // String userId = FirebaseAuth.instance.currentUser.uid;

    // await FirebaseFirestore.instance
    //   .collection('registrations')
    //   .doc(userId)
    //   .update({
    //     'token': token,
    //   });
    this.setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    super.initState();
    // Get the token each time the application loads
    FirebaseMessaging.instance.getToken().then((token) => {
          if (token != null)
            {
              // Save the initial token to the database
              saveMessagingTokenToFirestore(token)
            }
        });

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh
        .listen(saveMessagingTokenToFirestore);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _token,
            style: new TextStyle(fontSize: 14),
          ),
          TextButton(
            child: Text('PRINT TOKEN'),
            onPressed: () {
              print(_token);
            },
          ),
        ],
      ),
    );
  }
}
