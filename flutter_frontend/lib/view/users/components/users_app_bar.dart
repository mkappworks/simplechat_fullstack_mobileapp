import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/message/message_controller.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/view/login/login_screen.dart';

import 'package:flutter_frontend/controller/socket/socket_controller.dart';
import 'package:flutter_frontend/controller/user/user_controller.dart';

import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/constants.dart';

class UsersAppBar extends StatelessWidget {
  final UserController _userController = Get.find();
  final SocketController _socketController = Get.find();
  final MessageController _messageController = Get.find();

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Users',
                style: Theme.of(context).textTheme.headline2,
              ),
              GestureDetector(
                onTap: () async {
                  ////triggers a function that will reset the properties in the UserController and remove the user from the db
                  await _userController.setLogoutUser();
                  //triggers a function that will remove the user from socket room
                  await _socketController.disconnectFromSocket();
                  //triggers a function that will reset the properties in the MessageController
                  _messageController.resetProperties();

                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: Icon(
                  Icons.logout,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        Divider(color: kColorGrey, thickness: 1),
      ],
    );
  }
}
