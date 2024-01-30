import 'dart:async';

import 'package:chat_gpt/screen/image/view_image.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../provider/home_screen_provider.dart';
import '../../services/config.dart';
import '../../services/repositories.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/loading_widget.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String text = '';
  bool showImage = false;

  void _onTextChanged(String newText) {
    setState(() {
      text = newText;
      showImage = false;
    });
  }

  void _onSubmitPressed() {
    setState(() {
      showImage = true;
    });
  }

  void _onClearPressed() {
    setState(() {
      text = '';
      showImage = false;
    });
  }

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

  List<String> imageList = [
    'images/image1.png',
    'images/image2.png',
    'images/image3.png',
    'images/image4.png',
    'images/image5.png',
    'images/image6.png',
  ];

  List<String> sizeList = [
    '256x256',
    '512x512',
    '1024x1024',
  ];

  String selectedSize = '256x256';
  TextEditingController imagePromptController = TextEditingController();
  String prompt = "";

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Consumer(builder: (_, ref, watch) {
      var profileData = ref.watch(profileProvider);
      return profileData.when(data: (profile) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            iconTheme: IconThemeData(color: isDark?darkTitleColor:lightTitleColor),
            elevation: 1.0,
            shadowColor: Theme.of(context).colorScheme.shadow,
            backgroundColor: Theme.of(context).colorScheme.background,
            centerTitle: true,
            title: TitleText(
              isDark: isDark,
              text: lang.S.of(context).image,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: imagePromptController,
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: isDark ? darkTitleColor : lightTitleColor,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(color:isDark? Colors.white:Colors.black),
                    decoration: kInputDecoration.copyWith(
                      contentPadding:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                      hintText: lang.S.of(context).imgSearch,
                      hintStyle: kTextStyle.copyWith(
                          color:
                              isDark ? darkGreyTextColor : lightGreyTextColor),
                      focusColor: kTitleColor,
                      fillColor:
                          Theme.of(context).colorScheme.secondaryContainer,

                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? const Color(0xff363C4D)
                                  : primaryColor.withOpacity(0.1)),
                          child: GestureDetector(
                            onTap: () async {
                              prompt = imagePromptController.text;
                              imagePromptController.clear();
                              EasyLoading.show(status: "Generating Content");
                              try {
                                await ApiService()
                                    .getImage(prompt, selectedSize)
                                    .then((value) {
                                  setState(() {
                                    showImage = true;
                                    imageList = value.data ?? [];
                                  });
                                  ref.refresh(profileProvider).whenData(
                                      (value) => EasyLoading.dismiss());
                                });
                              } catch (e) {
                                EasyLoading.showError(
                                    e.toString().replaceAll("Exception:", ""));
                              }
                            },
                            child: const Icon(
                              IconlyBold.send,
                              color: primaryColor,
                            ),
                          ),
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
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: sizeList.length,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    itemBuilder: (_, i) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = sizeList[i];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: selectedSize == sizeList[i]
                                    ? primaryColor
                                    : Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                            child: Text(
                              sizeList[i],
                              style: isDark
                                  ? kTextStyle.copyWith(
                                      color: selectedSize == sizeList[i]
                                          ? darkTitleColor
                                          : darkGreyTextColor)
                                  : kTextStyle.copyWith(
                                      color: selectedSize == sizeList[i]
                                          ? darkTitleColor
                                          : lightGreyTextColor,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                showImage
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.count(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 10.0,
                          padding:
                              const EdgeInsets.only(bottom: 20.0, top: 10.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                            imageList.length,
                            (i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewImage(
                                        url: Config.webSiteUrl + imageList[i],
                                        title: prompt,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 160,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    Config.webSiteUrl + imageList[i],
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                          SizedBox(height: 4.0,),
                                          Text("Loading Image"),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .15,
                            ),
                            Center(
                              child: Container(
                                height: 146,
                                width: 230,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('images/empty.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              lang.S.of(context).searchTitle,
                              textAlign: TextAlign.center,
                              style: kTextStyle.copyWith(
                                color: lightGreyTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
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
