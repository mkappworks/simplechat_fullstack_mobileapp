import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/view/users/components/icon_text_user_widget.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class MessageAppBar extends StatelessWidget {
  final User user;

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
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.arrow_left,
                      size: 35,
                    ),
                  ),
                  addHorizontalSpace(13),
                  IconTextUserWidget(
                    user: user,
                    isNameTapEnabled: true,
                  )
                ],
              ),
              GestureDetector(
                  onTap: () {},
                  child: Icon(
                    CupertinoIcons.search,
                    size: 35,
                  )),
            ],
          ),
        ),
        Divider(color: KColorGrey, thickness: 1),
      ],
    );
  }
}
