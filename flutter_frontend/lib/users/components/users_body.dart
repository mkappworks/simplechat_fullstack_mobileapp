import 'package:flutter/material.dart';

import 'package:flutter_frontend/users/components/user_card_list.dart';
import 'package:flutter_frontend/users/components/users_app_bar.dart';

import 'package:flutter_frontend/utilities/size_config.dart';

class UsersBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UsersAppBar(),
            UserCardList(),
          ],
        ),
      ),
    );
  }
}
