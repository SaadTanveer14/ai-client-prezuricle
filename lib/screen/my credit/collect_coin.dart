import 'package:chat_gpt/theme/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';
import '../widgets/constant.dart';

class CollectCoin extends StatefulWidget {
  const CollectCoin({super.key});

  @override
  State<CollectCoin> createState() => _CollectCoinState();
}

class _CollectCoinState extends State<CollectCoin> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
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
          text: 'Collect Credit',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: kWhite),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 76.0,
                              width: 76.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                image: const DecorationImage(image: AssetImage('images/image1.png'), fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'MergeBoos for 10s!',
                                  style: kTextStyle.copyWith(
                                    color: isDark ? darkTitleColor : lightTitleColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 2.0),
                                SizedBox(
                                  width: 200,
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Play video and earn ',
                                      style: kTextStyle.copyWith(
                                        color: isDark ? darkGreyTextColor : lightGreyTextColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: '5 Credit! ',
                                          style: kTextStyle.copyWith(
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                SizedBox(
                                  height: 26.0,
                                  width: 93,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                        textStyle: kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.bold),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Play video')),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              itemCount: 200,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
