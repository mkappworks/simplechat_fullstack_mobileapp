import 'package:flutter/material.dart';

import 'package:flutter_frontend/view/login/components/login_body.dart';

import 'package:flutter_frontend/utilities/constants.dart';

class LoginScreen extends StatelessWidget {
  //setting the routeName for login screen
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: LoginBody(),
      ),
    );
  }
}
