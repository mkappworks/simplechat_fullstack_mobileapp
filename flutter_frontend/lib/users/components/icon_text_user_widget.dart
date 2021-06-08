import 'package:flutter/material.dart';
import 'package:flutter_frontend/message/components/profile_modal_bottom_sheet.dart';
import 'package:flutter_frontend/model/user.dart';
import 'package:flutter_frontend/utilities/constants.dart';

import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class IconTextUserWidget extends StatelessWidget {
  final User userModel;
  final bool isNameTapEnabled;

  IconTextUserWidget({
    required this.userModel,
    required this.isNameTapEnabled,
  });

  @override
  Widget build(BuildContext context) {
    //getting the first two initials from this.userModel.name and capitalising
    String name = userModel.name;
    List<String> nameparts = name.split(" ");
    String initials =
        nameparts[0][0].toUpperCase() + nameparts[1][0].toUpperCase();

    return Container(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kColorLightBlue,
            ),
            child: Center(
              child: Text(
                initials,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: KColorWhite),
              ),
            ),
          ),
          addHorizontalSpace(13),
          //If the isnameTapedEnabled is passed a true the tap on the Name will trgger 
          //a ModalBottomSheet with Profile information
          GestureDetector(
            onTap: isNameTapEnabled
                ? () => ProfileModalBottomSheet()
                    .onMessageAppBarNameTap(context, initials, userModel)
                : null,
            child: Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
