import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../theme/theme.dart';
import 'constant.dart';

class ArrowBack extends StatelessWidget {
  const ArrowBack({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Icon(
        FeatherIcons.chevronLeft,
        color: isDark ? darkIconColor : lightIconColor,
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.isDark,
    required this.text,
  });

  final bool isDark;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kTextStyle.copyWith(
        color: isDark ? darkTitleColor : lightTitleColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
