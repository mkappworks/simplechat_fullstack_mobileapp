import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/message_controller.dart';
import 'package:flutter_frontend/controller/user_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/routes.dart';

import 'view/login/login_screen.dart';

void main() {
  Get.put(UserController());
  Get.put(MessageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kColorBlack,
        accentColor: KColorWhite,
        textTheme: kTextThemeDefault,
        fontFamily: "Roboto",
      ),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}
