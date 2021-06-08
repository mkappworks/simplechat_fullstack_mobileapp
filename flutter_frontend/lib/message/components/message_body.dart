import 'package:flutter/material.dart';
import 'package:flutter_frontend/message/components/bottom_message_box.dart';
import 'package:flutter_frontend/message/components/message_app_bar.dart';
import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/utilities/size_config.dart';

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
            MessageAppBar(userModel: user),
            Container(
              height: SizeConfig.defaultSize! * 70,
            ),
            BottomMessageBox()
          ],
        ),
      ),
    );
  }
}
