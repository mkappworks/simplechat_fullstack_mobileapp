import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/view/users/components/icon_text_user_widget.dart';

import 'package:flutter_frontend/controller/search/search_controller.dart';
import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class MessageAppBar extends StatelessWidget {
  final User user;
  final SearchController _searchController = Get.find();

  MessageAppBar({required this.user});

  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(
                      CupertinoIcons.arrow_left,
                      size: SizeConfig.defaultSize! * 3,
                    ),
                  ),
                  addHorizontalSpace(SizeConfig.defaultSize! * 1),
                  IconTextUserWidget(
                    user: user,
                    isNameTapEnabled: true,
                  )
                ],
              ),
              GestureDetector(
                  onTap: () => _searchController.setSearchBarStatus(),
                  child: Icon(
                    CupertinoIcons.search,
                    size: SizeConfig.defaultSize! * 3,
                  )),
            ],
          ),
        ),
        Divider(color: kColorGrey, thickness: 1),
      ],
    );
  }
}
