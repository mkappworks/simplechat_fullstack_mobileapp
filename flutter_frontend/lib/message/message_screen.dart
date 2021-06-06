import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/users/utilities/user_arguments.dart';
import 'package:flutter_frontend/utilities/constants.dart';

import 'components/message_body.dart';

class MessageScreen extends StatelessWidget {
  //setting the routeName for message screen
  static String routeName = "/message";

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    return Scaffold(
      backgroundColor: KColorWhite,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: MessageBody(userModel: args.userModel),
      ),
    );
  }
}
