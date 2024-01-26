import 'package:convex_bottom_bar/convex_bottom_bar.dart' as convex;
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../theme/theme.dart';
import '../chat/chat.dart';
import '../image/image.dart';
import '../profile/profile.dart';
import 'home_screen.dart';
import 'package:chat_gpt/generated/l10n.dart' as lang;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPage = 0;
  final _pageNo = [
    const HomeScreen(),
    ChatScreen(),
    const ImageScreen(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: _pageNo[selectedPage],
        bottomNavigationBar: StyleProvider(
          style: Style(),
          child: convex.ConvexAppBar(
            // height: 60,
            // top: -25,
            // curveSize: 80,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            activeColor: primaryColor,
            color: lightGreyTextColor,
            style: convex.TabStyle.react,
            items:  [
              convex.TabItem(
                icon: IconlyBold.home,
                title: lang.S.of(context).signUp,
              ),
              convex.TabItem(
                icon: IconlyBold.chat,
                title: lang.S.of(context).chat,
              ),
              convex.TabItem(icon: IconlyBold.image, title: lang.S.of(context).image),
              convex.TabItem(icon: IconlyBold.profile, title: lang.S.of(context).profile),
            ],
            initialActiveIndex: selectedPage,
            onTap: (int i) {
              setState(() {
                selectedPage = i;
              });
            },
          ),
        ),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 31;

  @override
  double get activeIconMargin => 15;

  @override
  double get iconSize => 25;
  @override
  TextStyle textStyle(Color color,String) {
    return TextStyle(fontSize: 14, color: color);
  }
}
