import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const kPrimaryColor = Color(0xFF2CB9B0);
const kTitleColor = Color(0xFF1A1A1A);
const kSubTitleColor = Color(0xFFFD7248);
const kNeutralColor = Color(0xFF484848);
const kLightNeutralColor = Color(0xFF7F7F7F);
const buttonColor = Color(0xffD9D9D9);
const kDarkWhite = Color(0xFFF4F4F4);
const kWhite = Color(0xFFFFFFFF);
const kBorderColorTextField = Color(0xFFE3E3E3);
const ratingBarColor = Color(0xFFFFB33E);
final kTextStyle = GoogleFonts.inter(
  color: kNeutralColor
);

const kButtonDecoration = BoxDecoration(
  color: kPrimaryColor,
  borderRadius: BorderRadius.all(
    Radius.circular(8.0),
  ),
);

LinearGradient primaryGradiant = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF3EE2B9),
    Color(0xFF1CADA4),
  ],
);

InputDecoration kInputDecoration = const InputDecoration(
  hintStyle: TextStyle(color: kLightNeutralColor),
  prefixIconColor: kLightNeutralColor,
  labelStyle: TextStyle(color: kTitleColor),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide.none,
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide:  BorderSide.none,
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

bool isClient = false;
bool isFreelancer = false;
bool isFavorite = false;
const String currencySign = '\$';
bool newSelect = false;
bool isRtl = false;


List<String> question = [];
List<String> answer = [];
List<String> product = [];
List<String> plans = [];
