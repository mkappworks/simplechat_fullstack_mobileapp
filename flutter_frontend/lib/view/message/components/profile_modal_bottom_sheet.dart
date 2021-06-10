import 'package:flutter/material.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/view/message/components/profile_modal_bottom_sheet_text.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';

class ProfileModalBottomSheet {
  void onMessageAppBarNameTap(
      BuildContext context, String initials, User user) {
    //initialise SizeConfig
    SizeConfig().init(context);

    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            height: SizeConfig.defaultSize! * 25,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: (SizeConfig.defaultSize! / 0.024 - 75) * 0.5,
                  top: -75 * 0.5,
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kColorLightBlue,
                    ),
                    child: Center(
                      child: Text(
                        initials,
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            ?.copyWith(color: KColorWhite),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: SizeConfig.defaultSize! * 3,
                  child: Container(
                    width: SizeConfig.defaultSize! / 0.024,
                    height: SizeConfig.defaultSize! * 18,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileModalBottomSheetText(value: user.email),
                        ProfileModalBottomSheetText(value: user.name),
                        ProfileModalBottomSheetText(value: user.age),
                        ProfileModalBottomSheetText(value: user.gender),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
