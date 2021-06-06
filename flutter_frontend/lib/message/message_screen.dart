import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/utilities/constants.dart';

import 'components/message_body.dart';

class MessageScreen extends StatelessWidget {
  //setting the routeName for login screen
  static String routeName = "/message";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColorWhite,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: MessageBody(),
      ),
    );
  }
}
