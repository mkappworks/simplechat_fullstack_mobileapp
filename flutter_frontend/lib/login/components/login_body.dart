import 'package:flutter/material.dart';
import 'package:flutter_frontend/login/components/login_textfield.dart';
import 'package:flutter_frontend/users/users_screen.dart';
import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class LoginBody extends StatelessWidget {
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
              ),
              LoginTextField(
                isEmail: false,
                hintText: kNamePlaceHolder,
              ),
              LoginTextField(
                isEmail: false,
                hintText: kAgePlaceHolder,
              ),
              LoginTextField(
                isEmail: false,
                hintText: kGenderPlaceHolder,
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
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, UsersScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
