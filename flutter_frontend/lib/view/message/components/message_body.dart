import 'package:flutter/material.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/view/message/components/message_text_field.dart';
import 'package:flutter_frontend/view/message/components/message_app_bar.dart';

import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/view/message/components/message_view.dart';

class MessageBody extends StatelessWidget {
  final User user;

  MessageBody({required this.user});

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return SafeArea(
      child: Container(
        child: Column(
          children: [
            MessageAppBar(user: user),
            MessageView(receiverID: user.id),
            MessageTextField(user: user)
          ],
        ),
      ),
    );
  }
}
