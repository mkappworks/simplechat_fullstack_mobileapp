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
const String kEmailPlaceHolder = "Please Enter your Email";
const String kNamePlaceHolder = "Please Enter your Name";
const String kAgePlaceHolder = "Please Enter your Age";
const String kGenderPlaceHolder = "Please Enter your Gender";

const String kMessagePlaceHolder = "Type a Message";
const String kSearchPlaceHolder = "Search for a Message";

//App colours
const kColorYellow = Color.fromRGBO(251, 173, 57, 1);
const kColorLightBlue = Color.fromRGBO(57, 160, 251, 1);
const kColorGrey = Colors.grey;
const kColorWhite = Colors.white;
const kColorBlack = Colors.black;

//App themes
const TextTheme kTextThemeDefault = TextTheme(
  headline1:
      TextStyle(color: kColorYellow, fontWeight: FontWeight.w700, fontSize: 28),
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
      TextStyle(color: kColorGrey, fontSize: 18, fontWeight: FontWeight.w400),
  subtitle2:
      TextStyle(color: kColorGrey, fontSize: 14, fontWeight: FontWeight.w400),
);

//TextField Input Decoration
const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  backgroundColor: kColorLightBlue,
  primary: kColorWhite,
  minimumSize: Size(150, 35),
  //padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  ),
);

//backend baseURL
const kBaseURL = "http://localhost:8080";
