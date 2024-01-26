import 'dart:async';

import 'package:chat_gpt/screen/image/view_image.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../provider/home_screen_provider.dart';
import '../../services/config.dart';
import '../widgets/appbar_widgets.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'image_history_details.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late TabController controller;
  int activeIndex = 0;

  @override
  void initState() {
    controller =
        TabController(length: 2, vsync: this, initialIndex: activeIndex);
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

  List<String> titleList = [
    'Education Image',
    'Gardening  Image',
    'Plant Image',
    'Best gardening Image',
    'Education Image',
    'Education Image',
    'Education Image',
    'Education Image',
    'Education Image',
    'Gardening  Image',
    'Plant Image',
  ];

  Future<void> _copyToClipboard(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Answer Copied'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Consumer(builder: (_, ref, watch) {
      var textHistory = ref.watch(textHistoryProvider);
      var imageHistory = ref.watch(imageHistoryProvider);
      return textHistory.when(data: (text) {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              elevation: 1.0,
              shadowColor: Theme.of(context).colorScheme.shadow,
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: isDark ? darkTitleColor : lightTitleColor,
                  )),
              centerTitle: true,
              title: TitleText(
                isDark: isDark,
                text: lang.S.of(context).history,
              ),
            ),
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(),
                  child: TabBar(
                      labelColor: const Color(0xff001EC0),
                      unselectedLabelColor:
                          isDark ? darkTitleColor : const Color(0xff525252),
                      indicatorColor: const Color(0xff001EC0),
                      controller: controller,
                      indicatorWeight: 2.0,
                      tabs: [
                        Tab(
                          text: lang.S.of(context).chatHistory,
                        ),
                        Tab(
                          text: lang.S.of(context).imageHistory,
                        )
                      ]),
                ),
                Expanded(
                  child: TabBarView(controller: controller, children: [
                    ListView.builder(
                      itemCount: text.data?.length ?? 0,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              _copyToClipboard(text.data?[i].data?[0] ??
                                  lang.S.of(context).notFound);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    text.data?[i].title ?? "",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: kTextStyle.copyWith(
                                      color: isDark
                                          ? darkTitleColor
                                          : lightTitleColor,
                                    ),
                                  ),
                                  Text(
                                    text.data?[i].data?[0] ??
                                        lang.S.of(context).notFound,
                                    textAlign: TextAlign.start,
                                    style: kTextStyle.copyWith(
                                      color: isDark
                                          ? darkGreyTextColor
                                          : lightGreyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    imageHistory.when(data: (image) {
                      return SingleChildScrollView(
                        child: ListView.builder(
                            itemCount: image.data?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, i) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewImage(url:Config.webSiteUrl +  (image.data?[i].data?[0] ?? ""), title: image.data?[i].title ?? "")));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                        border: Border.all(
                                            color: isDark
                                                ? Colors.transparent
                                                : kBorderColorTextField,
                                            width: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                image.data?[i].title ?? "",
                                                style: kTextStyle.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: isDark
                                                        ? darkTitleColor
                                                        : lightTitleColor),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'See your recent Image',
                                                style: kTextStyle.copyWith(
                                                    color: isDark
                                                        ? darkGreyTextColor
                                                        : kLightNeutralColor),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }, error: (e, stack) {
                      return Text(e.toString());
                    }, loading: () {
                      return const LoadingWidget();
                    })
                  ]),
                )
              ],
            ));
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
