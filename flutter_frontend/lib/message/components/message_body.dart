import 'package:flutter/material.dart';
import 'package:flutter_frontend/message/components/message_app_bar.dart';
import 'package:flutter_frontend/model/user_model.dart';

import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class MessageBody extends StatelessWidget {
  final UserModel userModel;

  MessageBody({required this.userModel});

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [MessageAppBar(userModel: userModel)],
        ),
      ),
    );
  }
}
