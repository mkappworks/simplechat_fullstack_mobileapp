import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user_model.dart';
import 'package:flutter_frontend/users/components/user_card.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class UserCardList extends StatelessWidget {
  UserCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return dummyUserList.isNotEmpty
        ? Column(children: [
            ...List.generate(dummyUserList.length,
                (index) => UserCard(userModel: dummyUserList[index]))
          ])
        : Column(
            children: [
              addVerticalSpace(SizeConfig.defaultSize! * 30),
              Text(
                'No Users Found!',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          );
  }
}
