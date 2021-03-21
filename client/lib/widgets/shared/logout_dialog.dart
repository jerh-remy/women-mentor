// import 'package:flutter/material.dart';
// import 'package:petra_app/app/router.gr.dart' as router;
// import 'package:petra_app/app/service_locator.dart';
// import 'package:petra_app/services/local_storage_service.dart';

// class LogoutDialog extends StatelessWidget {
//   final LocalStorageService storageService = locator<LocalStorageService>();

//   LogoutDialog({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.symmetric(
//         vertical: 24.0,
//         horizontal: 24.0,
//       ),
//       title: Text(
//         'Confirm Logout',
//         style: TextStyle(
//           fontSize: 20.0,
//         ),
//       ),
//       content: const Text(
//         'Are you sure you want to logout?',
//         style: TextStyle(
//           fontSize: 16.0,
//           color: Colors.black54,
//         ),
//         textAlign: TextAlign.center,
//       ),
//       actions: <Widget>[
//         FlatButton(
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           textColor: Theme.of(context).primaryColor,
//           child: Text(
//             'Cancel'.toUpperCase(),
//             style: TextStyle(
//               // fontWeight: FontWeight.bold,
//               fontSize: 15.0,
//             ),
//           ),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         FlatButton(
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           textColor: Theme.of(context).primaryColor,
//           child: Text(
//             'Logout'.toUpperCase(),
//             style: TextStyle(
//               // fontWeight: FontWeight.bold,
//               fontSize: 15.0,
//             ),
//           ),
//           onPressed: () async {
//             Navigator.pushNamedAndRemoveUntil(
//                 context, router.Router.loginView, (route) => false);
//           },
//         )
//       ],
//     );
//   }
// }
