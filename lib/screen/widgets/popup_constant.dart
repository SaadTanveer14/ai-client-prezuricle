// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
//
// late StreamSubscription subscription;
//
// bool isDeviceConnected = false;
//
// bool isAlertSet = false;
//
// showDialogBox() => showCupertinoDialog<String>(
//   context: context,
//   builder: (BuildContext context) => CupertinoAlertDialog(
//     title: const Text('No Connection'),
//     content: const Text('Please Check Your Internet Connection'),
//     actions: <Widget>[
//       TextButton(
//         onPressed: () async {
//           Navigator.pop(context, 'Cancel');
//           setState(() => isAlertSet = false);
//           isDeviceConnected = await InternetConnectionChecker().hasConnection;
//           if (!isDeviceConnected && isAlertSet == false) {
//             showDialogBox();
//             setState(() => isAlertSet = true);
//           }
//         },
//         child: const Text('Try Again'),
//       ),
//     ],
//   ),
// );