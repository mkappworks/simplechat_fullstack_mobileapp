import 'package:flutter/material.dart';


import 'package:flutter_frontend/utilities/size_config.dart';
import 'package:flutter_frontend/utilities/sized_box_functions.dart';

class MessageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //initialise SizeConfig
    SizeConfig().init(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 3),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [addVerticalSpace(10)],
          ),
        ),
      ),
    );
  }
}
