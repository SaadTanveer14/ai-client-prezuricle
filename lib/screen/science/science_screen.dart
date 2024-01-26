import 'dart:async';

import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/screen/chat/chat.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/repositories.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../widgets/appbar_widgets.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;

import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({Key? key, required this.id, required this.name})
      : super(key: key);
  final String id;
  final String name;

  @override
  State<ScienceScreen> createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {
  String selectedQsn = '';

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
    return Consumer(builder: (_, ref, watch) {
      var suggestions = ref.watch(suggestionsProvider(widget.id));
      return suggestions.when(data: (suggestion) {
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
              text: widget.name,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: false,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      autofocus: false,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: isDark ? darkTitleColor : lightTitleColor,
                      textInputAction: TextInputAction.next,
                      decoration: kInputDecoration.copyWith(
                        contentPadding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                        hintText: lang.S.of(context).help,
                        hintStyle: kTextStyle.copyWith(
                            color: isDark
                                ? darkGreyTextColor
                                : lightGreyTextColor),
                        focusColor: kTitleColor,
                        fillColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            IconlyLight.search,
                            color: Color(0xFF525252),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(
                              color: primaryColor.withOpacity(0.1), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide(
                              color: primaryColor.withOpacity(0.1), width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ListView.builder(
                    itemCount: suggestion.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedQsn = suggestion[i].suggestions ?? "";
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              border: Border.all(
                                  color:
                                      selectedQsn == suggestion[i].suggestions
                                          ? primaryColor
                                          : Colors.transparent),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.shadow,
                                  blurRadius: 4.0,
                                  spreadRadius: 1.0,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: Text(
                              suggestion[i].suggestions ?? "",
                              style: kTextStyle.copyWith(
                                color: isDark
                                    ? darkGreyTextColor
                                    : lightGreyTextColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: kButtonStyle,
                onPressed: () async{
                  if(selectedQsn != ""){
                    setState(() {
                      question.add(selectedQsn);
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(query: selectedQsn,),
                      ),
                    );
                  }else{
                    EasyLoading.showInfo("Please Select a Question");
                  }
                },
                child: Text(
                  lang.S.of(context).send,
                  style: kTextStyle.copyWith(
                      color: kWhite, fontWeight: FontWeight.bold),
                ),
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
