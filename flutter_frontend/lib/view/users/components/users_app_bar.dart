import 'package:flutter/material.dart';
import 'package:flutter_frontend/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_frontend/view/login/login_screen.dart';

import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/constants.dart';

class UsersAppBar extends StatelessWidget {
  final UserController _userController = Get.find();

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
                  await _userController.setLogoutUser();
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(kExitSvg),
                ),
              ),
            ],
          ),
        ),
        Divider(color: KColorGrey, thickness: 1),
      ],
    );
  }
}
