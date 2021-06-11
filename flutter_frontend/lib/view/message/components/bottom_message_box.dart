import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_frontend/model/user.dart';

import 'package:flutter_frontend/controller/socket_controller.dart';

import 'package:flutter_frontend/utilities/constants.dart';
import 'package:flutter_frontend/utilities/size_config.dart';

class BottomMessageBox extends HookWidget {
  final User user;

  BottomMessageBox({required this.user});

  @override
  Widget build(BuildContext context) {
    final _focusNode = useFocusNode();
    final _messageTextEditingController = useTextEditingController();

    //initialise SizeConfig
    SizeConfig().init(context);

    return Column(
      children: [
        Divider(color: KColorGrey, thickness: 1),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize! * 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.defaultSize! * 34,
                child: TextField(
                    textAlign: TextAlign.left,
                    focusNode: _focusNode,
                    controller: _messageTextEditingController,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: kMessagePlaceHolder)),
              ),
              GestureDetector(
                onTap: ()  { },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kColorLightBlue,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                        child: SvgPicture.asset(
                      kSendSvg,
                      color: KColorWhite,
                    )),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
