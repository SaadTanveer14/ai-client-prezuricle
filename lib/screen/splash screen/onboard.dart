import 'package:chat_gpt/services/const_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../theme/theme.dart';
import '../welcome screen/welcome_screen.dart';
import '../widgets/constant.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  double percent = 0.33;

  List<Map<String, dynamic>> sliderList = [
    {
      "title": 'Welcome to $appsName',
      "description": 'We\'re excited to have you join $appsName a powerful AI-based chatbot designed to help you',
      "icon": onBoard1,
    },
    {
      "title": 'Easy To Use',
      "description": 'We\'re excited to have you join $appsName, a powerful AI-based chatbot designed to help you',
      "icon": onBoard2,
    },
    {
      "title": 'Connect with Experts',
      "description": 'We\'re excited to have you join $appsName a powerful AI-based chatbot designed to help you',
      "icon": onBoard3,
    },
  ];
  List<Map<String, dynamic>> darkSliderList = [
    {
      "title": 'Welcome to $appsName',
      "description": 'We\'re excited to have you join $appsName a powerful AI-based chatbot designed to help you',
      "icon": darkOnboard1,
    },
    {
      "title": 'Easy To Use',
      "description": 'We\'re excited to have you join $appsName, a powerful AI-based chatbot designed to help you',
      "icon": darkOnboard2,
    },
    {
      "title": 'Connect with Experts',
      "description": 'We\'re excited to have you join $appsName a powerful AI-based chatbot designed to help you',
      "icon": darkOnboard3,
    },
  ];

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: PageView.builder(
          itemCount: sliderList.length,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (int index) => setState(() => currentIndexPage = index),
          itemBuilder: (_, i) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 309,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            isDark ?
                            darkSliderList[i]['icon'] : sliderList[i]['icon']
                          ),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        sliderList[i]['title'].toString(),
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(
                          color: isDark ? darkTitleColor : lightTitleColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          sliderList[i]['description'].toString(),
                          style: kTextStyle.copyWith(
                            color: isDark ? darkGreyTextColor : lightGreyTextColor,
                          ),
                          maxLines: 5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const WelComeScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Skip',
                                style: kTextStyle.copyWith(
                                  color: isDark ? darkGreyTextColor : lightGreyTextColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Spacer(),
                            CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 2.0,
                              percent: percent,
                              animation: true,
                              progressColor: primaryColor,
                              circularStrokeCap: CircularStrokeCap.round,
                              backgroundColor: lightGreyTextColor.withOpacity(0.1),
                              center: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      currentIndexPage < 2 ? percent = percent + 0.33 : percent = 1.0;
                                      currentIndexPage < 2
                                          ? pageController.nextPage(
                                              duration: const Duration(microseconds: 3000),
                                              curve: Curves.bounceInOut,
                                            )
                                          : Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const WelComeScreen(),
                                              ),
                                            );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: const Icon(
                                    FeatherIcons.chevronsRight,
                                    color: kWhite,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
