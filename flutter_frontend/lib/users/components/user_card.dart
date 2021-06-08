import 'package:flutter/material.dart';
import 'package:flutter_frontend/message/message_screen.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/users/components/icon_text_user_widget.dart';
import 'package:flutter_frontend/users/utilities/user_arguments.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            MessageScreen.routeName,
            arguments: UserArguments(user: user),
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 3),
            child: IconTextUserWidget(
              user: user,
              isNameTapEnabled: false,
            ),
          ),
        ),
        Divider(color: KColorGrey, thickness: 1),
      ],
    );
  }
}
