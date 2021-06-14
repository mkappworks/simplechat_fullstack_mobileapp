import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/view/message/message_screen.dart';
import 'package:flutter_frontend/view/users/components/icon_text_user_widget.dart';
import 'package:flutter_frontend/view/users/utilities/user_arguments.dart';

import 'package:flutter_frontend/controller/message/message_controller.dart';
import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';

class UserCard extends StatelessWidget {
  final User user;
  final MessageController _messageController = Get.find();

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await _messageController.fetchMessages(user.id);
            Navigator.pushNamed(
              context,
              MessageScreen.routeName,
              arguments: UserArguments(user: user),
            );
          },
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 3),
            child: IconTextUserWidget(
              user: user,
              isNameTapEnabled: false,
            ),
          ),
        ),
        Divider(color: kColorGrey, thickness: 1),
      ],
    );
  }
}
