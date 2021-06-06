import 'package:flutter/material.dart';

//Local paths to app icons and images
const kExitSvg = 'assets/icons/exit.svg';
const kArrowLeftSvg = 'assets/icons/left_arrow.svg';
const kSearchSvg = 'assets/icons/search.svg';
const kSendSvg = 'assets/icons/send.svg';

const kSimpleChatLogo = 'assets/images/chat_logo.png';

// Login Form Placeholders
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kInvalidEmailError = "Please Enter Valid Email";
const String kEmailPlaceHolder = "Please Enter your email";
const String kNamelPlaceHolder = "Please Enter your Name";
const String kAgePlaceHolder = "Please Enter your phone number";
const String kGenderPlaceHolder = "Please Enter your address";

//App colours
const kColorYellow = Color.fromRGBO(251, 173, 57, 1);
const kColorLightBlue = Color.fromRGBO(57, 160, 251, 1);
const KColorGrey = Colors.grey;
const KColorWhite = Colors.white;
const kColorBlack = Colors.black;

//App themes
const TextTheme kTextThemeDefault = TextTheme(
  headline1:
      TextStyle(color: kColorBlack, fontWeight: FontWeight.w700, fontSize: 30),
  headline2:
      TextStyle(color: kColorBlack, fontWeight: FontWeight.w700, fontSize: 20),
  headline3:
      TextStyle(color: kColorBlack, fontWeight: FontWeight.w700, fontSize: 18),
  headline4:
      TextStyle(color: kColorBlack, fontWeight: FontWeight.w700, fontSize: 16),
  headline5:
      TextStyle(color: kColorBlack, fontWeight: FontWeight.w700, fontSize: 14),
  headline6:
      TextStyle(color: kColorBlack, fontWeight: FontWeight.w700, fontSize: 12),
  subtitle1:
      TextStyle(color: kColorBlack, fontSize: 18, fontWeight: FontWeight.w400),
  subtitle2:
      TextStyle(color: KColorGrey, fontSize: 14, fontWeight: FontWeight.w400),
);
