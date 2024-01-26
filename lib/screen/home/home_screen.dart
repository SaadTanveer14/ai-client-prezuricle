
import 'dart:async';
import 'package:chat_gpt/screen/subscription/subscription_screen.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/screen/widgets/loading_widget.dart';
import 'package:chat_gpt/services/config.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../provider/home_screen_provider.dart';
import '../chat/chat.dart';
import '../science/science_screen.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;

import '../widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
      var banners = ref.watch(homeScreenBannerProvider);
      var categories = ref.watch(homeScreenCategoryProvider);
      var profile = ref.watch(profileProvider);
      return profile.when(data: (profile) {
        return banners.when(data: (banner) {
          return categories.when(data: (category) {
            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              appBar: AppBar(
                elevation: 1.0,
                shadowColor: Theme.of(context).colorScheme.shadow,
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                titleSpacing: 10,
                leading: ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 0,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: !(profile.data?.image ?? "").endsWith("g")
                            ? const DecorationImage(
                                image: AssetImage("images/no-avatar.png"),
                                fit: BoxFit.cover)
                            : DecorationImage(
                                image: NetworkImage(Config.webSiteUrl +
                                    (profile.data?.image ?? "")),
                                fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                centerTitle: false,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.data?.name ?? "",
                      style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor),
                    ),
                    Text(
                      "${(profile.data?.plan?.title ?? "Free")} plan",
                      style: kTextStyle.copyWith(
                          color:
                              isDark ? darkGreyTextColor : lightGreyTextColor,
                          fontSize: 14.0),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 10.0, bottom: 5.0, top: 5.0, left: 5.0),
                    child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          image: const DecorationImage(
                              image: AssetImage('images/icon_bg.png'),
                              fit: BoxFit.cover),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  lang.S.of(context).getPro,
                                  style: kTextStyle.copyWith(
                                      color: darkTitleColor, fontSize: 12.0),
                                ),
                                Text(
                                  lang.S.of(context).freeSavenDays,
                                  style: kTextStyle.copyWith(
                                      color: darkTitleColor, fontSize: 10.0),
                                ),
                              ],
                            ),
                            const Icon(IconlyBold.arrowRight2),
                          ],
                        ),
                      ),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SubscriptionScreen(),
                          ),
                        );

                      },
                    ),
                  ).visible(profile.data!.planId == null)
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 125,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: banner.data?.length ?? 0,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, i) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ScienceScreen(
                                                id: banner.data?[i].category?.id
                                                        .toString() ??
                                                    "0",
                                                name: banner
                                                        .data?[i].category?.name
                                                        .toString() ??
                                                    "0")));
                                  },
                                  child: Container(
                                    height: 125,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      image: DecorationImage(
                                          image: NetworkImage(Config
                                                  .webSiteUrl +
                                              (banner.data?[i].image ?? "")),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang.S.of(context).homeButtonTitle,
                              maxLines: 1,
                              style: kTextStyle.copyWith(
                                color:
                                    isDark ? darkTitleColor : lightTitleColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2.5),
                                itemCount: category.length,
                                itemBuilder: (_, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ScienceScreen(
                                                id: (category[index].id ?? 0)
                                                    .toString(),
                                                name:
                                                    category[index].name ?? "",
                                              ),
                                            ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 38.0,
                                              width: 38.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        Config.webSiteUrl +
                                                            (category[index]
                                                                    .image ??
                                                                "")),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            Flexible(
                                              child: Text(
                                                category[index].name ?? "",
                                                maxLines: 1,
                                                style: kTextStyle.copyWith(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: isDark
                                                      ? darkTitleColor
                                                      : lightTitleColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                            const SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }, error: (e, stack) {
            print(stack);
            return Text(e.toString());
          }, loading: () {
            return const LoadingWidget();
          });
        }, error: (e, stack) {
          print(stack);
          return Text(e.toString());
        }, loading: () {
          return const LoadingWidget();
        });
      }, error: (e, stack) {
        print(stack);
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
