// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
//
// class ErrorWidgetCustom extends StatefulWidget {
//   const ErrorWidgetCustom({super.key, required this.error});
//   final String error;
//
//   @override
//   State<ErrorWidgetCustom> createState() => _ErrorWidgetCustomState();
// }
//
// class _ErrorWidgetCustomState extends State<ErrorWidgetCustom> {
//   @override
//   void initState() {
//     getConnectivity();
//     checkInternet();
//     super.initState();
//   }
//
//   late StreamSubscription subscription;
//
//   bool isDeviceConnected = false;
//
//   bool isAlertSet = false;
//
//   getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen(
//         (ConnectivityResult result) async {
//       isDeviceConnected = await InternetConnectionChecker().hasConnection;
//       if (!isDeviceConnected && isAlertSet == false) {
//         showDialogBox();
//         setState(() => isAlertSet = true);
//       }
//     },
//   );
//
//   checkInternet() async {
//     isDeviceConnected = await InternetConnectionChecker().hasConnection;
//     if (!isDeviceConnected) {
//       showDialogBox();
//       setState(() => isAlertSet = true);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer(builder: (_,ref,watch){
//         return Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // showDialogBox()
//               // Center(
//               //   child: Text(widget.error),
//               // ),
//               // SizedBox(height: 10.0,),
//               // GestureDetector(
//               //   onTap: (){
//               //     ref.refresh(profileProvider);
//               //     ref.refresh(homeScreenBannerProvider);
//               //     ref.refresh(homeScreenCategoryProvider);
//               //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Home()), (route) => false);
//               //   },
//               //   child: Container(
//               //     padding: EdgeInsets.all(10.0),
//               //     decoration: BoxDecoration(
//               //         color: primaryColor
//               //     ),
//               //     child: Text('Try Again',style: kTextStyle.copyWith(color: Colors.white),),
//               //   ),
//               // ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   showDialogBox() => showCupertinoDialog<String>(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: const Text('No Connection'),
//       content: const Text('Please Check Your Internet Connection'),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () async {
//             Navigator.pop(context, 'Cancel');
//             setState(() => isAlertSet = false);
//             isDeviceConnected = await InternetConnectionChecker().hasConnection;
//             if (!isDeviceConnected && isAlertSet == false) {
//               showDialogBox();
//               setState(() => isAlertSet = true);
//             }
//           },
//           child: const Text('Try Again'),
//         ),
//       ],
//     ),
//   );
// }
