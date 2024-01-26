import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_gpt/screen/widgets/constant.dart';
import 'package:chat_gpt/services/config.dart';
import 'package:chat_gpt/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import '../../provider/home_screen_provider.dart';
import '../../services/repositories.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/error_widget.dart';
import '../widgets/loading_widget.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, this.query}) : super(key: key);
  String? query;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _message = '';
  bool isTyping = false;
  bool isNew = false;

  void _saveMessage() {
    setState(() {
      _message = _messageController.text;
    });
  }

  void _clearMessage() {
    setState(() {
      _message = '';
      _messageController.text = '';
    });
  }

  Future<void> _copyToClipboard(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Text Copied'),
    ));
  }

  final ScrollController _controller = ScrollController();

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  final TextEditingController _messageController = TextEditingController();

  generateText() async {
    try {
      await ApiService().getText(widget.query!).then((value) {
        setState(() {
          answer.add(value.data?[0] ?? "");
          isTyping = false;
        });
      });
    } catch (e) {
      setState(() {
        isTyping = false;
      });
      EasyLoading.showError(e.toString().replaceAll("Exception:", ""));
    }
  }

  @override
  void initState() {
    if (widget.query != null) {
      setState(() {
        isTyping = true;
        isNew = true;
      });
      generateText();
      getConnectivity();
      checkInternet();
    }
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
      var profileData = ref.watch(profileProvider);
      return profileData.when(data: (profile) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            elevation: 1.0,
            shadowColor: Theme.of(context).colorScheme.shadow,
            backgroundColor: Theme.of(context).colorScheme.background,
            centerTitle: true,
            iconTheme: IconThemeData(color: isDark?darkTitleColor:lightTitleColor),
            title: TitleText(
              isDark: isDark,
              text: lang.S.of(context).chat,
            ),
          ),
          body: question.isEmpty
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .2,
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
                        Visibility(
                          visible: _message.isEmpty,
                          child: Text(
                            lang.S.of(context).searchTitle,
                            textAlign: TextAlign.center,
                            style: kTextStyle.copyWith(
                              color: lightGreyTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  controller: _controller,
                  reverse: true,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                      itemCount: question.length,
                      itemBuilder: (_, i) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15.0),
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  decoration: const BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                      bottomLeft: Radius.circular(16.0),
                                    ),
                                  ),
                                  child: Text(
                                    question[i],
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: kTextStyle.copyWith(color: darkTitleColor),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: (profile.data?.image ?? "").startsWith("http")
                                        ? const DecorationImage(image: AssetImage("images/no-avatar.png"), fit: BoxFit.cover)
                                        : DecorationImage(image: NetworkImage(Config.webSiteUrl + (profile.data?.image ?? "")), fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: isTyping && i == question.length - 1
                                  ? Lottie.asset("images/typing.json", height: 60.0, width: 80.0)
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        i == question.length - 1 && isNew
                                            ? AnimatedTextKit(
                                                animatedTexts: [TypewriterAnimatedText(answer[i])],
                                                totalRepeatCount: 1,
                                              )
                                            : Text(answer[i]),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _copyToClipboard(answer[i]);
                                                },
                                                child: const Icon(
                                                  Icons.copy,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        );
                      }),
                ),
          bottomNavigationBar: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0,right: 10,bottom: (widget.query??"") == ""? 40 : 10),
              child: TextFormField(
                controller: _messageController,
                onFieldSubmitted: (value) {},
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                cursorColor: isDark ? darkTitleColor : lightTitleColor,
                textInputAction: TextInputAction.next,
                style: TextStyle(color:isDark? Colors.white:Colors.black),
                decoration: kInputDecoration.copyWith(
                  contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  hintText: lang.S.of(context).type,
                  hintStyle: kTextStyle.copyWith(color: isDark ? darkGreyTextColor : lightGreyTextColor),
                  focusColor: kTitleColor,
                  fillColor: Theme.of(context).colorScheme.secondaryContainer,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark ? const Color(0xff363C4D) : primaryColor.withOpacity(0.1)
                        // Theme.of(context).colorScheme.secondaryContainer
                        ,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          if (_messageController.text.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            String query = _messageController.text;
                            setState(() {
                              question.add(query);
                              isTyping = true;
                              isNew = true;
                            });

                            _messageController.clear();
                            if (profile.data!.credits! > 1) {
                              try {
                                await ApiService().getText(query).then((value) {
                                  ref.refresh(profileProvider);
                                  setState(() {
                                    answer.add(value.data?[0] ?? "");
                                    isTyping = false;
                                  });
                                });
                              } catch (e) {
                                setState(() {
                                  question.removeAt(question.length - 1);
                                  isTyping = false;
                                  isNew = false;
                                });
                                EasyLoading.showError(e.toString().replaceAll("Exception:", ""));
                              }
                            } else {
                              setState(() {
                                question.removeAt(question.length - 1);
                                isTyping = false;
                                isNew = false;
                              });
                              EasyLoading.showError("You don't have enough credits");
                            }
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
                    borderSide: BorderSide(color: primaryColor.withOpacity(0.1), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    borderSide: BorderSide(color: primaryColor.withOpacity(0.1), width: 1),
                  ),
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
