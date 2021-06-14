import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/utilities/constants.dart';

import 'components/users_body.dart';

class UsersScreen extends StatelessWidget {
  //setting the routeName for users screen
  static String routeName = "/users";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: UsersBody(),
      ),
    );
  }
}
