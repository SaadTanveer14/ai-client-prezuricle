import 'dart:async';

import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../widgets/appbar_widgets.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    getConnectivity();
    checkInternet();
    super.initState();
  }

  late StreamSubscription subscription;

  bool isDeviceConnected = false;

  bool isAlertSet = false;

  getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() => isAlertSet = true);
      }
    },
  );

  checkInternet() async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if (!isDeviceConnected) {
      showDialogBox();
      setState(() => isAlertSet = true);
    }
  }
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Consumer(builder: (_,ref,watch){
      var privacyPolicy = ref.watch(privacyProvider);
      return privacyPolicy.when(data: (privacy) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            elevation: 1.0,
            shadowColor: Theme.of(context).colorScheme.shadow,
            backgroundColor: Theme.of(context).colorScheme.background,
            leading: ArrowBack(isDark: isDark),
            centerTitle: true,
            title: TitleText(
              isDark: isDark,
              text: lang.S.of(context).privacy,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: HtmlWidget(privacy.data ?? ""),
            ),
          ),
        );
      }, error: (e, stack) {
        return Text(e.toString());
      }, loading: () {
        return const LoadingWidget();
      });
    });

    
  }

  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      // content: const Text('Please Check Your Internet Connection'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/nointernet.png',height: 70,width: 70,),
          const SizedBox(height: 4,),
          const Text('No Internet',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          const Text('No Internet connection. Make sure Wi-Fi or cellular data is turned on, then try again'),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap:  () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected = await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 44,
                width: 183,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: primaryColor,
                ),
                child: Text('Try Again',style: kTextStyle.copyWith(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
