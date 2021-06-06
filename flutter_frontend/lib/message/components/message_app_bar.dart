import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user_model.dart';
import 'package:flutter_frontend/users/components/icon_text_user_widget.dart';
import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MessageAppBar extends StatelessWidget {
  final UserModel userModel;

  MessageAppBar({required this.userModel});

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
                    child: Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(kArrowLeftSvg),
                    ),
                  ),
                  addHorizontalSpace(13),
                  IconTextUserWidget(
                    userModel: userModel,
                    isNameTapEnabled: true,
                  )
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(kSearchSvg),
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
