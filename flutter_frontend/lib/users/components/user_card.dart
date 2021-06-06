import 'package:flutter/material.dart';
import 'package:flutter_frontend/model/user_model.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class UserCard extends StatelessWidget {
  final UserModel userModel;

  const UserCard({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting the first two initials from this.userModel.name and capitalising
    String name = userModel.name;
    List<String> nameparts = name.split(" ");
    String initials =
        nameparts[0][0].toUpperCase() + nameparts[1][0].toUpperCase();

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 3),
          child: Container(
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
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        Divider(color: KColorGrey, thickness: 1),
      ],
    );
  }
}
