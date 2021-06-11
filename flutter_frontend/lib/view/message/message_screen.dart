import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/view/users/utilities/user_arguments.dart';

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
      body: MessageBody(user: args.user),
    );
  }
}
