import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/view/users/users_screen.dart';

import 'package:flutter_frontend/controller/user_controller.dart';
import 'package:flutter_frontend/controller/socket_controller.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

import 'package:flutter_frontend/view/login/components/login_alert.dart';
import 'package:flutter_frontend/view/login/components/login_textfield.dart';

class LoginBody extends HookWidget {
  final UserController _userController = Get.find();
  final SocketController _socketController = Get.find();

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    final _emailTextEditingController = useTextEditingController();
    final _nameTextEditingController = useTextEditingController();
    final _ageTextEditingController = useTextEditingController();
    final _genderTextEditingController = useTextEditingController();

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 3),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              addVerticalSpace(63),
              Image.asset(kSimpleChatLogo),
              addVerticalSpace(35),
              Text('Simple Chat App',
                  style: Theme.of(context).textTheme.headline1),
              addVerticalSpace(35),
              LoginTextField(
                isEmail: true,
                hintText: kEmailPlaceHolder,
                textEditingController: _emailTextEditingController,
              ),
              LoginTextField(
                isEmail: false,
                hintText: kNamePlaceHolder,
                textEditingController: _nameTextEditingController,
              ),
              LoginTextField(
                isEmail: false,
                hintText: kAgePlaceHolder,
                textEditingController: _ageTextEditingController,
              ),
              LoginTextField(
                isEmail: false,
                hintText: kGenderPlaceHolder,
                textEditingController: _genderTextEditingController,
              ),
              addVerticalSpace(34),
              TextButton(
                style: flatButtonStyle,
                child: Text(
                  'Log In',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: KColorWhite),
                ),
                onPressed: () async {
                  //User Data For Service
                  Map<String, dynamic> userData = <String, dynamic>{
                    'email': _emailTextEditingController.text,
                    'name': _nameTextEditingController.text,
                    'age': '_ageTextEditingController.text',
                    'gender': '_genderTextEditingController.text'
                  };

                  //triggers function to save current loggedUser data
                  await _userController.setLoggedUser(userData);

                  if (_userController.getCompletionMessage['status']) {
                    //triggers function to get all other loggedUser data
                    await _userController.setUsersList();
                    //triggers function to connect loggedUser to socket room
                    await _socketController.connectToSocket();
                    Navigator.pushReplacementNamed(
                        context, UsersScreen.routeName);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => LoginAlert(
                              title: 'Login',
                              bodyMessage: _userController
                                  .getCompletionMessage['message'],
                            ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
