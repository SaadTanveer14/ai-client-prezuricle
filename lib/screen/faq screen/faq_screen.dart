import 'dart:async';

import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../widgets/appbar_widgets.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  String selectedQsn = 'How does gravity work?';

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
      var faqs = ref.watch(faqProvider);
      return faqs.when(data: (faq) {
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
              text: lang.S.of(context).faq,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: faq.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Theme.of(context).colorScheme.secondaryContainer,
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.shadow,
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Theme(
                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                childrenPadding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                tilePadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                iconColor: lightGreyTextColor,
                                collapsedIconColor: lightGreyTextColor,
                                title: Text(
                                  faq[i].question ?? "",
                                  style: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor),
                                ),
                                children: [
                                  Text(
                                    faq[i].answer ?? "",
                                    style: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
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
