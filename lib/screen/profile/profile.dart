import 'dart:async';
import 'package:chat_gpt/provider/home_screen_provider.dart';
import 'package:chat_gpt/screen/authentication/log_in.dart';
import 'package:chat_gpt/screen/home/home.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/admob.dart';
import 'package:chat_gpt/services/database.dart';
import 'package:chat_gpt/services/repositories.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../main.dart';
import '../../services/config.dart';
import '../faq screen/faq_screen.dart';
import '../history/history.dart';
import '../language/language.dart';
import '../my credit/my_coin.dart';
import '../privacy & policy/privacy.dart';
import '../subscription/subscription_screen.dart';
import '../terms/term_condition.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';
import 'edit_profile.dart';
import 'my_profile.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import '../../model/subscription_plan_list_model.dart' as sub;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Admob admob = Admob();

  @override
  void initState() {
    admob.createRewardedAd();
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
      var profile = ref.watch(profileProvider);
      return profile.when(data: (profile) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            elevation: 1.0,
            shadowColor: Theme.of(context).colorScheme.shadow,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            centerTitle: true,
            iconTheme: IconThemeData(color: isDark ? darkTitleColor : lightTitleColor),
            title: TitleText(
              isDark: isDark,
              text: lang.S.of(context).profileTitle,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: !(profile.data?.image ?? "").endsWith("g")
                                  ? const DecorationImage(image: AssetImage("images/no-avatar.png"), fit: BoxFit.cover)
                                  : DecorationImage(image: NetworkImage(Config.webSiteUrl + (profile.data?.image ?? "")), fit: BoxFit.cover),
                              border: Border.all(color: primaryColor)),
                        ),
                        Text(
                          profile.data?.name ?? "",
                          textAlign: TextAlign.center,
                          style: kTextStyle.copyWith(
                            color: isDark ? darkTitleColor : lightTitleColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          profile.data?.email ?? "",
                          textAlign: TextAlign.center,
                          style: kTextStyle.copyWith(
                            color: isDark ? darkGreyTextColor : lightGreyTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Theme.of(context).colorScheme.secondaryContainer),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 48.0,
                                    width: 48.0,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: const Color(0xFF8F00FF).withOpacity(0.15),
                                    ),
                                    child: const Icon(
                                      IconlyBold.ticketStar,
                                      color: Color(0xFF8F00FF),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        lang.S.of(context).credit,
                                        style: kTextStyle.copyWith(
                                          color: isDark ? darkTitleColor : lightTitleColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90,
                                        child: Text(
                                          'Check in daily to earn Credit',
                                          style: kTextStyle.copyWith(
                                            color: isDark ? darkGreyTextColor : lightGreyTextColor,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                height: 32.0,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff8424FF),
                                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      textStyle: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      admob.showRewardedAd(ref: ref);
                                    },
                                    child: Text(lang.S.of(context).collect,style: kTextStyle.copyWith(color: kWhite,fontWeight: FontWeight.bold),)),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: Theme.of(context).colorScheme.secondaryContainer),
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 48.0,
                                    width: 48.0,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: const Color(0xFF16A34A).withOpacity(0.15),
                                    ),
                                    child: const Icon(
                                      IconlyBold.wallet,
                                      color: Color(0xFF16A34A),
                                    ),
                                  ),
                                  const SizedBox(width: 5.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        lang.S.of(context).balance,
                                        style: kTextStyle.copyWith(
                                          color: isDark ? darkTitleColor : lightTitleColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90,
                                        child: RichText(
                                          text: TextSpan(
                                              text: 'You Have ',
                                              style: kTextStyle.copyWith(
                                                color: isDark ? darkGreyTextColor : lightGreyTextColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: (profile.data?.credits ?? 0).toString(),
                                                  style: kTextStyle.copyWith(
                                                    color: primaryColor,
                                                  ),
                                                ),
                                                const TextSpan(text: ' Credits')
                                              ]),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              SizedBox(
                                height: 32.0,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                        textStyle: kTextStyle.copyWith(fontWeight: FontWeight.bold),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                        foregroundColor: primaryColor,
                                        side: const BorderSide(
                                          color: primaryColor,
                                        )),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                      );
                                    },
                                    child: Text(lang.S.of(context).usenow)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),

                  //____________________________________________________________________My_profile
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
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
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyProfile(
                              profile: profile,
                            ),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF9D1C),
                        ),
                        child: const Icon(
                          IconlyBold.profile,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        lang.S.of(context).profile,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
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
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCoin(
                              profile: profile,
                            ),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF8F00FF),
                        ),
                        child: const Icon(
                          IconlyBold.ticketStar,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        lang.S.of(context).myCredit,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
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
                    child: ListTile(
                      onTap: () async {
                        profile.data?.planId.toString() != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SubscriptionScreen(
                                    willExpire: DateTime.parse(profile.data?.willExpire ?? '1900-01-01'),
                                    userPlan: sub.Data(
                                      id: profile.data?.plan?.id,
                                      status: profile.data?.plan?.status,
                                      title: profile.data?.plan?.title,
                                      createdAt: profile.data?.plan?.createdAt,
                                      duration: profile.data?.plan?.duration,
                                      price: profile.data?.plan?.price,
                                      subtitle: profile.data?.plan?.subtitle,
                                      updatedAt: profile.data?.plan?.updatedAt,
                                    ),
                                  ),
                                ),
                              )
                            : EasyLoading.showInfo("You Already have a Subscription");
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF204DE9),
                        ),
                        child: const Icon(
                          IconlyBold.ticketStar,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        "${lang.S.of(context).plan} ${profile.data?.planId.toString() != null ? "(Active)" : ""}",
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      subtitle: profile.data?.planId.toString() != null
                          ? Text(
                              "Will Expire: ${profile.data?.willExpire}",
                              textAlign: TextAlign.start,
                              style: kTextStyle.copyWith(
                                color: isDark ? darkTitleColor : lightTitleColor,
                              ),
                            )
                          : const SizedBox(),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Language(),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF05E6F0),
                        ),
                        child: const Icon(
                          Icons.translate,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        lang.S.of(context).language,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ThemeSwitch(isDark: isDark),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryScreen(),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF94141),
                        ),
                        child: const Icon(
                          IconlyBold.paper,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        lang.S.of(context).history,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FaqScreen(),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: AssetImage('images/faq.png'))),
                      ),
                      title: Text(
                        lang.S.of(context).faq,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy(),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF204DE9),
                        ),
                        child: const Icon(
                          IconlyBold.danger,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        lang.S.of(context).privacy,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TermsConditions(),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF05E6F0),
                        ),
                        child: const Icon(
                          IconlyBold.infoCircle,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        lang.S.of(context).term,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow,
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () async {
                        EasyLoading.show(status: "Logging Out");
                        try {
                          await ApiService().logOut();
                          await DataBase().deleteToken().then((value) {
                            EasyLoading.showSuccess("Log out successful");
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LogIn()), (route) => false);
                          });
                        } catch (e) {
                          EasyLoading.showError(e.toString());
                        }
                      },
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF00A6FF),
                        ),
                        child: const Icon(
                          IconlyBold.logout,
                          color: kWhite,
                        ),
                      ),
                      title: Text(
                        lang.S.of(context).logOut,
                        textAlign: TextAlign.start,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                        ),
                      ),
                      trailing: Icon(
                        IconlyLight.arrowRight2,
                        color: isDark ? darkIconColor : lightGreyTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
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
