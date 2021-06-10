import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/view/users/users_screen.dart';

import 'package:flutter_frontend/controller/user_controller.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

import 'package:flutter_frontend/view/login/components/login_alert.dart';
import 'package:flutter_frontend/view/login/components/login_textfield.dart';

class LoginBody extends StatelessWidget {
  final UserController _userController = Get.find();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _ageTextEditingController =
      TextEditingController();
  final TextEditingController _genderTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

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

                  await _userController.setLoggedUser(userData);

                  if (_userController.getCompletionMessage['status']) {

                        await _userController.setUsersList();
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
