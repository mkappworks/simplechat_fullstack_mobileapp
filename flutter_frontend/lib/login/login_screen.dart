import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/utilities/constants.dart';

import 'components/login_body.dart';

class LoginScreen extends StatelessWidget {
  //setting the routeName for login screen
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColorWhite,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: LoginBody(),
      ),
    );
  }
}
