import 'dart:async';

import 'package:chat_gpt/model/profile_information_model.dart';
import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../services/admob.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/constant.dart';
import '../widgets/loading_widget.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;

class MyCoin extends StatefulWidget {
  const MyCoin({super.key, required this.profile});

  final ProfileInformationModel profile;

  @override
  State<MyCoin> createState() => _MyCoinState();
}

class _MyCoinState extends State<MyCoin> with TickerProviderStateMixin {
  TabController? tabController;

  Admob admob = Admob();

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    getConnectivity();
    checkInternet();
    admob.createRewardedAd();
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
      var earnHistory = ref.watch(earnProvider);
      var costHistory = ref.watch(costProvider);
      var profile = ref.watch(profileProvider);

      return earnHistory.when(data: (earn) {
        return DefaultTabController(
          length: 2,
          initialIndex: 1,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              elevation: 1.0,
              shadowColor: Theme.of(context).colorScheme.shadow,
              backgroundColor: Theme.of(context).colorScheme.background,
              leading: ArrowBack(isDark: isDark),
              centerTitle: true,
              title: TitleText(
                isDark: isDark,
                text: lang.S.of(context).myCoin,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 32.0,
                    width: 87,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            textStyle: kTextStyle.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: Theme.of(context).colorScheme.background,
                            foregroundColor: primaryColor,
                            side: const BorderSide(color: primaryColor)),
                        onPressed: () {
                          admob.showRewardedAd(ref: ref);
                        },
                        child: Text(lang.S.of(context).collect)),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: const Color(0xFF5372F9)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang.S.of(context).creditBalance,
                              style: kTextStyle.copyWith(color: kWhite.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kWhite.withOpacity(0.2),
                                  ),
                                  child: const Icon(
                                    IconlyBold.ticketStar,
                                    color: kWhite,
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Text(
                                  (profile.value?.data?.credits ?? 0).toString(),
                                  style: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold, fontSize: 20.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('images/card.png'), fit: BoxFit.contain),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      topLeft: Radius.circular(24.0),
                    ),
                  ),
                  child: TabBar(
                    controller: tabController,
                    labelColor: primaryColor,
                    unselectedLabelColor: isDark ? darkGreyTextColor : lightGreyTextColor,
                    tabs: [
                      Tab(
                        text: lang.S.of(context).creditIn,
                      ),
                      Tab(
                        text: lang.S.of(context).creditOut,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                ),
                Expanded(
                  child: SizedBox(
                    // height: MediaQuery.of(context).size.height / 1.5,
                    child: TabBarView(controller: tabController, children: [
                      ListView.builder(
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 7.0, spreadRadius: 1.0, offset: const Offset(0, 1))]),
                              child: ListTile(
                                visualDensity: const VisualDensity(vertical: -4),
                                title: Text(
                                  earn.data?[i].platform ?? "",
                                  style: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor),
                                  maxLines: 1,
                                ),
                                subtitle: Text(
                                  'Date: ${DateTimeFormat.format(DateTime.parse(earn.data?[i].createdAt ?? ""), format: AmericanDateFormats.dayOfWeek)}',
                                  style: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
                                  maxLines: 1,
                                ),
                                trailing: Text(
                                  '+${earn.data?[i].credits ?? 0}',
                                  style: kTextStyle.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          );
                        },
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        itemCount: earn.data?.length ?? 0,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                      ),
                      costHistory.when(data: (cost) {
                        return ListView.builder(
                          itemBuilder: (_, i) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Theme.of(context).colorScheme.secondaryContainer,
                                    boxShadow: [BoxShadow(color: isDark ? Colors.black : Colors.grey.shade200, blurRadius: 7.0, spreadRadius: 1.0, offset: const Offset(0, 1))]),
                                child: ListTile(
                                  visualDensity: const VisualDensity(vertical: -4),
                                  title: Text(
                                    cost.data?[i].title ?? "",
                                    style: kTextStyle.copyWith(color: isDark ? darkTitleColor : lightTitleColor),
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    'Date: ${DateTimeFormat.format(DateTime.parse(cost.data?[i].createdAt ?? ""), format: AmericanDateFormats.dayOfWeek)}',
                                    style: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
                                    maxLines: 1,
                                  ),
                                  trailing: Text(
                                    '-${cost.data?[i].costCredits ?? 0}',
                                    style: kTextStyle.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            );
                          },
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          itemCount: cost.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                        );
                      }, error: (e, stack) {
                        return Text(e.toString());
                      }, loading: () {
                        return const LoadingWidget();
                      }),
                    ]),
                  ),
                )
              ],
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
              Image.asset(
                'images/nointernet.png',
                height: 70,
                width: 70,
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'No Internet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text('No Internet connection. Make sure Wi-Fi or cellular data is turned on, then try again'),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
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
                    child: Text(
                      'Try Again',
                      style: kTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
