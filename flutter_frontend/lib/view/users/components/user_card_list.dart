import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/view/users/components/user_card.dart';

import 'package:flutter_frontend/controller/user_controller.dart';

import 'package:flutter_frontend/utilities/size_config.dart';

class UserCardList extends StatelessWidget {
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);
    
    //depending on the ListStatus which can be loading or loaded or empty from UserController the respective widgets are returned
    switch (_userController.getStatus.value) {
      case ListStatus.loading:
        return Center(child: CircularProgressIndicator());
      case ListStatus.loaded:
        return Obx(() { 
          RxList<User> _usersList = _userController.getUsersList;
          return Column(children: [
            ...List.generate(
                _usersList.length, (index) => UserCard(user: _usersList[index]))
          ]);
        });
      case ListStatus.empty:
        return Column(
          children: [
            //addVerticalSpace(SizeConfig.defaultSize! * 30),
            Center(
              child: Text(
                'No Users Found!',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        );

      default:
        return Container();
    }
  }
}
